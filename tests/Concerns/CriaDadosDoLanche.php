<?php

namespace Tests\Concerns;

use App\Models\BairroEntrega;
use App\Models\Categoria;
use App\Models\Cliente;
use App\Models\Cupom;
use App\Models\GrupoEntrega;
use App\Models\Ingrediente;
use App\Models\Produto;
use App\Services\PedidoService;

// cria os dados dos testes (n tem factory)
trait CriaDadosDoLanche
{
    private $contador = 0;

    protected function criarBairro($nome = 'Centro', $taxa = 5)
    {
        $grupo = GrupoEntrega::firstOrCreate(['nome_grupo' => 'Taxa '.$taxa], ['valor_unitario' => $taxa]);

        return BairroEntrega::firstOrCreate(['bairro' => $nome], ['grupo_entrega_id' => $grupo->id]);
    }

    protected function criarCliente($dados = [])
    {
        $this->contador++;
        $numero = str_pad($this->contador, 2, '0', STR_PAD_LEFT);

        return Cliente::create(array_merge([
            'nome' => 'Cliente Teste',
            'email' => 'cliente'.$this->contador.'@teste.com',
            'telefone' => '(42) 99999-0000',
            'cpf' => '111.222.333-'.$numero,
            'ativo' => true,
        ], $dados));
    }

    protected function criarEndereco($cliente = null, $dados = [])
    {
        if ($cliente == null) {
            $cliente = $this->criarCliente();
        }

        if (! isset($dados['bairro'])) {
            $dados['bairro'] = $this->criarBairro()->bairro;
        }

        return $cliente->enderecos()->create(array_merge([
            'logradouro' => 'Rua XV de Novembro',
            'numero' => '100',
            'cidade' => 'Guarapuava',
            'estado' => 'PR',
            'cep' => '85010-000',
            'e_principal' => false,
        ], $dados));
    }

    protected function criarCategoria($dados = [])
    {
        $this->contador++;

        return Categoria::create(array_merge([
            'nome' => 'Categoria '.$this->contador,
            'ordem_exibicao' => 1,
            'ativo' => true,
        ], $dados));
    }

    protected function criarProduto($dados = [])
    {
        if (! isset($dados['categoria_id'])) {
            $dados['categoria_id'] = $this->criarCategoria()->id;
        }

        return Produto::create(array_merge([
            'nome' => 'X-Burguer',
            'preco' => 20,
            'custo_producao' => 8,
            'disponivel' => true,
        ], $dados));
    }

    protected function criarIngrediente($dados = [])
    {
        $this->contador++;

        return Ingrediente::create(array_merge([
            'nome' => 'Bacon '.$this->contador,
            'preco_adicional' => 3,
            'custo_unitario' => 1,
            'disponivel' => true,
        ], $dados));
    }

    protected function criarCupom($dados = [])
    {
        return Cupom::create(array_merge([
            'codigo' => 'DESC10',
            'tipo_desconto' => 'PERCENTUAL',
            'valor_desconto' => 10,
            'valor_minimo' => 0,
            'data_validade' => now()->addMonth(),
            'limite_usos' => 100,
            'ativo' => true,
        ], $dados));
    }

    // cria pelo service, padrao 2x produto de 20
    protected function criarPedido($endereco = null, $itens = null, $cupom = null)
    {
        if ($endereco == null) {
            $endereco = $this->criarEndereco();
        }

        if ($itens == null) {
            $itens = [['produto_id' => $this->criarProduto()->id, 'quantidade' => 2]];
        }

        $service = new PedidoService();

        return $service->criar([
            'endereco_id' => $endereco->id,
            'itens' => $itens,
            'codigo_cupom' => $cupom,
        ]);
    }
}
