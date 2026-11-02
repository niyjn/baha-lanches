@extends('layouts.app')

@section('titulo', 'Cupons')

@section('conteudo')
    <h1>Cupons</h1>
    <a href="{{ route('cupons.create') }}">Novo cupom</a>

    <table>
        <thead>
            <tr><th>Código</th><th>Tipo</th><th>Desconto</th><th>Mínimo</th><th>Validade</th><th>Limite</th><th>Ativo</th><th>Ações</th></tr>
        </thead>
        <tbody>
            @foreach ($cupons as $cupom)
                <tr>
                    <td>{{ $cupom->codigo }}</td>
                    <td>{{ $cupom->tipo_desconto }}</td>
                    <td>{{ $cupom->valor_desconto }}</td>
                    <td>{{ $cupom->valor_minimo }}</td>
                    <td>{{ $cupom->data_validade->format('d/m/Y') }}</td>
                    <td>{{ $cupom->limite_usos }}</td>
                    <td>{{ $cupom->ativo ? 'Sim' : 'Não' }}</td>
                    <td>
                        <a href="{{ route('cupons.edit', $cupom) }}">Editar</a>
                        <form method="POST" action="{{ route('cupons.destroy', $cupom) }}">
                            @csrf
                            @method('DELETE')
                            <button type="submit">Excluir</button>
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{ $cupons->links() }}
@endsection
