<?php

namespace Tests\Feature;

use App\Models\Pedido;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

class PedidoTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    private function pagar($pedido, $aprovado = '1')
    {
        return $this->post('/pedidos/'.$pedido->id.'/pagamento', [
            'metodo_pagamento' => 'PIX',
            'aprovado' => $aprovado,
        ]);
    }

    public function test_inicio_abre_pedidos()
    {
        $this->get('/')->assertRedirect('/pedidos');
    }

    public function test_lista_e_filtro_por_status()
    {
        $ana = $this->criarCliente(['nome' => 'Ana Recebido']);
        $bruno = $this->criarCliente(['nome' => 'Bruno Cancelado']);
        $this->criarPedido($this->criarEndereco($ana));
        $cancelado = $this->criarPedido($this->criarEndereco($bruno));
        $cancelado->update(['status' => 'CANCELADO']);

        $resposta = $this->get('/pedidos');
        $resposta->assertOk();
        $resposta->assertSee('Ana Recebido');
        $resposta->assertSee('Bruno Cancelado');

        $resposta = $this->get('/pedidos?status=CANCELADO');
        $resposta->assertSee('Bruno Cancelado');
        $resposta->assertDontSee('Ana Recebido');
    }

    public function test_tela_de_novo_pedido()
    {
        $this->criarProduto(['nome' => 'Lanche Disponivel']);
        $this->criarProduto(['nome' => 'Lanche Esgotado', 'disponivel' => false]);
        $this->criarEndereco($this->criarCliente(['nome' => 'Cliente Ativo']));
        $this->criarEndereco($this->criarCliente(['nome' => 'Cliente Inativo', 'ativo' => false]));

        $resposta = $this->get('/pedidos/create');
        $resposta->assertOk();
        $resposta->assertSee('Lanche Disponivel');
        $resposta->assertDontSee('Lanche Esgotado');
        $resposta->assertSee('Cliente Ativo');
        $resposta->assertDontSee('Cliente Inativo');
    }

    public function test_criar_pedido()
    {
        $bairro = $this->criarBairro('Batel', 8);
        $endereco = $this->criarEndereco(null, ['bairro' => $bairro->bairro]);
        $lanche = $this->criarProduto(['preco' => 25]);
        $bacon = $this->criarIngrediente(['preco_adicional' => 4]);

        $resposta = $this->post('/pedidos', [
            'endereco_id' => $endereco->id,
            'observacoes' => 'Sem cebola',
            'itens' => [
                [
                    'produto_id' => $lanche->id,
                    'quantidade' => 2,
                    'adicionais' => [['ingrediente_id' => $bacon->id, 'quantidade' => 1]],
                ],
            ],
        ]);

        $pedido = Pedido::first();
        $resposta->assertRedirect('/pedidos/'.$pedido->id);

        $this->assertEquals('RECEBIDO', $pedido->status);
        $this->assertEquals($endereco->cliente_id, $pedido->cliente_id);
        $this->assertEquals('Sem cebola', $pedido->observacoes);
        // 2x25 + 4 adicional
        $this->assertEquals(54, $pedido->subtotal);
        $this->assertEquals(8, $pedido->taxa_entrega);
        $this->assertEquals(62, $pedido->valor_total);
        $this->assertDatabaseHas('itens_pedido', [
            'pedido_id' => $pedido->id,
            'quantidade' => 2,
            'preco_unitario' => 25,
            'subtotal_item' => 50,
        ]);
    }

    public function test_criar_pedido_com_cupom()
    {
        $this->criarCupom(['codigo' => 'BAHA5', 'tipo_desconto' => 'VALOR_FIXO', 'valor_desconto' => 5]);

        $resposta = $this->post('/pedidos', [
            'endereco_id' => $this->criarEndereco()->id,
            'codigo_cupom' => 'baha5',
            'itens' => [['produto_id' => $this->criarProduto()->id, 'quantidade' => 2]],
        ]);
        $resposta->assertSessionHasNoErrors();

        $pedido = Pedido::first();
        $this->assertEquals(5, $pedido->valor_desconto);
        $this->assertEquals(40, $pedido->valor_total);
    }

    public function test_ignora_linhas_em_branco()
    {
        $resposta = $this->post('/pedidos', [
            'endereco_id' => $this->criarEndereco()->id,
            'itens' => [
                ['produto_id' => $this->criarProduto()->id, 'quantidade' => 1, 'adicionais' => [['ingrediente_id' => '']]],
                ['produto_id' => '', 'quantidade' => ''],
            ],
        ]);
        $resposta->assertSessionHasNoErrors();

        $this->assertDatabaseCount('itens_pedido', 1);
        $this->assertDatabaseCount('item_adicionais', 0);
    }

    public function test_pedido_sem_itens()
    {
        $resposta = $this->post('/pedidos', ['endereco_id' => $this->criarEndereco()->id, 'itens' => []]);

        $resposta->assertSessionHasErrors('itens');
        $this->assertDatabaseCount('pedidos', 0);
    }

    public function test_quantidade_e_endereco_invalidos()
    {
        $resposta = $this->post('/pedidos', [
            'endereco_id' => 999999,
            'itens' => [['produto_id' => $this->criarProduto()->id, 'quantidade' => 0]],
        ]);

        $resposta->assertSessionHasErrors(['endereco_id', 'itens.0.quantidade']);
    }

    public function test_produto_indisponivel()
    {
        $esgotado = $this->criarProduto(['nome' => 'X-Esgotado', 'disponivel' => false]);

        $resposta = $this->from('/pedidos/create')->post('/pedidos', [
            'endereco_id' => $this->criarEndereco()->id,
            'itens' => [
                ['produto_id' => $this->criarProduto()->id, 'quantidade' => 1],
                ['produto_id' => $esgotado->id, 'quantidade' => 1],
            ],
        ]);

        $resposta->assertRedirect('/pedidos/create');
        $resposta->assertSessionHas('erro', 'O produto X-Esgotado está indisponível.');
        // rollback desfaz tudo
        $this->assertDatabaseCount('pedidos', 0);
        $this->assertDatabaseCount('itens_pedido', 0);
    }

    public function test_adicional_indisponivel()
    {
        $cheddar = $this->criarIngrediente(['nome' => 'Cheddar', 'disponivel' => false]);

        $resposta = $this->from('/pedidos/create')->post('/pedidos', [
            'endereco_id' => $this->criarEndereco()->id,
            'itens' => [
                ['produto_id' => $this->criarProduto()->id, 'quantidade' => 1, 'adicionais' => [['ingrediente_id' => $cheddar->id]]],
            ],
        ]);

        $resposta->assertSessionHas('erro', 'O adicional Cheddar está indisponível.');
        $this->assertDatabaseCount('pedidos', 0);
    }

    public function test_cliente_inativo()
    {
        $cliente = $this->criarCliente(['ativo' => false]);

        $resposta = $this->from('/pedidos/create')->post('/pedidos', [
            'endereco_id' => $this->criarEndereco($cliente)->id,
            'itens' => [['produto_id' => $this->criarProduto()->id, 'quantidade' => 1]],
        ]);

        $resposta->assertSessionHas('erro', 'Cliente inativo não pode fazer pedidos.');
        $this->assertDatabaseCount('pedidos', 0);
    }

    public function test_cupom_invalido_ao_criar()
    {
        $resposta = $this->from('/pedidos/create')->post('/pedidos', [
            'endereco_id' => $this->criarEndereco()->id,
            'codigo_cupom' => 'NAOEXISTE',
            'itens' => [['produto_id' => $this->criarProduto()->id, 'quantidade' => 1]],
        ]);

        $resposta->assertSessionHas('erro', 'Cupom NAOEXISTE não encontrado');
        $this->assertDatabaseCount('pedidos', 0);
    }

    public function test_detalhe_do_pedido()
    {
        $cliente = $this->criarCliente(['nome' => 'Carla Detalhe']);
        $pedido = $this->criarPedido($this->criarEndereco($cliente));

        $resposta = $this->get('/pedidos/'.$pedido->id);
        $resposta->assertOk();
        $resposta->assertSee('Carla Detalhe');
        $resposta->assertSee('X-Burguer');
    }

    public function test_aplicar_cupom()
    {
        $this->criarCupom(['codigo' => 'DESC10']);
        $pedido = $this->criarPedido();

        $resposta = $this->post('/pedidos/'.$pedido->id.'/cupom', ['codigo_cupom' => 'DESC10']);

        $resposta->assertRedirect('/pedidos/'.$pedido->id);
        $resposta->assertSessionHas('sucesso', 'Cupom aplicado.');
        $this->assertEquals(41, $pedido->fresh()->valor_total);
    }

    public function test_aplicar_cupom_sem_codigo()
    {
        $pedido = $this->criarPedido();

        $this->post('/pedidos/'.$pedido->id.'/cupom', [])->assertSessionHasErrors('codigo_cupom');
    }

    public function test_pagamento_aprovado()
    {
        $pedido = $this->criarPedido();

        $resposta = $this->pagar($pedido);

        $resposta->assertRedirect('/pedidos/'.$pedido->id);
        $this->assertEquals('EM_PREPARO', $pedido->fresh()->status);
        $this->assertDatabaseHas('pagamentos', [
            'pedido_id' => $pedido->id,
            'metodo_pagamento' => 'PIX',
            'status_pagamento' => 'APROVADO',
            'valor' => 45,
        ]);
    }

    public function test_pagamento_recusado()
    {
        $pedido = $this->criarPedido();

        $this->pagar($pedido, '0');

        $pedido->refresh();
        $this->assertEquals('CANCELADO', $pedido->status);
        $this->assertEquals('RECUSADO', $pedido->pagamento->status_pagamento);
    }

    public function test_nao_paga_duas_vezes()
    {
        $pedido = $this->criarPedido();
        $this->pagar($pedido);

        $resposta = $this->from('/pedidos/'.$pedido->id)->post('/pedidos/'.$pedido->id.'/pagamento', [
            'metodo_pagamento' => 'PIX',
            'aprovado' => '1',
        ]);

        $resposta->assertSessionHas('erro', 'Este pedido não está aguardando pagamento.');
        $this->assertDatabaseCount('pagamentos', 1);
    }

    public function test_metodo_de_pagamento_invalido()
    {
        $pedido = $this->criarPedido();

        $resposta = $this->post('/pedidos/'.$pedido->id.'/pagamento', ['metodo_pagamento' => 'BITCOIN', 'aprovado' => '1']);

        $resposta->assertSessionHasErrors('metodo_pagamento');
        $this->assertDatabaseCount('pagamentos', 0);
    }

    public function test_avancar_status_ate_entregue()
    {
        $pedido = $this->criarPedido();
        $this->pagar($pedido);

        $this->post('/pedidos/'.$pedido->id.'/avancar-status');
        $this->assertEquals('PRONTO', $pedido->fresh()->status);

        $this->post('/pedidos/'.$pedido->id.'/avancar-status');
        $this->assertEquals('SAIU_PARA_ENTREGA', $pedido->fresh()->status);

        $this->post('/pedidos/'.$pedido->id.'/avancar-status');
        $this->assertEquals('ENTREGUE', $pedido->fresh()->status);

        $resposta = $this->from('/pedidos/'.$pedido->id)->post('/pedidos/'.$pedido->id.'/avancar-status');
        $resposta->assertSessionHas('erro', 'O status ENTREGUE não pode avançar por esta ação.');
    }

    public function test_nao_avanca_sem_pagamento()
    {
        $pedido = $this->criarPedido();

        $resposta = $this->from('/pedidos/'.$pedido->id)->post('/pedidos/'.$pedido->id.'/avancar-status');

        $resposta->assertSessionHas('erro', 'O status RECEBIDO não pode avançar por esta ação.');
        $this->assertEquals('RECEBIDO', $pedido->fresh()->status);
    }

    public function test_cancelar_pedido_pago()
    {
        $pedido = $this->criarPedido();
        $this->pagar($pedido);

        $resposta = $this->post('/pedidos/'.$pedido->id.'/cancelar');

        $resposta->assertSessionHas('sucesso', 'Pedido cancelado.');
        $pedido->refresh();
        $this->assertEquals('CANCELADO', $pedido->status);
        $this->assertEquals('ESTORNADO', $pedido->pagamento->status_pagamento);
    }

    public function test_nao_cancela_pedido_entregue()
    {
        $pedido = $this->criarPedido();
        $pedido->update(['status' => 'ENTREGUE']);

        $resposta = $this->from('/pedidos/'.$pedido->id)->post('/pedidos/'.$pedido->id.'/cancelar');

        $resposta->assertSessionHas('erro', 'Pedido '.$pedido->id.' já está encerrado (ENTREGUE)');
        $this->assertEquals('ENTREGUE', $pedido->fresh()->status);
    }
}
