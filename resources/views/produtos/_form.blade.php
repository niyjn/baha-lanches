@csrf

<div class="bg-white border rounded p-4" style="max-width: 600px">
    <div class="mb-3">
        <label class="form-label" for="categoria_id">Categoria</label>
        <select class="form-select" id="categoria_id" name="categoria_id" required>
            @foreach ($categorias as $categoria)
                <option value="{{ $categoria->id }}" @selected(old('categoria_id', $produto->categoria_id ?? null) == $categoria->id)>{{ $categoria->nome }}</option>
            @endforeach
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label" for="nome">Nome</label>
        <input class="form-control" id="nome" name="nome" value="{{ old('nome', $produto->nome ?? '') }}" required maxlength="100">
    </div>

    <div class="mb-3">
        <label class="form-label" for="descricao">Descrição</label>
        <textarea class="form-control" id="descricao" name="descricao" rows="3">{{ old('descricao', $produto->descricao ?? '') }}</textarea>
    </div>

    <div class="mb-3">
        <label class="form-label" for="preco">Preço</label>
        <input class="form-control" type="number" step="0.01" min="0" id="preco" name="preco" value="{{ old('preco', $produto->preco ?? '') }}" required>
    </div>

    <div class="mb-3">
        <label class="form-label" for="custo_producao">Custo de produção</label>
        <input class="form-control" type="number" step="0.01" min="0" id="custo_producao" name="custo_producao" value="{{ old('custo_producao', $produto->custo_producao ?? '') }}" required>
    </div>

    <input type="hidden" name="disponivel" value="0">
    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="disponivel" name="disponivel" value="1" @checked(old('disponivel', $produto->disponivel ?? true))>
        <label class="form-check-label" for="disponivel">Disponível</label>
    </div>

    <button type="submit" class="btn btn-primary">Salvar</button>
</div>
