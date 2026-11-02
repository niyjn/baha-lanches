@extends('layouts.app')

@section('titulo', 'Produtos')

@section('conteudo')
    <h1>Produtos</h1>
    <a href="{{ route('produtos.create') }}">Novo produto</a>

    <table>
        <thead>
            <tr><th>Nome</th><th>Categoria</th><th>Preço</th><th>Disponível</th><th>Ações</th></tr>
        </thead>
        <tbody>
            @foreach ($produtos as $produto)
                <tr>
                    <td><a href="{{ route('produtos.show', $produto) }}">{{ $produto->nome }}</a></td>
                    <td>{{ $produto->categoria->nome }}</td>
                    <td>R$ {{ number_format($produto->preco, 2, ',', '.') }}</td>
                    <td>{{ $produto->disponivel ? 'Sim' : 'Não' }}</td>
                    <td>
                        <a href="{{ route('produtos.edit', $produto) }}">Editar</a>
                        <form method="POST" action="{{ route('produtos.destroy', $produto) }}">
                            @csrf
                            @method('DELETE')
                            <button type="submit">Excluir</button>
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{ $produtos->links() }}
@endsection
