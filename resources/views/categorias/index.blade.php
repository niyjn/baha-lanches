@extends('layouts.app')

@section('titulo', 'Categorias')

@section('conteudo')
    <h1>Categorias</h1>
    <a href="{{ route('categorias.create') }}">Nova categoria</a>

    <table>
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
