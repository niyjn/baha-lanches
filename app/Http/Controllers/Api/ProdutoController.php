<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProdutoRequest;
use App\Http\Resources\ProdutoResource;
use App\Models\Produto;
use App\Services\ProdutoService;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\Response;

class ProdutoController extends Controller
{
    public function __construct(private ProdutoService $produtos) {}

    public function index(): AnonymousResourceCollection
    {
        return ProdutoResource::collection($this->produtos->listar());
    }

    public function store(ProdutoRequest $request): ProdutoResource
    {
        return new ProdutoResource($this->produtos->criar($request->validated()));
    }

    public function show(Produto $produto): ProdutoResource
    {
        return new ProdutoResource($produto->load('categoria'));
    }

    public function update(ProdutoRequest $request, Produto $produto): ProdutoResource
    {
        return new ProdutoResource($this->produtos->atualizar($produto, $request->validated()));
    }

    public function destroy(Produto $produto): Response
    {
        $this->produtos->excluir($produto);

        return response()->noContent();
    }
}
