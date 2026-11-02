<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class PagamentoRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'metodo_pagamento' => ['required', Rule::in(['PIX', 'CARTAO_CREDITO', 'CARTAO_DEBITO', 'DINHEIRO', 'VALE_REFEICAO'])],
            'aprovado' => ['required', 'boolean'],
        ];
    }
}
