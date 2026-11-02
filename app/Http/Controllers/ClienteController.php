<?php

namespace App\Http\Controllers;

use App\Http\Requests\ClienteRequest;
use App\Models\Cliente;
use App\Services\ClienteService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class ClienteController extends Controller
{
    public function __construct(private ClienteService $clientes) {}

    public function index(): View
    {
        return view('clientes.index', ['clientes' => $this->clientes->listar()]);
    }

    public function create(): View
    {
        return view('clientes.create');
    }

    public function store(ClienteRequest $request): RedirectResponse
    {
        $cliente = $this->clientes->criar($request->validated());

        return to_route('clientes.show', $cliente)->with('sucesso', 'Cliente criado. Cadastre um endereço.');
    }

    public function show(Cliente $cliente): View
    {
        return view('clientes.show', [
            'cliente' => $cliente->load(['enderecos', 'pedidos' => fn ($consulta) => $consulta->latest('data_pedido')->limit(10)]),
        ]);
    }

    public function edit(Cliente $cliente): View
    {
        return view('clientes.edit', ['cliente' => $cliente]);
    }

    public function update(ClienteRequest $request, Cliente $cliente): RedirectResponse
    {
        $this->clientes->atualizar($cliente, $request->validated());

        return to_route('clientes.show', $cliente)->with('sucesso', 'Cliente atualizado.');
    }

    public function destroy(Cliente $cliente): RedirectResponse
    {
        $this->clientes->excluir($cliente);

        return to_route('clientes.index')->with('sucesso', 'Cliente excluído.');
    }
}
