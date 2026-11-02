<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CategoriaRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'nome' => ['required', 'string', 'max:60', Rule::unique('categorias')->ignore($this->route('categoria'))],
            'descricao' => ['nullable', 'string'],
            'ordem_exibicao' => ['required', 'integer', 'min:1'],
            'ativo' => ['required', 'boolean'],
        ];
    }
}
