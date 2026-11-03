<fieldset class="item-pedido bg-white border rounded p-3 mb-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <legend class="h6 mb-0 float-none w-auto">Item</legend>
        <button type="button" class="btn btn-sm btn-outline-danger remover-item">Remover</button>
    </div>

    <div class="row g-3">
        <div class="col-md-8">
            <label class="form-label w-100">Produto
                <select class="form-select" name="itens[{{ $i }}][produto_id]">
                    <option value="">Selecione</option>
                    @foreach ($produtos as $produto)
                        <option value="{{ $produto->id }}" @selected(($item['produto_id'] ?? null) == $produto->id)>{{ $produto->nome }} - R$ {{ number_format($produto->preco, 2, ',', '.') }}</option>
                    @endforeach
                </select>
            </label>
        </div>
        <div class="col-md-4">
            <label class="form-label w-100">Quantidade
                <input class="form-control" type="number" min="1" name="itens[{{ $i }}][quantidade]" value="{{ $item['quantidade'] ?? 1 }}">
            </label>
        </div>

        <div class="col-12">
            <label class="form-label w-100">Observação
                <input class="form-control" name="itens[{{ $i }}][observacao]" value="{{ $item['observacao'] ?? '' }}" maxlength="200">
            </label>
        </div>

        <div class="col-md-8">
            <label class="form-label w-100">Adicional
                <select class="form-select" name="itens[{{ $i }}][adicionais][0][ingrediente_id]">
                    <option value="">Nenhum</option>
                    @foreach ($ingredientes as $ingrediente)
                        <option value="{{ $ingrediente->id }}" @selected(($item['adicionais'][0]['ingrediente_id'] ?? null) == $ingrediente->id)>{{ $ingrediente->nome }} - R$ {{ number_format($ingrediente->preco_adicional, 2, ',', '.') }}</option>
                    @endforeach
                </select>
            </label>
        </div>
        <div class="col-md-4">
            <label class="form-label w-100">Qtd. do adicional
                <input class="form-control" type="number" min="1" name="itens[{{ $i }}][adicionais][0][quantidade]" value="{{ $item['adicionais'][0]['quantidade'] ?? 1 }}">
            </label>
        </div>
    </div>
</fieldset>

