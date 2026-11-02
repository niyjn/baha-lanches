<?php

namespace App\Services;

use App\Exceptions\RegraNegocioException;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;

abstract class CrudService
{
    /** @var class-string<Model> */
    protected string $modelo;

    protected array $relacoes = [];

    protected string $ordem = 'id';

    protected string $mensagemEmUso = 'Este registro está em uso e não pode ser excluído.';

    public function listar(int $porPagina = 15): LengthAwarePaginator
    {
        return $this->modelo::with($this->relacoes)->orderBy($this->ordem)->paginate($porPagina);
    }

    public function criar(array $dados): Model
    {
        return $this->modelo::create($dados);
    }

    public function atualizar(Model $registro, array $dados): Model
    {
        $registro->update($dados);

        return $registro;
    }

    public function excluir(Model $registro): void
    {
        try {
            DB::transaction(fn () => $registro->delete());
        } catch (QueryException $erro) {
            // 23503: outro registro ainda aponta para este pela chave estrangeira
            if ($erro->getCode() === '23503') {
                throw new RegraNegocioException($this->mensagemEmUso, previous: $erro);
            }

            throw $erro;
        }
    }
}
