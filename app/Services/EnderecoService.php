<?php

namespace App\Services;

use App\Exceptions\RegraNegocioException;
use App\Models\Cliente;
use App\Models\Endereco;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;

class EnderecoService
{
    private const CIDADE = 'Guarapuava';

    private const ESTADO = 'PR';

    public function criar(Cliente $cliente, array $dados): Endereco
    {
        return DB::transaction(function () use ($cliente, $dados) {
            $this->liberarPrincipal($cliente, $dados);

            return $cliente->enderecos()->create($dados + ['cidade' => self::CIDADE, 'estado' => self::ESTADO]);
        });
    }

    public function atualizar(Endereco $endereco, array $dados): Endereco
    {
        $endereco->fill($dados);

        // O pedido aponta para o endereço, então alterá-lo mudaria o histórico de entregas
        if ($endereco->isDirty(array_diff(array_keys($dados), ['e_principal'])) && $endereco->pedidos()->exists()) {
            throw new RegraNegocioException('Endereço já usado em pedidos não pode ser alterado. Cadastre um novo.');
        }

        return DB::transaction(function () use ($endereco, $dados) {
            $this->liberarPrincipal($endereco->cliente, $dados);
            $endereco->save();

            return $endereco;
        });
    }

    public function excluir(Endereco $endereco): void
    {
        try {
            DB::transaction(fn () => $endereco->delete());
        } catch (QueryException $erro) {
            if ($erro->getCode() === '23503') {
                throw new RegraNegocioException('Endereço já usado em pedidos não pode ser excluído.', previous: $erro);
            }

            throw $erro;
        }
    }

    /**
     * O índice único permite só um endereço principal por cliente.
     */
    private function liberarPrincipal(Cliente $cliente, array $dados): void
    {
        if ($dados['e_principal'] ?? false) {
            $cliente->enderecos()->where('e_principal', true)->update(['e_principal' => false]);
        }
    }
}
