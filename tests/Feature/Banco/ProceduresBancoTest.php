<?php

namespace Tests\Feature\Banco;

use App\Models\Pedido;
use Illuminate\Database\QueryException;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

// procedures do 02_objetos.sql
class ProceduresBancoTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    private function aplicarCupom($pedidoId, $codigo)
    {
        DB::statement('call sp_aplicar_cupom(?, ?)', [$pedidoId, $codigo]);
    }

    private function cancelar($pedidoId)
    {
        DB::statement('call sp_cancelar_pedido(?)', [$pedidoId]);
    }

    private function pagar($pedido, $status = 'APROVADO')
    {
        return $pedido->pagamento()->create([
            'metodo_pagamento' => 'PIX',
            'status_pagamento' => $status,
            'valor' => $pedido->valor_total,
        ]);
    }

    public function test_aplicar_cupom()
    {
        $cupom = $this->criarCupom(['codigo' => 'DESC10']);
        $pedido = $this->criarPedido();

        // minusculo tb funciona
        $this->aplicarCupom($pedido->id, 'desc10');

        $pedido->refresh();
        $this->assertEquals($cupom->id, $pedido->cupom_id);
        $this->assertEquals(4, $pedido->valor_desconto);
        // 40 + 5 entrega - 4 desc
        $this->assertEquals(41, $pedido->valor_total);
    }

    public function test_cupom_inexistente()
    {
        $pedido = $this->criarPedido();

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Cupom NAOEXISTE não encontrado');

        $this->aplicarCupom($pedido->id, 'NAOEXISTE');
    }

    public function test_cupom_em_pedido_inexistente()
    {
        $this->criarCupom();

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Pedido 999999 não encontrado');

        $this->aplicarCupom(999999, 'DESC10');
    }

    public function test_pedido_so_aceita_um_cupom()
    {
        $this->criarCupom(['codigo' => 'DESC10']);
        $this->criarCupom(['codigo' => 'OUTRO']);
        $pedido = $this->criarPedido(null, null, 'DESC10');

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Pedido '.$pedido->id.' já possui cupom');

        $this->aplicarCupom($pedido->id, 'OUTRO');
    }

    public function test_cupom_que_nao_se_aplica()
    {
        $this->criarCupom(['codigo' => 'MINIMO100', 'valor_minimo' => 100]);
        $pedido = $this->criarPedido();

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Cupom MINIMO100 não pode ser aplicado a este pedido');

        $this->aplicarCupom($pedido->id, 'MINIMO100');
    }

    public function test_cupom_depois_do_pagamento()
    {
        $this->criarCupom();
        $pedido = $this->criarPedido();
        $this->pagar($pedido);

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Pedido '.$pedido->id.' já tem pagamento e não aceita cupom');

        $this->aplicarCupom($pedido->id, 'DESC10');
    }

    public function test_cupom_em_pedido_cancelado()
    {
        $this->criarCupom();
        $pedido = $this->criarPedido();
        Pedido::where('id', $pedido->id)->update(['status' => 'CANCELADO']);

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Pedido '.$pedido->id.' já está encerrado (CANCELADO)');

        $this->aplicarCupom($pedido->id, 'DESC10');
    }

    public function test_cancelar_estorna_pagamento_aprovado()
    {
        $pedido = $this->criarPedido();
        $pagamento = $this->pagar($pedido, 'APROVADO');

        $this->cancelar($pedido->id);

        $this->assertEquals('CANCELADO', $pedido->fresh()->status);
        $this->assertEquals('ESTORNADO', $pagamento->fresh()->status_pagamento);
    }

    public function test_cancelar_recusa_pagamento_pendente()
    {
        $pedido = $this->criarPedido();
        $pagamento = $this->pagar($pedido, 'PENDENTE');

        $this->cancelar($pedido->id);

        $this->assertEquals('RECUSADO', $pagamento->fresh()->status_pagamento);
    }

    public function test_cancelar_duas_vezes()
    {
        $pedido = $this->criarPedido();
        $this->cancelar($pedido->id);

        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Pedido '.$pedido->id.' já está encerrado (CANCELADO)');

        $this->cancelar($pedido->id);
    }

    public function test_cancelar_pedido_inexistente()
    {
        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Pedido 999999 não encontrado');

        $this->cancelar(999999);
    }
}
