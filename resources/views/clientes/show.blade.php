@extends('layouts.app')

@section('titulo', $cliente->nome)

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">{{ $cliente->nome }}</h1>
        <div class="d-flex gap-2">
            <a class="btn btn-outline-secondary" href="{{ route('clientes.index') }}">Voltar</a>
            <a class="btn btn-primary" href="{{ route('clientes.edit', $cliente) }}">Editar</a>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <dl class="row mb-0">
                <dt class="col-sm-3">E-mail</dt>
                <dd class="col-sm-9">{{ $cliente->email }}</dd>

                <dt class="col-sm-3">Telefone</dt>
                <dd class="col-sm-9">{{ $cliente->telefone }}</dd>

                <dt class="col-sm-3">CPF</dt>
                <dd class="col-sm-9">{{ $cliente->cpf }}</dd>

                <dt class="col-sm-3">Ativo</dt>
                <dd class="col-sm-9 mb-0">
                    <span class="badge {{ $cliente->ativo ? 'text-bg-success' : 'text-bg-secondary' }}">{{ $cliente->ativo ? 'Sim' : 'Não' }}</span>
                </dd>
            </dl>
        </div>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-4 mb-2">
        <h2 class="h5 mb-0">Endereços</h2>
        <a class="btn btn-sm btn-primary" href="{{ route('clientes.enderecos.create', $cliente) }}">Novo endereço</a>
    </div>
    <ul class="list-group">
        @forelse ($cliente->enderecos as $endereco)
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <span>
                    {{ $endereco->logradouro }}, {{ $endereco->numero }} - {{ $endereco->bairro }}
                    @if ($endereco->e_principal)
                        <span class="badge text-bg-primary ms-1">Principal</span>
                    @endif
                </span>
                <div class="d-flex gap-2">
                    <a class="btn btn-sm btn-outline-primary" href="{{ route('enderecos.edit', $endereco) }}">Editar</a>
                    <form method="POST" action="{{ route('enderecos.destroy', $endereco) }}" onsubmit="return confirm('Excluir este endereço?')">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-sm btn-outline-danger">Excluir</button>
                    </form>
                </div>
            </li>
        @empty
            <li class="list-group-item text-muted">Nenhum endereço cadastrado.</li>
        @endforelse
    </ul>

    <h2 class="h5 mt-4 mb-2">Últimos pedidos</h2>
    <ul class="list-group">
        @forelse ($cliente->pedidos as $pedido)
            <li class="list-group-item">
                <a href="{{ route('pedidos.show', $pedido) }}">Pedido {{ $pedido->id }}</a> - {{ $pedido->status }} - R$ {{ number_format($pedido->valor_total, 2, ',', '.') }}
            </li>
        @empty
            <li class="list-group-item text-muted">Nenhum pedido ainda.</li>
        @endforelse
    </ul>
@endsection
