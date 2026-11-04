<?php

namespace Tests\Feature;

use App\Models\Categoria;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

class CategoriaTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    public function test_lista_na_ordem_de_exibicao()
    {
        $this->criarCategoria(['nome' => 'Bebidas', 'ordem_exibicao' => 2]);
        $this->criarCategoria(['nome' => 'Lanches', 'ordem_exibicao' => 1]);

        $this->get('/categorias')->assertOk()->assertSeeInOrder(['Lanches', 'Bebidas']);
    }

    public function test_criar_e_editar_categoria()
    {
        $this->get('/categorias/create')->assertOk();

        $resposta = $this->post('/categorias', ['nome' => 'Porções', 'ordem_exibicao' => 3, 'ativo' => '1']);
        $resposta->assertRedirect('/categorias');
        $resposta->assertSessionHas('sucesso', 'Categoria criada.');

        $categoria = Categoria::first();
        $this->get('/categorias/'.$categoria->id.'/edit')->assertOk()->assertSee('Porções');

        $resposta = $this->put('/categorias/'.$categoria->id, ['nome' => 'Porções', 'ordem_exibicao' => 4, 'ativo' => '0']);
        $resposta->assertSessionHasNoErrors();

        $categoria->refresh();
        $this->assertEquals(4, $categoria->ordem_exibicao);
        $this->assertFalse($categoria->ativo);
    }

    public function test_nome_repetido_e_ordem_zero()
    {
        $this->criarCategoria(['nome' => 'Lanches']);

        $resposta = $this->post('/categorias', ['nome' => 'Lanches', 'ordem_exibicao' => 0, 'ativo' => '1']);

        $resposta->assertSessionHasErrors(['nome', 'ordem_exibicao']);
    }

    public function test_excluir_categoria_vazia()
    {
        $categoria = $this->criarCategoria();

        $this->delete('/categorias/'.$categoria->id)->assertSessionHas('sucesso', 'Categoria excluída.');

        $this->assertDatabaseMissing('categorias', ['id' => $categoria->id]);
    }

    public function test_nao_exclui_categoria_com_produto()
    {
        $categoria = $this->criarCategoria();
        $this->criarProduto(['categoria_id' => $categoria->id]);

        $resposta = $this->from('/categorias')->delete('/categorias/'.$categoria->id);

        $resposta->assertSessionHas('erro', 'Categoria com produtos não pode ser excluída. Desative-a.');
        $this->assertDatabaseHas('categorias', ['id' => $categoria->id]);
    }
}
