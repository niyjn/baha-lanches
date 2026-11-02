@extends('layouts.app')

@section('titulo', 'Novo pedido')

@section('conteudo')
    <h1>Novo pedido</h1>

    <form method="POST" action="{{ route('pedidos.store') }}">
        @csrf

        <label>Cliente e endereço de entrega
            <select name="endereco_id" required>
                <option value="">Selecione</option>
                @foreach ($enderecos as $endereco)
                    <option value="{{ $endereco->id }}" @selected(old('endereco_id') == $endereco->id)>
                        {{ $endereco->cliente->nome }} - {{ $endereco->logradouro }}, {{ $endereco->numero }} ({{ $endereco->bairro }})
                    </option>
                @endforeach
            </select>
        </label>

        @foreach (range(0, 2) as $i)
            <fieldset>
                <legend>Item {{ $i + 1 }}</legend>
                <label>Produto
                    <select name="itens[{{ $i }}][produto_id]">
                        <option value="">Nenhum</option>
                        @foreach ($produtos as $produto)
                            <option value="{{ $produto->id }}" @selected(old("itens.$i.produto_id") == $produto->id)>{{ $produto->nome }} - R$ {{ number_format($produto->preco, 2, ',', '.') }}</option>
                        @endforeach
                    </select>
                </label>
                <label>Quantidade <input type="number" min="1" name="itens[{{ $i }}][quantidade]" value="{{ old("itens.$i.quantidade", 1) }}"></label>
                <label>Observação <input name="itens[{{ $i }}][observacao]" value="{{ old("itens.$i.observacao") }}" maxlength="200"></label>
                <label>Adicional
                    <select name="itens[{{ $i }}][adicionais][0][ingrediente_id]">
                        <option value="">Nenhum</option>
                        @foreach ($ingredientes as $ingrediente)
                            <option value="{{ $ingrediente->id }}" @selected(old("itens.$i.adicionais.0.ingrediente_id") == $ingrediente->id)>{{ $ingrediente->nome }} - R$ {{ number_format($ingrediente->preco_adicional, 2, ',', '.') }}</option>
                        @endforeach
                    </select>
                </label>
                <label>Quantidade do adicional <input type="number" min="1" name="itens[{{ $i }}][adicionais][0][quantidade]" value="{{ old("itens.$i.adicionais.0.quantidade", 1) }}"></label>
            </fieldset>
        @endforeach

        <label>Cupom <input name="codigo_cupom" value="{{ old('codigo_cupom') }}" maxlength="30"></label>
        <label>Observações <textarea name="observacoes">{{ old('observacoes') }}</textarea></label>

        <button type="submit">Criar pedido</button>
    </form>
@endsection
