<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PedidoRequest extends FormRequest
{
    /**
     * Ignora linhas de item e de adicional deixadas em branco no formulário.
     */
    protected function prepareForValidation(): void
    {
        $itens = collect($this->input('itens', []))
            ->filter(fn ($item) => ! empty($item['produto_id']))
            ->map(function ($item) {
                $item['adicionais'] = collect($item['adicionais'] ?? [])
                    ->filter(fn ($adicional) => ! empty($adicional['ingrediente_id']))
                    ->values()
                    ->all();

                return $item;
            })
            ->values()
            ->all();

        $this->merge(['itens' => $itens]);
    }

    public function rules(): array
    {
        return [
            'endereco_id' => ['required', 'integer', 'exists:enderecos,id'],
            'codigo_cupom' => ['nullable', 'string', 'max:30'],
            'observacoes' => ['nullable', 'string'],
            'itens' => ['required', 'array', 'min:1'],
            'itens.*.produto_id' => ['required', 'integer', 'exists:produtos,id'],
            'itens.*.quantidade' => ['required', 'integer', 'min:1'],
            'itens.*.observacao' => ['nullable', 'string', 'max:200'],
            'itens.*.adicionais' => ['array'],
            'itens.*.adicionais.*.ingrediente_id' => ['required', 'integer', 'exists:ingredientes,id'],
            'itens.*.adicionais.*.quantidade' => ['nullable', 'integer', 'min:1'],
        ];
    }
}
