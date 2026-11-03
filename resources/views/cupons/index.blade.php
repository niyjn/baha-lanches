@extends('layouts.app')

@section('titulo', 'Cupons')

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">Cupons</h1>
        <a class="btn btn-primary" href="{{ route('cupons.create') }}">Novo cupom</a>
    </div>

    <table class="table table-striped table-hover align-middle bg-white">
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
                        <div class="d-flex gap-2">
                            <a class="btn btn-sm btn-outline-primary" href="{{ route('cupons.edit', $cupom) }}">Editar</a>
                            <form method="POST" action="{{ route('cupons.destroy', $cupom) }}" onsubmit="return confirm('Excluir este cupom?')">
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

    {{ $cupons->links() }}
@endsection
