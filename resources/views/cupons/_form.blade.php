@csrf

<div class="bg-white border rounded p-4" style="max-width: 600px">
    <div class="mb-3">
        <label class="form-label" for="codigo">Código</label>
        <input class="form-control" id="codigo" name="codigo" value="{{ old('codigo', $cupom->codigo ?? '') }}" required maxlength="30">
    </div>

    <div class="mb-3">
        <label class="form-label" for="tipo_desconto">Tipo</label>
        <select class="form-select" id="tipo_desconto" name="tipo_desconto" required>
            @foreach (['PERCENTUAL', 'VALOR_FIXO'] as $tipo)
                <option value="{{ $tipo }}" @selected(old('tipo_desconto', $cupom->tipo_desconto ?? null) === $tipo)>{{ $tipo }}</option>
            @endforeach
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label" for="valor_desconto">Desconto</label>
        <input class="form-control" type="number" step="0.01" min="0.01" id="valor_desconto" name="valor_desconto" value="{{ old('valor_desconto', $cupom->valor_desconto ?? '') }}" required>
    </div>

    <div class="mb-3">
        <label class="form-label" for="valor_minimo">Valor mínimo</label>
        <input class="form-control" type="number" step="0.01" min="0" id="valor_minimo" name="valor_minimo" value="{{ old('valor_minimo', $cupom->valor_minimo ?? '0.00') }}" required>
    </div>

    <div class="mb-3">
        <label class="form-label" for="data_validade">Validade</label>
        <input class="form-control" type="date" id="data_validade" name="data_validade" value="{{ old('data_validade', isset($cupom) ? $cupom->data_validade->format('Y-m-d') : '') }}" required>
    </div>

    <div class="mb-3">
        <label class="form-label" for="limite_usos">Limite de usos</label>
        <input class="form-control" type="number" min="1" id="limite_usos" name="limite_usos" value="{{ old('limite_usos', $cupom->limite_usos ?? 100) }}" required>
    </div>

    <input type="hidden" name="ativo" value="0">
    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="ativo" name="ativo" value="1" @checked(old('ativo', $cupom->ativo ?? true))>
        <label class="form-check-label" for="ativo">Ativo</label>
    </div>

    <button type="submit" class="btn btn-primary">Salvar</button>
</div>
