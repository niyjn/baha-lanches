<?php

namespace App\Http\Controllers;

use App\Http\Requests\CupomRequest;
use App\Models\Cupom;
use App\Services\CupomService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class CupomController extends Controller
{
    public function __construct(private CupomService $cupons) {}

    public function index(): View
    {
        return view('cupons.index', ['cupons' => $this->cupons->listar()]);
    }

    public function create(): View
    {
        return view('cupons.create');
    }

    public function store(CupomRequest $request): RedirectResponse
    {
        $this->cupons->criar($request->validated());

        return to_route('cupons.index')->with('sucesso', 'Cupom criado.');
    }

    public function edit(Cupom $cupom): View
    {
        return view('cupons.edit', ['cupom' => $cupom]);
    }

    public function update(CupomRequest $request, Cupom $cupom): RedirectResponse
    {
        $this->cupons->atualizar($cupom, $request->validated());

        return to_route('cupons.index')->with('sucesso', 'Cupom atualizado.');
    }

    public function destroy(Cupom $cupom): RedirectResponse
    {
        $this->cupons->excluir($cupom);

        return to_route('cupons.index')->with('sucesso', 'Cupom excluído.');
    }
}
