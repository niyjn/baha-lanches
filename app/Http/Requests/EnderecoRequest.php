<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EnderecoRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'logradouro' => ['required', 'string', 'max:150'],
            'numero' => ['required', 'string', 'max:20'],
            'complemento' => ['nullable', 'string', 'max:100'],
            'bairro' => ['required', 'exists:bairros_entrega,bairro'],
            'cep' => ['required', 'regex:/^\d{5}-\d{3}$/'],
            'ponto_referencia' => ['nullable', 'string', 'max:150'],
            'e_principal' => ['required', 'boolean'],
        ];
    }
}
