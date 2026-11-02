@csrf

<label>Nome <input name="nome" value="{{ old('nome', $categoria->nome ?? '') }}" required maxlength="60"></label>
<label>Descrição <textarea name="descricao">{{ old('descricao', $categoria->descricao ?? '') }}</textarea></label>
<label>Ordem de exibição <input type="number" name="ordem_exibicao" min="1" value="{{ old('ordem_exibicao', $categoria->ordem_exibicao ?? 1) }}" required></label>
<input type="hidden" name="ativo" value="0">
<label><input type="checkbox" name="ativo" value="1" @checked(old('ativo', $categoria->ativo ?? true))> Ativa</label>

<button type="submit">Salvar</button>
