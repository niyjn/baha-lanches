<?php

namespace App\Services;

use App\Models\Categoria;

class CategoriaService extends CrudService
{
    protected string $modelo = Categoria::class;

    protected string $ordem = 'ordem_exibicao';

    protected string $mensagemEmUso = 'Categoria com produtos não pode ser excluída. Desative-a.';
}
