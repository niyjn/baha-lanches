<?php

namespace App\Services;

use App\Models\Cupom;

class CupomService extends CrudService
{
    protected string $modelo = Cupom::class;

    protected string $ordem = 'codigo';

    protected string $mensagemEmUso = 'Cupom já usado em pedidos não pode ser excluído. Desative-o.';
}
