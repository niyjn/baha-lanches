@extends('layouts.app')

@section('titulo', 'Produtos')

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">Produtos</h1>
        <a class="btn btn-primary" href="{{ route('produtos.create') }}">Novo produto</a>
    </div>

    <table class="table table-striped table-hover align-middle bg-white">
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
                        <div class="d-flex gap-2">
                            <a class="btn btn-sm btn-outline-primary" href="{{ route('produtos.edit', $produto) }}">Editar</a>
                            <form method="POST" action="{{ route('produtos.destroy', $produto) }}" onsubmit="return confirm('Excluir este produto?')">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-sm btn-outline-danger">Excluir</button>
                            </form>
                        </div>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{ $produtos->links() }}
@endsection
