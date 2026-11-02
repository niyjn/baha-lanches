@csrf

<label>Código <input name="codigo" value="{{ old('codigo', $cupom->codigo ?? '') }}" required maxlength="30"></label>
<label>Tipo
    <select name="tipo_desconto" required>
        @foreach (['PERCENTUAL', 'VALOR_FIXO'] as $tipo)
            <option value="{{ $tipo }}" @selected(old('tipo_desconto', $cupom->tipo_desconto ?? null) === $tipo)>{{ $tipo }}</option>
        @endforeach
    </select>
</label>
<label>Desconto <input type="number" step="0.01" min="0.01" name="valor_desconto" value="{{ old('valor_desconto', $cupom->valor_desconto ?? '') }}" required></label>
<label>Valor mínimo <input type="number" step="0.01" min="0" name="valor_minimo" value="{{ old('valor_minimo', $cupom->valor_minimo ?? '0.00') }}" required></label>
<label>Validade <input type="date" name="data_validade" value="{{ old('data_validade', isset($cupom) ? $cupom->data_validade->format('Y-m-d') : '') }}" required></label>
<label>Limite de usos <input type="number" min="1" name="limite_usos" value="{{ old('limite_usos', $cupom->limite_usos ?? 100) }}" required></label>
<input type="hidden" name="ativo" value="0">
<label><input type="checkbox" name="ativo" value="1" @checked(old('ativo', $cupom->ativo ?? true))> Ativo</label>

<button type="submit">Salvar</button>
