@extends('layouts.app')

@section('titulo', 'Pedidos')

@section('conteudo')
    <h1>Pedidos</h1>
    <a href="{{ route('pedidos.create') }}">Novo pedido</a>

    <form method="GET" action="{{ route('pedidos.index') }}">
        <label>Status
            <select name="status">
                <option value="">Todos</option>
                @foreach (['RECEBIDO', 'EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA', 'ENTREGUE', 'CANCELADO'] as $status)
                    <option value="{{ $status }}" @selected(request('status') === $status)>{{ $status }}</option>
                @endforeach
            </select>
        </label>
        <button type="submit">Filtrar</button>
    </form>

    <table>
        <thead>
            <tr><th>Pedido</th><th>Cliente</th><th>Data</th><th>Status</th><th>Total</th></tr>
        </thead>
        <tbody>
            @foreach ($pedidos as $pedido)
                <tr>
                    <td><a href="{{ route('pedidos.show', $pedido) }}">{{ $pedido->id }}</a></td>
                    <td>{{ $pedido->cliente->nome }}</td>
                    <td>{{ $pedido->data_pedido->format('d/m/Y H:i') }}</td>
                    <td>{{ $pedido->status }}</td>
                    <td>R$ {{ number_format($pedido->valor_total, 2, ',', '.') }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{ $pedidos->links() }}
@endsection
