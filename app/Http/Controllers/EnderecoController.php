<?php

namespace App\Http\Controllers;

use App\Http\Requests\EnderecoRequest;
use App\Models\BairroEntrega;
use App\Models\Cliente;
use App\Models\Endereco;
use App\Services\EnderecoService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class EnderecoController extends Controller
{
    public function __construct(private EnderecoService $enderecos) {}

    public function create(Cliente $cliente): View
    {
        return view('enderecos.create', [
            'cliente' => $cliente,
            'bairros' => BairroEntrega::orderBy('bairro')->pluck('bairro'),
        ]);
    }

    public function store(EnderecoRequest $request, Cliente $cliente): RedirectResponse
    {
        $this->enderecos->criar($cliente, $request->validated());

        return to_route('clientes.show', $cliente)->with('sucesso', 'Endereço criado.');
    }

    public function edit(Endereco $endereco): View
    {
        return view('enderecos.edit', [
            'endereco' => $endereco,
            'bairros' => BairroEntrega::orderBy('bairro')->pluck('bairro'),
        ]);
    }

    public function update(EnderecoRequest $request, Endereco $endereco): RedirectResponse
    {
        $this->enderecos->atualizar($endereco, $request->validated());

        return to_route('clientes.show', $endereco->cliente_id)->with('sucesso', 'Endereço atualizado.');
    }

    public function destroy(Endereco $endereco): RedirectResponse
    {
        $this->enderecos->excluir($endereco);

        return to_route('clientes.show', $endereco->cliente_id)->with('sucesso', 'Endereço excluído.');
    }
}
