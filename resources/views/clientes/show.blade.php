@extends('layouts.app')

@section('titulo', $cliente->nome)

@section('conteudo')
    <h1>{{ $cliente->nome }}</h1>

    <p>E-mail: {{ $cliente->email }}</p>
    <p>Telefone: {{ $cliente->telefone }}</p>
    <p>CPF: {{ $cliente->cpf }}</p>
    <p>Ativo: {{ $cliente->ativo ? 'Sim' : 'Não' }}</p>
    <a href="{{ route('clientes.edit', $cliente) }}">Editar</a>

    <h2>Endereços</h2>
    <a href="{{ route('clientes.enderecos.create', $cliente) }}">Novo endereço</a>
    <ul>
        @foreach ($cliente->enderecos as $endereco)
            <li>
                {{ $endereco->logradouro }}, {{ $endereco->numero }} - {{ $endereco->bairro }}
                @if ($endereco->e_principal) (principal) @endif
                <a href="{{ route('enderecos.edit', $endereco) }}">Editar</a>
                <form method="POST" action="{{ route('enderecos.destroy', $endereco) }}">
                    @csrf
                    @method('DELETE')
                    <button type="submit">Excluir</button>
                </form>
            </li>
        @endforeach
    </ul>

    <h2>Últimos pedidos</h2>
    <ul>
        @foreach ($cliente->pedidos as $pedido)
            <li><a href="{{ route('pedidos.show', $pedido) }}">Pedido {{ $pedido->id }}</a> - {{ $pedido->status }} - R$ {{ number_format($pedido->valor_total, 2, ',', '.') }}</li>
        @endforeach
    </ul>
@endsection
