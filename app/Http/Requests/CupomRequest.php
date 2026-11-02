<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CupomRequest extends FormRequest
{
    protected function prepareForValidation(): void
    {
        $this->merge(['codigo' => mb_strtoupper((string) $this->input('codigo'))]);
    }

    public function rules(): array
    {
        return [
            'codigo' => ['required', 'string', 'max:30', Rule::unique('cupons')->ignore($this->route('cupom'))],
            'tipo_desconto' => ['required', Rule::in(['PERCENTUAL', 'VALOR_FIXO'])],
            'valor_desconto' => ['required', 'numeric', 'gt:0', 'max:99999999.99', Rule::when($this->input('tipo_desconto') === 'PERCENTUAL', ['max:100'])],
            'valor_minimo' => ['required', 'numeric', 'min:0', 'max:99999999.99'],
            'data_validade' => ['required', 'date'],
            'limite_usos' => ['required', 'integer', 'min:1'],
            'ativo' => ['required', 'boolean'],
        ];
    }
}
