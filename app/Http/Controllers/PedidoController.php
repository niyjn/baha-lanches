<?php

namespace App\Http\Controllers;

use App\Http\Requests\AplicarCupomRequest;
use App\Http\Requests\PagamentoRequest;
use App\Http\Requests\PedidoRequest;
use App\Models\Endereco;
use App\Models\Ingrediente;
use App\Models\Pedido;
use App\Models\Produto;
use App\Services\PedidoService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class PedidoController extends Controller
{
    public function __construct(private PedidoService $pedidos) {}

    public function index(Request $request): View
    {
        return view('pedidos.index', ['pedidos' => $this->pedidos->listar($request->query('status'))]);
    }

    public function create(): View
    {
        return view('pedidos.create', [
            'enderecos' => Endereco::with('cliente')->whereRelation('cliente', 'ativo', true)->orderBy('cliente_id')->get(),
            'produtos' => Produto::where('disponivel', true)->orderBy('nome')->get(),
            'ingredientes' => Ingrediente::where('disponivel', true)->orderBy('nome')->get(),
        ]);
    }

    public function store(PedidoRequest $request): RedirectResponse
    {
        $pedido = $this->pedidos->criar($request->validated());

        return to_route('pedidos.show', $pedido)->with('sucesso', 'Pedido criado. Registre o pagamento.');
    }

    public function show(Pedido $pedido): View
    {
        return view('pedidos.show', [
            'pedido' => $pedido->load(['cliente', 'endereco', 'cupom', 'itens.produto', 'itens.adicionais.ingrediente', 'pagamento', 'avaliacao']),
        ]);
    }

    public function aplicarCupom(AplicarCupomRequest $request, Pedido $pedido): RedirectResponse
    {
        $this->pedidos->aplicarCupom($pedido, $request->validated('codigo_cupom'));

        return to_route('pedidos.show', $pedido)->with('sucesso', 'Cupom aplicado.');
    }

    public function registrarPagamento(PagamentoRequest $request, Pedido $pedido): RedirectResponse
    {
        $this->pedidos->registrarPagamento($pedido, $request->validated('metodo_pagamento'), $request->boolean('aprovado'));

        return to_route('pedidos.show', $pedido)->with('sucesso', 'Pagamento registrado.');
    }

    public function avancarStatus(Pedido $pedido): RedirectResponse
    {
        $this->pedidos->avancarStatus($pedido);

        return to_route('pedidos.show', $pedido)->with('sucesso', 'Status atualizado.');
    }

    public function cancelar(Pedido $pedido): RedirectResponse
    {
        $this->pedidos->cancelar($pedido);

        return to_route('pedidos.show', $pedido)->with('sucesso', 'Pedido cancelado.');
    }
}
