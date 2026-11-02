<?php

namespace App\Services;

use App\Models\Produto;

class ProdutoService extends CrudService
{
    protected string $modelo = Produto::class;

    protected array $relacoes = ['categoria'];

    protected string $ordem = 'nome';

    protected string $mensagemEmUso = 'Produto já vendido não pode ser excluído. Marque-o como indisponível.';
}
