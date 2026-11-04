<?php

namespace Tests\Feature\Api;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

class ProdutoApiTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    public function test_listar()
    {
        $categoria = $this->criarCategoria(['nome' => 'Lanches']);
        $this->criarProduto(['nome' => 'X-Bacon', 'categoria_id' => $categoria->id]);

        $resposta = $this->getJson('/api/produtos');

        $resposta->assertOk();
        $resposta->assertJsonStructure([
            'data' => [['id', 'nome', 'descricao', 'preco', 'custo_producao', 'disponivel', 'categoria_id', 'categoria', 'criado_em', 'atualizado_em']],
            'links',
            'meta',
        ]);
        $resposta->assertJsonPath('data.0.nome', 'X-Bacon');
        $resposta->assertJsonPath('data.0.categoria', 'Lanches');
        $resposta->assertJsonPath('data.0.preco', 20);
    }

    public function test_mostrar()
    {
        $produto = $this->criarProduto(['nome' => 'Batata Frita', 'preco' => 15.50]);

        $resposta = $this->getJson('/api/produtos/'.$produto->id);

        $resposta->assertOk();
        $resposta->assertJsonPath('data.id', $produto->id);
        $resposta->assertJsonPath('data.preco', 15.5);
    }

    public function test_produto_que_nao_existe()
    {
        $this->getJson('/api/produtos/999999')->assertStatus(404);
    }

    public function test_criar()
    {
        $resposta = $this->postJson('/api/produtos', [
            'categoria_id' => $this->criarCategoria()->id,
            'nome' => 'Suco de Laranja',
            'preco' => 9,
            'custo_producao' => 3,
        ]);

        $resposta->assertStatus(201);
        $resposta->assertJsonPath('data.nome', 'Suco de Laranja');
        $this->assertDatabaseHas('produtos', ['nome' => 'Suco de Laranja', 'disponivel' => true]);
    }

    public function test_criar_com_dados_errados()
    {
        $resposta = $this->postJson('/api/produtos', ['nome' => '', 'preco' => 'abc']);

        $resposta->assertStatus(422);
        $resposta->assertJsonValidationErrors(['categoria_id', 'nome', 'preco', 'custo_producao']);
    }

    public function test_patch_manda_so_um_campo()
    {
        $produto = $this->criarProduto(['nome' => 'Pastel']);

        $resposta = $this->patchJson('/api/produtos/'.$produto->id, ['disponivel' => false]);

        $resposta->assertOk();
        $resposta->assertJsonPath('data.nome', 'Pastel');
        $resposta->assertJsonPath('data.disponivel', false);
    }

    public function test_put_precisa_de_tudo()
    {
        $produto = $this->criarProduto();

        $resposta = $this->putJson('/api/produtos/'.$produto->id, ['disponivel' => false]);

        $resposta->assertStatus(422);
        $resposta->assertJsonValidationErrors(['categoria_id', 'nome', 'preco', 'custo_producao']);
    }

    public function test_excluir()
    {
        $produto = $this->criarProduto();

        $this->deleteJson('/api/produtos/'.$produto->id)->assertStatus(204);

        $this->assertDatabaseMissing('produtos', ['id' => $produto->id]);
    }

    public function test_excluir_produto_vendido()
    {
        $produto = $this->criarProduto();
        $this->criarPedido(null, [['produto_id' => $produto->id, 'quantidade' => 1]]);

        $resposta = $this->deleteJson('/api/produtos/'.$produto->id);

        $resposta->assertStatus(409);
        $resposta->assertJsonPath('message', 'Produto já vendido não pode ser excluído. Marque-o como indisponível.');
        $this->assertDatabaseHas('produtos', ['id' => $produto->id]);
    }
}
