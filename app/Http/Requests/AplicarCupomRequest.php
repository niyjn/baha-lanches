<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AplicarCupomRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'codigo_cupom' => ['required', 'string', 'max:30'],
        ];
    }
}
