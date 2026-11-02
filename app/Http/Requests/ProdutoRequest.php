<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProdutoRequest extends FormRequest
{
    public function rules(): array
    {
        // PATCH da API aceita envio parcial; POST e PUT exigem os campos principais
        $presenca = $this->isMethod('patch') ? 'sometimes' : 'required';

        return [
            'categoria_id' => [$presenca, 'integer', 'exists:categorias,id'],
            'nome' => [$presenca, 'string', 'max:100'],
            'descricao' => ['nullable', 'string'],
            'preco' => [$presenca, 'numeric', 'min:0', 'max:99999999.99'],
            'custo_producao' => [$presenca, 'numeric', 'min:0', 'max:99999999.99'],
            'disponivel' => ['sometimes', 'boolean'],
        ];
    }
}
