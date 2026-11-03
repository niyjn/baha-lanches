@csrf

<div class="bg-white border rounded p-4" style="max-width: 600px">
    <div class="mb-3">
        <label class="form-label" for="nome">Nome</label>
        <input class="form-control" id="nome" name="nome" value="{{ old('nome', $categoria->nome ?? '') }}" required maxlength="60">
    </div>

    <div class="mb-3">
        <label class="form-label" for="descricao">Descrição</label>
        <textarea class="form-control" id="descricao" name="descricao" rows="3">{{ old('descricao', $categoria->descricao ?? '') }}</textarea>
    </div>

    <div class="mb-3">
        <label class="form-label" for="ordem_exibicao">Ordem de exibição</label>
        <input class="form-control" type="number" id="ordem_exibicao" name="ordem_exibicao" min="1" value="{{ old('ordem_exibicao', $categoria->ordem_exibicao ?? 1) }}" required>
    </div>

    <input type="hidden" name="ativo" value="0">
    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="ativo" name="ativo" value="1" @checked(old('ativo', $categoria->ativo ?? true))>
        <label class="form-check-label" for="ativo">Ativa</label>
    </div>

    <button type="submit" class="btn btn-primary">Salvar</button>
</div>
