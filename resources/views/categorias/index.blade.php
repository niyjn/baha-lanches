@extends('layouts.app')

@section('titulo', 'Categorias')

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">Categorias</h1>
        <a class="btn btn-primary" href="{{ route('categorias.create') }}">Nova categoria</a>
    </div>

    <table class="table table-striped table-hover align-middle bg-white">
        <thead>
            <tr><th>Ordem</th><th>Nome</th><th>Ativa</th><th>Ações</th></tr>
        </thead>
        <tbody>
            @foreach ($categorias as $categoria)
                <tr>
                    <td>{{ $categoria->ordem_exibicao }}</td>
                    <td>{{ $categoria->nome }}</td>
                    <td>{{ $categoria->ativo ? 'Sim' : 'Não' }}</td>
                    <td>
                        <a href="{{ route('categorias.edit', $categoria) }}">Editar</a>
                        <form method="POST" action="{{ route('categorias.destroy', $categoria) }}">
                            @csrf
                            @method('DELETE')
                            <button type="submit">Excluir</button>
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{ $categorias->links() }}
@endsection
