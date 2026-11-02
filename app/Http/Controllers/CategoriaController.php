<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoriaRequest;
use App\Models\Categoria;
use App\Services\CategoriaService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class CategoriaController extends Controller
{
    public function __construct(private CategoriaService $categorias) {}

    public function index(): View
    {
        return view('categorias.index', ['categorias' => $this->categorias->listar()]);
    }

    public function create(): View
    {
        return view('categorias.create');
    }

    public function store(CategoriaRequest $request): RedirectResponse
    {
        $this->categorias->criar($request->validated());

        return to_route('categorias.index')->with('sucesso', 'Categoria criada.');
    }

    public function edit(Categoria $categoria): View
    {
        return view('categorias.edit', ['categoria' => $categoria]);
    }

    public function update(CategoriaRequest $request, Categoria $categoria): RedirectResponse
    {
        $this->categorias->atualizar($categoria, $request->validated());

        return to_route('categorias.index')->with('sucesso', 'Categoria atualizada.');
    }

    public function destroy(Categoria $categoria): RedirectResponse
    {
        $this->categorias->excluir($categoria);

        return to_route('categorias.index')->with('sucesso', 'Categoria excluída.');
    }
}
