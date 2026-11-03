@extends('layouts.app')

@section('titulo', $produto->nome)

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">{{ $produto->nome }}</h1>
        <div class="d-flex gap-2">
            <a class="btn btn-outline-secondary" href="{{ route('produtos.index') }}">Voltar</a>
            <a class="btn btn-primary" href="{{ route('produtos.edit', $produto) }}">Editar</a>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <dl class="row mb-0">
                <dt class="col-sm-3">Categoria</dt>
                <dd class="col-sm-9">{{ $produto->categoria->nome }}</dd>

                <dt class="col-sm-3">Descrição</dt>
                <dd class="col-sm-9">{{ $produto->descricao }}</dd>

                <dt class="col-sm-3">Preço</dt>
                <dd class="col-sm-9">R$ {{ number_format($produto->preco, 2, ',', '.') }}</dd>

                <dt class="col-sm-3">Custo de produção</dt>
                <dd class="col-sm-9">R$ {{ number_format($produto->custo_producao, 2, ',', '.') }}</dd>

                <dt class="col-sm-3">Disponível</dt>
                <dd class="col-sm-9 mb-0">
                    <span class="badge {{ $produto->disponivel ? 'text-bg-success' : 'text-bg-secondary' }}">{{ $produto->disponivel ? 'Sim' : 'Não' }}</span>
                </dd>
            </dl>
        </div>
    </div>
@endsection
