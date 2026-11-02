<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProdutoRequest;
use App\Models\Categoria;
use App\Models\Produto;
use App\Services\ProdutoService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class ProdutoController extends Controller
{
    public function __construct(private ProdutoService $produtos) {}

    public function index(): View
    {
        return view('produtos.index', ['produtos' => $this->produtos->listar()]);
    }

    public function create(): View
    {
        return view('produtos.create', ['categorias' => Categoria::orderBy('ordem_exibicao')->get()]);
    }

    public function store(ProdutoRequest $request): RedirectResponse
    {
        $produto = $this->produtos->criar($request->validated());

        return to_route('produtos.show', $produto)->with('sucesso', 'Produto criado.');
    }

    public function show(Produto $produto): View
    {
        return view('produtos.show', ['produto' => $produto->load('categoria')]);
    }

    public function edit(Produto $produto): View
    {
        return view('produtos.edit', [
            'produto' => $produto,
            'categorias' => Categoria::orderBy('ordem_exibicao')->get(),
        ]);
    }

    public function update(ProdutoRequest $request, Produto $produto): RedirectResponse
    {
        $this->produtos->atualizar($produto, $request->validated());

        return to_route('produtos.show', $produto)->with('sucesso', 'Produto atualizado.');
    }

    public function destroy(Produto $produto): RedirectResponse
    {
        $this->produtos->excluir($produto);

        return to_route('produtos.index')->with('sucesso', 'Produto excluído.');
    }
}
