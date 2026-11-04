<?php

namespace Tests\Feature\Banco;

use App\Models\Pedido;
use Illuminate\Database\QueryException;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

// triggers e indices do 02_objetos.sql
class TriggersBancoTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    public function test_novo_item_atualiza_o_total()
    {
        $pedido = $this->criarPedido();
        $refri = $this->criarProduto(['nome' => 'Refrigerante', 'preco' => 6]);

        $pedido->itens()->create([
            'produto_id' => $refri->id,
            'quantidade' => 3,
            'preco_unitario' => 6,
            'subtotal_item' => 18,
        ]);

        $pedido->refresh();
        $this->assertEquals(58, $pedido->subtotal);
        $this->assertEquals(63, $pedido->valor_total);
    }

    public function test_adicional_e_exclusao_de_item_atualizam_o_total()
    {
        $pedido = $this->criarPedido();
        $item = $pedido->itens()->first();
        $bacon = $this->criarIngrediente();

        $item->adicionais()->create(['ingrediente_id' => $bacon->id, 'quantidade' => 2, 'preco_unitario' => 3]);
        $this->assertEquals(46, $pedido->fresh()->subtotal);

        $item->delete();

        $pedido->refresh();
        $this->assertEquals(0, $pedido->subtotal);
        $this->assertEquals(5, $pedido->valor_total);
    }

    public function test_desconto_recalcula_quando_muda_item()
    {
        $this->criarCupom([
            'codigo' => 'MINIMO30',
            'tipo_desconto' => 'VALOR_FIXO',
            'valor_desconto' => 10,
            'valor_minimo' => 30,
        ]);
        $pedido = $this->criarPedido(null, null, 'MINIMO30');
        $this->assertEquals(10, $pedido->valor_desconto);

        // 1 un = 20, fica abaixo do minimo
        $pedido->itens()->first()->update(['quantidade' => 1, 'subtotal_item' => 20]);

        $pedido->refresh();
        $this->assertEquals(0, $pedido->valor_desconto);
        $this->assertEquals(25, $pedido->valor_total);
    }

    public function test_nao_muda_item_depois_de_pago()
    {
        $pedido = $this->criarPedido();
        $pedido->pagamento()->create(['metodo_pagamento' => 'PIX', 'status_pagamento' => 'APROVADO', 'valor' => 45]);

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('já tem pagamento e não aceita alterações nos itens');

        $pedido->itens()->first()->update(['quantidade' => 5, 'subtotal_item' => 100]);
    }

    public function test_nao_muda_item_de_pedido_cancelado()
    {
        $pedido = $this->criarPedido();
        Pedido::where('id', $pedido->id)->update(['status' => 'CANCELADO']);

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('já está encerrado (CANCELADO) e não aceita alterações nos itens');

        $pedido->itens()->first()->delete();
    }

    public function test_pedido_entregue_nao_muda_status()
    {
        $pedido = $this->criarPedido();
        $pedido->update(['status' => 'ENTREGUE']);

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('já está encerrado (ENTREGUE) e não pode mudar para EM_PREPARO');

        $pedido->update(['status' => 'EM_PREPARO']);
    }

    public function test_pedido_aberto_muda_status()
    {
        $pedido = $this->criarPedido();

        $pedido->update(['status' => 'PRONTO']);
        $pedido->update(['status' => 'EM_PREPARO']);

        $this->assertEquals('EM_PREPARO', $pedido->fresh()->status);
    }

    public function test_so_um_endereco_principal_por_cliente()
    {
        $cliente = $this->criarCliente();
        $this->criarEndereco($cliente, ['e_principal' => true]);

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('uq_enderecos_cliente_principal');

        $this->criarEndereco($cliente, ['e_principal' => true]);
    }

    public function test_cada_cliente_tem_seu_principal()
    {
        $this->criarEndereco($this->criarCliente(), ['e_principal' => true]);
        $this->criarEndereco($this->criarCliente(), ['e_principal' => true]);

        $this->assertDatabaseCount('enderecos', 2);
    }
}
