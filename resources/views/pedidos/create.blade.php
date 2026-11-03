@extends('layouts.app')

@section('titulo', 'Novo pedido')

@section('conteudo')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">Novo pedido</h1>
        <a class="btn btn-outline-secondary" href="{{ route('pedidos.index') }}">Voltar</a>
    </div>

    <form method="POST" action="{{ route('pedidos.store') }}" style="max-width: 800px">
        @csrf

        <div class="bg-white border rounded p-4 mb-3">
            <label class="form-label" for="endereco_id">Cliente e endereço de entrega</label>
            <select class="form-select" id="endereco_id" name="endereco_id" required>
                <option value="">Selecione</option>
                @foreach ($enderecos as $endereco)
                    <option value="{{ $endereco->id }}" @selected(old('endereco_id') == $endereco->id)>
                        {{ $endereco->cliente->nome }} - {{ $endereco->logradouro }}, {{ $endereco->numero }} ({{ $endereco->bairro }})
                    </option>
                @endforeach
            </select>
        </div>

        <h2 class="h5">Itens</h2>
        @php $itensAntigos = old('itens') ?: [[]]; @endphp
        <div id="itens">
            @foreach ($itensAntigos as $i => $item)
                @include('pedidos._item', ['i' => $i, 'item' => $item])
            @endforeach
        </div>
        <button type="button" id="adicionar-item" class="btn btn-outline-primary mb-4">+ Adicionar item</button>

        <div class="bg-white border rounded p-4 mb-3">
            <div class="mb-3">
                <label class="form-label" for="codigo_cupom">Cupom</label>
                <input class="form-control" id="codigo_cupom" name="codigo_cupom" value="{{ old('codigo_cupom') }}" maxlength="30">
            </div>
            <div>
                <label class="form-label" for="observacoes">Observações</label>
                <textarea class="form-control" id="observacoes" name="observacoes" rows="3">{{ old('observacoes') }}</textarea>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Criar pedido</button>
    </form>

    <template id="modelo-item">
        @include('pedidos._item', ['i' => '__INDEX__', 'item' => []])
    </template>

    <script>
        const lista = document.getElementById('itens');
        const modelo = document.getElementById('modelo-item');
        let proximo = lista.querySelectorAll('.item-pedido').length;

        document.getElementById('adicionar-item').addEventListener('click', () => {
            lista.insertAdjacentHTML('beforeend', modelo.innerHTML.replaceAll('__INDEX__', proximo++));
        });

        lista.addEventListener('click', (evento) => {
            if (evento.target.classList.contains('remover-item')) {
                evento.target.closest('.item-pedido').remove();
            }
        });
    </script>
@endsection
