@extends('layouts.app')

@section('titulo', 'Pedido '.$pedido->id)

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">
            Pedido {{ $pedido->id }}
            @include('pedidos._status', ['status' => $pedido->status])
        </h1>
        <a class="btn btn-outline-secondary" href="{{ route('pedidos.index') }}">Voltar</a>
    </div>

    <div class="row g-3">
        <div class="col-lg-8">
            <div class="card mb-3">
                <div class="card-header">Dados do pedido</div>
                <div class="card-body">
                    <dl class="row mb-0">
                        <dt class="col-sm-3">Data</dt>
                        <dd class="col-sm-9">{{ $pedido->data_pedido->format('d/m/Y H:i') }}</dd>

                        <dt class="col-sm-3">Cliente</dt>
                        <dd class="col-sm-9"><a href="{{ route('clientes.show', $pedido->cliente) }}">{{ $pedido->cliente->nome }}</a></dd>

                        <dt class="col-sm-3">Entrega</dt>
                        <dd class="col-sm-9">{{ $pedido->endereco->logradouro }}, {{ $pedido->endereco->numero }} - {{ $pedido->endereco->bairro }}</dd>

                        <dt class="col-sm-3">Observações</dt>
                        <dd class="col-sm-9 mb-0">{{ $pedido->observacoes }}</dd>
                    </dl>
                </div>
            </div>

            <div class="card">
                <div class="card-header">Itens</div>
                <ul class="list-group list-group-flush">
                    @foreach ($pedido->itens as $item)
                        <li class="list-group-item">
                            <div class="d-flex justify-content-between">
                                <span>{{ $item->quantidade }}x {{ $item->produto->nome }}</span>
                                <span>R$ {{ number_format($item->subtotal_item, 2, ',', '.') }}</span>
                            </div>
                            @foreach ($item->adicionais as $adicional)
                                <div class="d-flex justify-content-between small text-muted ps-3">
                                    <span>+ {{ $adicional->quantidade }}x {{ $adicional->ingrediente->nome }}</span>
                                    <span>R$ {{ number_format($adicional->quantidade * $adicional->preco_unitario, 2, ',', '.') }}</span>
                                </div>
                            @endforeach
                        </li>
                    @endforeach
                </ul>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card mb-3">
                <div class="card-header">Valores</div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item d-flex justify-content-between">
                        <span>Subtotal</span>
                        <span>R$ {{ number_format($pedido->subtotal, 2, ',', '.') }}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between">
                        <span>Taxa de entrega</span>
                        <span>R$ {{ number_format($pedido->taxa_entrega, 2, ',', '.') }}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between">
                        <span>
                            Desconto
                            @if ($pedido->cupom)
                                <span class="badge text-bg-light border">{{ $pedido->cupom->codigo }}</span>
                            @endif
                        </span>
                        <span>R$ {{ number_format($pedido->valor_desconto, 2, ',', '.') }}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between fw-bold fs-5">
                        <span>Total</span>
                        <span>R$ {{ number_format($pedido->valor_total, 2, ',', '.') }}</span>
                    </li>
                </ul>
            </div>

            <div class="card mb-3">
                <div class="card-header">Pagamento</div>
                <div class="card-body">
                    @if ($pedido->pagamento)
                        {{ $pedido->pagamento->metodo_pagamento }} - {{ $pedido->pagamento->status_pagamento }} - R$ {{ number_format($pedido->pagamento->valor, 2, ',', '.') }}
                    @else
                        <span class="text-muted">Aguardando pagamento.</span>
                    @endif
                </div>
            </div>

            @if ($pedido->avaliacao)
                <div class="card mb-3">
                    <div class="card-header">Avaliação</div>
                    <div class="card-body">
                        Nota {{ $pedido->avaliacao->nota }}: {{ $pedido->avaliacao->comentario }}
                    </div>
                </div>
            @endif
        </div>
    </div>

    @if (! in_array($pedido->status, ['ENTREGUE', 'CANCELADO']))
        <div class="card mt-3">
            <div class="card-header">Ações</div>
            <div class="card-body">
                @if ($pedido->status === 'RECEBIDO')
                    <form class="d-flex gap-2 mb-3" method="POST" action="{{ route('pedidos.aplicar-cupom', $pedido) }}">
                        @csrf
                        <input class="form-control w-auto" name="codigo_cupom" placeholder="Código do cupom" aria-label="Código do cupom" required maxlength="30">
                        <button type="submit" class="btn btn-outline-primary">Aplicar cupom</button>
                    </form>

                    <form class="d-flex flex-wrap gap-2 mb-3" method="POST" action="{{ route('pedidos.registrar-pagamento', $pedido) }}">
                        @csrf
                        <select class="form-select w-auto" name="metodo_pagamento" aria-label="Método de pagamento" required>
                            @foreach (['PIX', 'CARTAO_CREDITO', 'CARTAO_DEBITO', 'DINHEIRO', 'VALE_REFEICAO'] as $metodo)
                                <option value="{{ $metodo }}">{{ $metodo }}</option>
                            @endforeach
                        </select>
                        <button type="submit" class="btn btn-success" name="aprovado" value="1">Pagamento aprovado</button>
                        <button type="submit" class="btn btn-outline-danger" name="aprovado" value="0">Pagamento recusado</button>
                    </form>
                @endif

                <div class="d-flex flex-wrap gap-2">
                    @if (in_array($pedido->status, ['EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA']))
                        <form method="POST" action="{{ route('pedidos.avancar-status', $pedido) }}">
                            @csrf
                            <button type="submit" class="btn btn-primary">Avançar status</button>
                        </form>
                    @endif

                    <form method="POST" action="{{ route('pedidos.cancelar', $pedido) }}" onsubmit="return confirm('Cancelar este pedido?')">
                        @csrf
                        <button type="submit" class="btn btn-outline-danger">Cancelar pedido</button>
                    </form>
                </div>
            </div>
        </div>
    @endif
@endsection
