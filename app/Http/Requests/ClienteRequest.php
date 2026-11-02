<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ClienteRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'nome' => ['required', 'string', 'max:100'],
            'email' => ['required', 'email', 'max:120', Rule::unique('clientes')->ignore($this->route('cliente'))],
            'telefone' => ['required', 'string', 'max:20'],
            'cpf' => ['required', 'regex:/^\d{3}\.\d{3}\.\d{3}-\d{2}$/', Rule::unique('clientes')->ignore($this->route('cliente'))],
            'data_nascimento' => ['nullable', 'date', 'before:today'],
            'ativo' => ['required', 'boolean'],
        ];
    }
}
