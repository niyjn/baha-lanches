<?php

namespace Tests\Feature;

use App\Models\Produto;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

class ProdutoTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    private function dados($mudar = [])
    {
        return array_merge([
            'categoria_id' => $this->criarCategoria()->id,
            'nome' => 'X-Salada',
            'descricao' => 'Pão, carne, queijo e salada',
            'preco' => 22.90,
            'custo_producao' => 9.50,
            'disponivel' => '1',
        ], $mudar);
    }

    public function test_lista_produtos()
    {
        $this->criarProduto(['nome' => 'Hot Dog']);

        $this->get('/produtos')->assertOk()->assertSee('Hot Dog');
    }

    public function test_telas_de_produto_abrem()
    {
        $produto = $this->criarProduto(['nome' => 'Misto Quente']);

        $this->get('/produtos/create')->assertOk();
        $this->get('/produtos/'.$produto->id)->assertOk()->assertSee('Misto Quente');
        $this->get('/produtos/'.$produto->id.'/edit')->assertOk()->assertSee('Misto Quente');
    }

    public function test_criar_produto()
    {
        $resposta = $this->post('/produtos', $this->dados());

        $produto = Produto::first();
        $resposta->assertRedirect('/produtos/'.$produto->id);
        $resposta->assertSessionHas('sucesso', 'Produto criado.');
        $this->assertEquals('X-Salada', $produto->nome);
        $this->assertEquals(22.90, $produto->preco);
        $this->assertTrue($produto->disponivel);
    }

    public function test_campos_obrigatorios_e_preco_negativo()
    {
        $this->post('/produtos', [])->assertSessionHasErrors(['categoria_id', 'nome', 'preco', 'custo_producao']);

        $resposta = $this->post('/produtos', $this->dados(['preco' => -1, 'categoria_id' => 999999]));
        $resposta->assertSessionHasErrors(['preco', 'categoria_id']);

        $this->assertDatabaseCount('produtos', 0);
    }

    public function test_editar_produto()
    {
        $produto = $this->criarProduto();

        $resposta = $this->put('/produtos/'.$produto->id, $this->dados(['nome' => 'X-Tudo', 'preco' => 30, 'disponivel' => '0']));

        $resposta->assertRedirect('/produtos/'.$produto->id);
        $produto->refresh();
        $this->assertEquals('X-Tudo', $produto->nome);
        $this->assertEquals(30, $produto->preco);
        $this->assertFalse($produto->disponivel);
    }

    public function test_excluir_produto()
    {
        $produto = $this->criarProduto();

        $resposta = $this->delete('/produtos/'.$produto->id);

        $resposta->assertRedirect('/produtos');
        $resposta->assertSessionHas('sucesso', 'Produto excluído.');
        $this->assertDatabaseMissing('produtos', ['id' => $produto->id]);
    }

    public function test_nao_exclui_produto_vendido()
    {
        $produto = $this->criarProduto();
        $this->criarPedido(null, [['produto_id' => $produto->id, 'quantidade' => 1]]);

        $resposta = $this->from('/produtos/'.$produto->id)->delete('/produtos/'.$produto->id);

        $resposta->assertRedirect('/produtos/'.$produto->id);
        $resposta->assertSessionHas('erro', 'Produto já vendido não pode ser excluído. Marque-o como indisponível.');
        $this->assertDatabaseHas('produtos', ['id' => $produto->id]);
    }
}
