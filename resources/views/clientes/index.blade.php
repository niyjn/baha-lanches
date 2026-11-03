@extends('layouts.app')

@section('titulo', 'Clientes')

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">Clientes</h1>
        <a class="btn btn-primary" href="{{ route('clientes.create') }}">Novo cliente</a>
    </div>

     <table class="table table-striped table-hover align-middle bg-white">
        <thead>
            <tr><th>Nome</th><th>E-mail</th><th>Telefone</th><th>Ativo</th><th>Ações</th></tr>
        </thead>
        <tbody>
            @foreach ($clientes as $cliente)
                <tr>
                    <td><a href="{{ route('clientes.show', $cliente) }}">{{ $cliente->nome }}</a></td>
                    <td>{{ $cliente->email }}</td>
                    <td>{{ $cliente->telefone }}</td>
                    <td>{{ $cliente->ativo ? 'Sim' : 'Não' }}</td>
                    <td>
                        <a href="{{ route('clientes.edit', $cliente) }}">Editar</a>
                        <form method="POST" action="{{ route('clientes.destroy', $cliente) }}">
                            @csrf
                            @method('DELETE')
                            <button type="submit">Excluir</button>
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{ $clientes->links() }}
@endsection
