@csrf

<label>Categoria
    <select name="categoria_id" required>
        @foreach ($categorias as $categoria)
            <option value="{{ $categoria->id }}" @selected(old('categoria_id', $produto->categoria_id ?? null) == $categoria->id)>{{ $categoria->nome }}</option>
        @endforeach
    </select>
</label>
<label>Nome <input name="nome" value="{{ old('nome', $produto->nome ?? '') }}" required maxlength="100"></label>
<label>Descrição <textarea name="descricao">{{ old('descricao', $produto->descricao ?? '') }}</textarea></label>
<label>Preço <input type="number" step="0.01" min="0" name="preco" value="{{ old('preco', $produto->preco ?? '') }}" required></label>
<label>Custo de produção <input type="number" step="0.01" min="0" name="custo_producao" value="{{ old('custo_producao', $produto->custo_producao ?? '') }}" required></label>
<input type="hidden" name="disponivel" value="0">
<label><input type="checkbox" name="disponivel" value="1" @checked(old('disponivel', $produto->disponivel ?? true))> Disponível</label>

<button type="submit">Salvar</button>
