<?php

namespace Tests\Feature\Banco;

use App\Models\Pedido;
use Illuminate\Database\QueryException;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

// functions do 02_objetos.sql
class FuncoesBancoTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    private function taxa($bairro)
    {
        return DB::selectOne('select fn_taxa_entrega(?) as taxa', [$bairro])->taxa;
    }

    private function subtotal($pedidoId)
    {
        return DB::selectOne('select fn_subtotal_pedido(?) as subtotal', [$pedidoId])->subtotal;
    }

    private function desconto($cupomId, $subtotal, $pedidoId = null)
    {
        return DB::selectOne('select fn_calcular_desconto_cupom(?, ?, ?) as desconto', [$cupomId, $subtotal, $pedidoId])->desconto;
    }

    public function test_taxa_de_entrega_por_bairro()
    {
        $this->criarBairro('Centro', 5);
        $this->criarBairro('Boqueirão', 12.50);

        $this->assertEquals(5, $this->taxa('Centro'));
        $this->assertEquals(12.50, $this->taxa('Boqueirão'));
    }

    public function test_bairro_sem_entrega_da_erro()
    {
        $this->expectException(QueryException::class);
        $this->expectExceptionMessage('Não há entrega para o bairro Bairro Inexistente');

        $this->taxa('Bairro Inexistente');
    }

    public function test_subtotal_soma_itens_e_adicionais()
    {
        $bacon = $this->criarIngrediente(['preco_adicional' => 3]);
        $lanche = $this->criarProduto(['preco' => 20]);
        $refri = $this->criarProduto(['preco' => 7.50]);

        $pedido = $this->criarPedido(null, [
            ['produto_id' => $lanche->id, 'quantidade' => 2, 'adicionais' => [['ingrediente_id' => $bacon->id, 'quantidade' => 2]]],
            ['produto_id' => $refri->id, 'quantidade' => 1],
        ]);

        // 2x20 + 2x3 + 7.50
        $this->assertEquals(53.50, $this->subtotal($pedido->id));
    }

    public function test_subtotal_sem_itens_e_zero()
    {
        $this->assertEquals(0, $this->subtotal(999999));
    }

    public function test_desconto_percentual()
    {
        $cupom = $this->criarCupom(['tipo_desconto' => 'PERCENTUAL', 'valor_desconto' => 15]);

        $this->assertEquals(6, $this->desconto($cupom->id, 40));
    }

    public function test_desconto_fixo_nao_passa_do_subtotal()
    {
        $cupom = $this->criarCupom(['tipo_desconto' => 'VALOR_FIXO', 'valor_desconto' => 25]);

        $this->assertEquals(25, $this->desconto($cupom->id, 40));
        $this->assertEquals(18, $this->desconto($cupom->id, 18));
    }

    public function test_cupom_vencido_inativo_ou_abaixo_do_minimo()
    {
        $vencido = $this->criarCupom(['codigo' => 'VENCIDO', 'data_validade' => now()->subDay()]);
        $inativo = $this->criarCupom(['codigo' => 'INATIVO', 'ativo' => false]);
        $minimo = $this->criarCupom(['codigo' => 'MINIMO50', 'valor_minimo' => 50]);

        $this->assertEquals(0, $this->desconto($vencido->id, 100));
        $this->assertEquals(0, $this->desconto($inativo->id, 100));
        $this->assertEquals(0, $this->desconto($minimo->id, 49.99));
        $this->assertEquals(5, $this->desconto($minimo->id, 50));
    }

    public function test_cupom_inexistente_nao_da_desconto()
    {
        $this->assertEquals(0, $this->desconto(999999, 100));
    }

    public function test_limite_de_usos_do_cupom()
    {
        $cupom = $this->criarCupom(['codigo' => 'UMAVEZ', 'limite_usos' => 1]);
        $pedido = $this->criarPedido(null, null, 'UMAVEZ');

        // ja usou o unico uso
        $this->assertEquals(0, $this->desconto($cupom->id, 40));
        // o proprio pedido n conta
        $this->assertEquals(4, $this->desconto($cupom->id, 40, $pedido->id));

        Pedido::where('id', $pedido->id)->update(['status' => 'CANCELADO']);

        // cancelado libera o uso
        $this->assertEquals(4, $this->desconto($cupom->id, 40));
    }
}
