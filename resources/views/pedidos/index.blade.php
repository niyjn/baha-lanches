@extends('layouts.app')

@section('titulo', 'Pedidos')

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">Pedidos</h1>
        <a class="btn btn-primary" href="{{ route('pedidos.create') }}">Novo pedido</a>
    </div>

    <form class="row g-2 align-items-end mb-3" method="GET" action="{{ route('pedidos.index') }}">
        <div class="col-auto">
            <label class="form-label" for="status">Status</label>
            <select class="form-select" id="status" name="status">
                <option value="">Todos</option>
                @foreach (['RECEBIDO', 'EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA', 'ENTREGUE', 'CANCELADO'] as $status)
                    <option value="{{ $status }}" @selected(request('status') === $status)>{{ $status }}</option>
                @endforeach
            </select>
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-outline-primary">Filtrar</button>
        </div>
    </form>

    <table class="table table-striped table-hover align-middle bg-white">
        <thead>
            <tr><th>Pedido</th><th>Cliente</th><th>Data</th><th>Status</th><th class="text-end">Total</th></tr>
        </thead>
        <tbody>
            @foreach ($pedidos as $pedido)
                <tr>
                    <td><a href="{{ route('pedidos.show', $pedido) }}">{{ $pedido->id }}</a></td>
                    <td>{{ $pedido->cliente->nome }}</td>
                    <td>{{ $pedido->data_pedido->format('d/m/Y H:i') }}</td>
                    <td>@include('pedidos._status', ['status' => $pedido->status])</td>
                    <td class="text-end">R$ {{ number_format($pedido->valor_total, 2, ',', '.') }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    {{ $pedidos->links() }}
@endsection
