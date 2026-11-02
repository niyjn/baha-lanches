<?php

namespace App\Services;

use App\Models\Cliente;

class ClienteService extends CrudService
{
    protected string $modelo = Cliente::class;

    protected string $ordem = 'nome';

    protected string $mensagemEmUso = 'Cliente com pedidos não pode ser excluído. Desative-o.';
}
