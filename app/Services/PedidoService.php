<?php

namespace App\Services;

use App\Exceptions\RegraNegocioException;
use App\Models\Endereco;
use App\Models\Ingrediente;
use App\Models\ItemPedido;
use App\Models\Pedido;
use App\Models\Produto;
use Closure;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;

class PedidoService
{
    private const PROXIMO_STATUS = [
        'EM_PREPARO' => 'PRONTO',
        'PRONTO' => 'SAIU_PARA_ENTREGA',
        'SAIU_PARA_ENTREGA' => 'ENTREGUE',
    ];

    public function listar(?string $status = null, int $porPagina = 15): LengthAwarePaginator
    {
        return Pedido::with('cliente')
            ->when($status, fn ($consulta) => $consulta->where('status', $status))
            ->latest('data_pedido')
            ->paginate($porPagina)
            ->withQueryString();
    }

    /**
     * Cria o pedido. A taxa vem de fn_taxa_entrega e os totais são calculados pelos triggers.
     */
    public function criar(array $dados): Pedido
    {
        return $this->executar(function () use ($dados) {
            $endereco = Endereco::with('cliente')->findOrFail($dados['endereco_id']);

            if (! $endereco->cliente->ativo) {
                throw new RegraNegocioException('Cliente inativo não pode fazer pedidos.');
            }

            $taxa = DB::selectOne('SELECT fn_taxa_entrega(?) AS taxa', [$endereco->bairro])->taxa;

            $pedido = Pedido::create([
                'cliente_id' => $endereco->cliente_id,
                'endereco_id' => $endereco->id,
                'status' => 'RECEBIDO',
                'subtotal' => 0,
                'taxa_entrega' => $taxa,
                'valor_total' => $taxa,
                'observacoes' => $dados['observacoes'] ?? null,
            ]);

            foreach ($dados['itens'] as $item) {
                $this->adicionarItem($pedido, $item);
            }

            if (! empty($dados['codigo_cupom'])) {
                DB::statement('CALL sp_aplicar_cupom(?, ?)', [$pedido->id, $dados['codigo_cupom']]);
            }

            return $pedido->refresh();
        });
    }

    public function aplicarCupom(Pedido $pedido, string $codigo): Pedido
    {
        return $this->executar(function () use ($pedido, $codigo) {
            DB::statement('CALL sp_aplicar_cupom(?, ?)', [$pedido->id, $codigo]);

            return $pedido->refresh();
        });
    }

    public function cancelar(Pedido $pedido): Pedido
    {
        return $this->executar(function () use ($pedido) {
            DB::statement('CALL sp_cancelar_pedido(?)', [$pedido->id]);

            return $pedido->refresh();
        });
    }

    /**
     * Registra o pagamento simulado: aprovado libera o preparo, recusado cancela o pedido.
     */
    public function registrarPagamento(Pedido $pedido, string $metodo, bool $aprovado): Pedido
    {
        return $this->executar(function () use ($pedido, $metodo, $aprovado) {
            $pedido = Pedido::lockForUpdate()->findOrFail($pedido->id);

            if ($pedido->status !== 'RECEBIDO' || $pedido->pagamento()->exists()) {
                throw new RegraNegocioException('Este pedido não está aguardando pagamento.');
            }

            $pedido->pagamento()->create([
                'metodo_pagamento' => $metodo,
                'status_pagamento' => $aprovado ? 'APROVADO' : 'RECUSADO',
                'valor' => $pedido->valor_total,
            ]);

            if (! $aprovado) {
                DB::statement('CALL sp_cancelar_pedido(?)', [$pedido->id]);

                return $pedido->refresh();
            }

            $pedido->update(['status' => 'EM_PREPARO']);

            return $pedido;
        });
    }

    public function avancarStatus(Pedido $pedido): Pedido
    {
        $proximo = self::PROXIMO_STATUS[$pedido->status] ?? null;

        if (! $proximo) {
            throw new RegraNegocioException("O status {$pedido->status} não pode avançar por esta ação.");
        }

        $pedido->update(['status' => $proximo]);

        return $pedido;
    }

    private function adicionarItem(Pedido $pedido, array $dados): void
    {
        $produto = Produto::findOrFail($dados['produto_id']);

        if (! $produto->disponivel) {
            throw new RegraNegocioException("O produto {$produto->nome} está indisponível.");
        }

        $item = $pedido->itens()->create([
            'produto_id' => $produto->id,
            'quantidade' => $dados['quantidade'],
            'preco_unitario' => $produto->preco,
            'subtotal_item' => round($dados['quantidade'] * $produto->preco, 2),
            'observacao' => $dados['observacao'] ?? null,
        ]);

        foreach ($dados['adicionais'] ?? [] as $adicional) {
            $this->adicionarAdicional($item, $adicional);
        }
    }

    private function adicionarAdicional(ItemPedido $item, array $dados): void
    {
        $ingrediente = Ingrediente::findOrFail($dados['ingrediente_id']);

        if (! $ingrediente->disponivel) {
            throw new RegraNegocioException("O adicional {$ingrediente->nome} está indisponível.");
        }

        $item->adicionais()->create([
            'ingrediente_id' => $ingrediente->id,
            'quantidade' => $dados['quantidade'] ?? 1,
            'preco_unitario' => $ingrediente->preco_adicional,
        ]);
    }

    /**
     * Roda em transação e traduz os erros levantados pelas procedures e triggers.
     */
    private function executar(Closure $operacao): Pedido
    {
        try {
            return DB::transaction($operacao);
        } catch (QueryException $erro) {
            if ($erro->getCode() === 'P0001') {
                throw RegraNegocioException::deQuery($erro);
            }

            throw $erro;
        }
    }
}
