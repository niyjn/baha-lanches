@extends('layouts.app')

@section('titulo', 'Pedido '.$pedido->id)

@section('conteudo')
    <h1>Pedido {{ $pedido->id }}</h1>

    <p>Status: {{ $pedido->status }}</p>
    <p>Data: {{ $pedido->data_pedido->format('d/m/Y H:i') }}</p>
    <p>Cliente: <a href="{{ route('clientes.show', $pedido->cliente) }}">{{ $pedido->cliente->nome }}</a></p>
    <p>Entrega: {{ $pedido->endereco->logradouro }}, {{ $pedido->endereco->numero }} - {{ $pedido->endereco->bairro }}</p>
    <p>Observações: {{ $pedido->observacoes }}</p>

    <h2>Itens</h2>
    <ul>
        @foreach ($pedido->itens as $item)
            <li>
                {{ $item->quantidade }}x {{ $item->produto->nome }} - R$ {{ number_format($item->subtotal_item, 2, ',', '.') }}
                <ul>
                    @foreach ($item->adicionais as $adicional)
                        <li>{{ $adicional->quantidade }}x {{ $adicional->ingrediente->nome }} - R$ {{ number_format($adicional->quantidade * $adicional->preco_unitario, 2, ',', '.') }}</li>
                    @endforeach
                </ul>
            </li>
        @endforeach
    </ul>

    <h2>Valores</h2>
    <p>Subtotal: R$ {{ number_format($pedido->subtotal, 2, ',', '.') }}</p>
    <p>Taxa de entrega: R$ {{ number_format($pedido->taxa_entrega, 2, ',', '.') }}</p>
    <p>Desconto: R$ {{ number_format($pedido->valor_desconto, 2, ',', '.') }} @if ($pedido->cupom) ({{ $pedido->cupom->codigo }}) @endif</p>
    <p>Total: R$ {{ number_format($pedido->valor_total, 2, ',', '.') }}</p>

    <h2>Pagamento</h2>
    @if ($pedido->pagamento)
        <p>{{ $pedido->pagamento->metodo_pagamento }} - {{ $pedido->pagamento->status_pagamento }} - R$ {{ number_format($pedido->pagamento->valor, 2, ',', '.') }}</p>
    @else
        <p>Aguardando pagamento.</p>
    @endif

    @if ($pedido->avaliacao)
        <h2>Avaliação</h2>
        <p>Nota {{ $pedido->avaliacao->nota }}: {{ $pedido->avaliacao->comentario }}</p>
    @endif

    <h2>Ações</h2>

    @if ($pedido->status === 'RECEBIDO')
        <form method="POST" action="{{ route('pedidos.aplicar-cupom', $pedido) }}">
            @csrf
            <label>Cupom <input name="codigo_cupom" required maxlength="30"></label>
            <button type="submit">Aplicar cupom</button>
        </form>

        <form method="POST" action="{{ route('pedidos.registrar-pagamento', $pedido) }}">
            @csrf
            <label>Método
                <select name="metodo_pagamento" required>
                    @foreach (['PIX', 'CARTAO_CREDITO', 'CARTAO_DEBITO', 'DINHEIRO', 'VALE_REFEICAO'] as $metodo)
                        <option value="{{ $metodo }}">{{ $metodo }}</option>
                    @endforeach
                </select>
            </label>
            <button type="submit" name="aprovado" value="1">Pagamento aprovado</button>
            <button type="submit" name="aprovado" value="0">Pagamento recusado</button>
        </form>
    @endif

    @if (in_array($pedido->status, ['EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA']))
        <form method="POST" action="{{ route('pedidos.avancar-status', $pedido) }}">
            @csrf
            <button type="submit">Avançar status</button>
        </form>
    @endif

    @if (! in_array($pedido->status, ['ENTREGUE', 'CANCELADO']))
        <form method="POST" action="{{ route('pedidos.cancelar', $pedido) }}">
            @csrf
            <button type="submit">Cancelar pedido</button>
        </form>
    @endif
@endsection
