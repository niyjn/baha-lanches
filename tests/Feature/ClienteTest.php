<?php

namespace Tests\Feature;

use App\Models\Cliente;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

class ClienteTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    private function dados($mudar = [])
    {
        return array_merge([
            'nome' => 'Maria Souza',
            'email' => 'maria@teste.com',
            'telefone' => '(42) 98888-7777',
            'cpf' => '123.456.789-00',
            'data_nascimento' => '1995-04-20',
            'ativo' => '1',
        ], $mudar);
    }

    public function test_telas_de_cliente_abrem()
    {
        $cliente = $this->criarCliente(['nome' => 'João Lista']);
        $endereco = $this->criarEndereco($cliente, ['logradouro' => 'Rua Saldanha Marinho']);
        $this->criarPedido($endereco);

        $this->get('/clientes')->assertOk()->assertSee('João Lista');
        $this->get('/clientes/'.$cliente->id)->assertOk()->assertSee('Rua Saldanha Marinho');
        $this->get('/clientes/create')->assertOk();
        $this->get('/clientes/'.$cliente->id.'/edit')->assertOk();
    }

    public function test_criar_cliente()
    {
        $resposta = $this->post('/clientes', $this->dados());

        $cliente = Cliente::first();
        $resposta->assertRedirect('/clientes/'.$cliente->id);
        $resposta->assertSessionHas('sucesso', 'Cliente criado. Cadastre um endereço.');
        $this->assertEquals('maria@teste.com', $cliente->email);
        $this->assertTrue($cliente->ativo);
    }

    public function test_cpf_sem_formatacao()
    {
        $this->post('/clientes', $this->dados(['cpf' => '12345678900']))->assertSessionHasErrors('cpf');
    }

    public function test_email_e_cpf_repetidos()
    {
        $this->criarCliente(['email' => 'maria@teste.com', 'cpf' => '123.456.789-00']);

        $this->post('/clientes', $this->dados())->assertSessionHasErrors(['email', 'cpf']);

        $this->assertDatabaseCount('clientes', 1);
    }

    public function test_nascimento_no_futuro()
    {
        $amanha = now()->addDay()->format('Y-m-d');

        $this->post('/clientes', $this->dados(['data_nascimento' => $amanha]))->assertSessionHasErrors('data_nascimento');
    }

    public function test_editar_cliente()
    {
        $cliente = $this->criarCliente(['email' => 'maria@teste.com', 'cpf' => '123.456.789-00']);

        $resposta = $this->put('/clientes/'.$cliente->id, $this->dados(['nome' => 'Maria S. Lima', 'ativo' => '0']));

        $resposta->assertSessionHasNoErrors();
        $resposta->assertRedirect('/clientes/'.$cliente->id);
        $cliente->refresh();
        $this->assertEquals('Maria S. Lima', $cliente->nome);
        $this->assertFalse($cliente->ativo);
    }

    public function test_excluir_cliente_apaga_enderecos()
    {
        $cliente = $this->criarCliente();
        $endereco = $this->criarEndereco($cliente);

        $resposta = $this->delete('/clientes/'.$cliente->id);

        $resposta->assertRedirect('/clientes');
        $resposta->assertSessionHas('sucesso', 'Cliente excluído.');
        $this->assertDatabaseMissing('clientes', ['id' => $cliente->id]);
        $this->assertDatabaseMissing('enderecos', ['id' => $endereco->id]);
    }

    public function test_nao_exclui_cliente_com_pedido()
    {
        $cliente = $this->criarCliente();
        $this->criarPedido($this->criarEndereco($cliente));

        $resposta = $this->from('/clientes/'.$cliente->id)->delete('/clientes/'.$cliente->id);

        $resposta->assertSessionHas('erro', 'Cliente com pedidos não pode ser excluído. Desative-o.');
        $this->assertDatabaseHas('clientes', ['id' => $cliente->id]);
    }
}
