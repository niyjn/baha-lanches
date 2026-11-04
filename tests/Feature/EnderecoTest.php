<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

class EnderecoTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    private function dados($mudar = [])
    {
        $this->criarBairro('Centro');

        return array_merge([
            'logradouro' => 'Rua Guaíra',
            'numero' => '250',
            'complemento' => 'Apto 3',
            'bairro' => 'Centro',
            'cep' => '85010-100',
            'e_principal' => '1',
        ], $mudar);
    }

    public function test_telas_mostram_os_bairros()
    {
        $this->criarBairro('Trianon');
        $endereco = $this->criarEndereco();

        $this->get('/clientes/'.$endereco->cliente_id.'/enderecos/create')->assertOk()->assertSee('Trianon');
        $this->get('/enderecos/'.$endereco->id.'/edit')->assertOk()->assertSee('Trianon');
    }

    public function test_criar_endereco_em_guarapuava()
    {
        $cliente = $this->criarCliente();

        $resposta = $this->post('/clientes/'.$cliente->id.'/enderecos', $this->dados());

        $resposta->assertRedirect('/clientes/'.$cliente->id);
        $resposta->assertSessionHas('sucesso', 'Endereço criado.');
        $endereco = $cliente->enderecos()->first();
        $this->assertEquals('Guarapuava', $endereco->cidade);
        $this->assertEquals('PR', $endereco->estado);
        $this->assertTrue($endereco->e_principal);
    }

    public function test_bairro_e_cep_invalidos()
    {
        $cliente = $this->criarCliente();

        $resposta = $this->post('/clientes/'.$cliente->id.'/enderecos', $this->dados(['bairro' => 'Curitiba', 'cep' => '85010100']));

        $resposta->assertSessionHasErrors(['bairro', 'cep']);
        $this->assertDatabaseCount('enderecos', 0);
    }

    public function test_novo_principal_tira_o_antigo()
    {
        $cliente = $this->criarCliente();
        $antigo = $this->criarEndereco($cliente, ['e_principal' => true]);

        $this->post('/clientes/'.$cliente->id.'/enderecos', $this->dados(['e_principal' => '1']))->assertSessionHasNoErrors();

        $this->assertFalse($antigo->fresh()->e_principal);
        $this->assertEquals(1, $cliente->enderecos()->where('e_principal', true)->count());
    }

    public function test_editar_endereco()
    {
        $endereco = $this->criarEndereco();

        $resposta = $this->put('/enderecos/'.$endereco->id, $this->dados(['numero' => '999']));

        $resposta->assertRedirect('/clientes/'.$endereco->cliente_id);
        $this->assertEquals('999', $endereco->fresh()->numero);
    }

    public function test_nao_edita_endereco_com_pedido()
    {
        $endereco = $this->criarEndereco();
        $this->criarPedido($endereco);

        $resposta = $this->from('/enderecos/'.$endereco->id.'/edit')->put('/enderecos/'.$endereco->id, $this->dados(['numero' => '999']));

        $resposta->assertSessionHas('erro', 'Endereço já usado em pedidos não pode ser alterado. Cadastre um novo.');
        $this->assertEquals('100', $endereco->fresh()->numero);
    }

    public function test_endereco_com_pedido_pode_virar_principal()
    {
        $endereco = $this->criarEndereco();
        $this->criarPedido($endereco);

        // msm dados, so muda e_principal
        $dados = $endereco->only(['logradouro', 'numero', 'complemento', 'bairro', 'cep', 'ponto_referencia']);
        $dados['e_principal'] = '1';

        $resposta = $this->put('/enderecos/'.$endereco->id, $dados);

        $resposta->assertSessionHasNoErrors();
        $resposta->assertSessionHas('sucesso', 'Endereço atualizado.');
        $this->assertTrue($endereco->fresh()->e_principal);
    }

    public function test_excluir_endereco()
    {
        $endereco = $this->criarEndereco();

        $this->delete('/enderecos/'.$endereco->id)->assertRedirect('/clientes/'.$endereco->cliente_id);

        $this->assertDatabaseMissing('enderecos', ['id' => $endereco->id]);
    }

    public function test_nao_exclui_endereco_com_pedido()
    {
        $endereco = $this->criarEndereco();
        $this->criarPedido($endereco);

        $resposta = $this->from('/clientes/'.$endereco->cliente_id)->delete('/enderecos/'.$endereco->id);

        $resposta->assertSessionHas('erro', 'Endereço já usado em pedidos não pode ser excluído.');
        $this->assertDatabaseHas('enderecos', ['id' => $endereco->id]);
    }
}
