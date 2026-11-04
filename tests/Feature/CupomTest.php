<?php

namespace Tests\Feature;

use App\Models\Cupom;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\Concerns\CriaDadosDoLanche;
use Tests\TestCase;

class CupomTest extends TestCase
{
    use RefreshDatabase;
    use CriaDadosDoLanche;

    private function dados($mudar = [])
    {
        return array_merge([
            'codigo' => 'bemvindo',
            'tipo_desconto' => 'PERCENTUAL',
            'valor_desconto' => 10,
            'valor_minimo' => 30,
            'data_validade' => now()->addMonth()->format('Y-m-d H:i:s'),
            'limite_usos' => 50,
            'ativo' => '1',
        ], $mudar);
    }

    public function test_telas_de_cupom_abrem()
    {
        $cupom = $this->criarCupom(['codigo' => 'NATAL']);

        $this->get('/cupons')->assertOk()->assertSee('NATAL');
        $this->get('/cupons/create')->assertOk();
        $this->get('/cupons/'.$cupom->id.'/edit')->assertOk()->assertSee('NATAL');
    }

    public function test_codigo_salvo_em_maiusculo()
    {
        $resposta = $this->post('/cupons', $this->dados());

        $resposta->assertRedirect('/cupons');
        $resposta->assertSessionHas('sucesso', 'Cupom criado.');
        $this->assertEquals('BEMVINDO', Cupom::first()->codigo);
    }

    public function test_codigo_repetido()
    {
        $this->criarCupom(['codigo' => 'BEMVINDO']);

        $this->post('/cupons', $this->dados(['codigo' => 'BemVindo']))->assertSessionHasErrors('codigo');
    }

    public function test_percentual_maximo_100()
    {
        $this->post('/cupons', $this->dados(['valor_desconto' => 150]))->assertSessionHasErrors('valor_desconto');

        $resposta = $this->post('/cupons', $this->dados(['tipo_desconto' => 'VALOR_FIXO', 'valor_desconto' => 150]));
        $resposta->assertSessionHasNoErrors();
    }

    public function test_tipo_limite_e_valor_invalidos()
    {
        $resposta = $this->post('/cupons', $this->dados(['tipo_desconto' => 'BRINDE', 'limite_usos' => 0, 'valor_desconto' => 0]));

        $resposta->assertSessionHasErrors(['tipo_desconto', 'limite_usos', 'valor_desconto']);
    }

    public function test_editar_cupom()
    {
        $cupom = $this->criarCupom(['codigo' => 'BEMVINDO']);

        $resposta = $this->put('/cupons/'.$cupom->id, $this->dados(['ativo' => '0']));

        $resposta->assertSessionHasNoErrors();
        $resposta->assertRedirect('/cupons');
        $this->assertFalse($cupom->fresh()->ativo);
    }

    public function test_nao_exclui_cupom_usado()
    {
        $usado = $this->criarCupom(['codigo' => 'USADO']);
        $novo = $this->criarCupom(['codigo' => 'NOVO']);
        $this->criarPedido(null, null, 'USADO');

        $resposta = $this->from('/cupons')->delete('/cupons/'.$usado->id);
        $resposta->assertSessionHas('erro', 'Cupom já usado em pedidos não pode ser excluído. Desative-o.');

        $this->delete('/cupons/'.$novo->id)->assertSessionHas('sucesso', 'Cupom excluído.');

        $this->assertDatabaseHas('cupons', ['id' => $usado->id]);
        $this->assertDatabaseMissing('cupons', ['id' => $novo->id]);
    }
}
