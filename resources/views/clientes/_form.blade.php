@csrf

<label>Nome <input name="nome" value="{{ old('nome', $cliente->nome ?? '') }}" required maxlength="100"></label>
<label>E-mail <input type="email" name="email" value="{{ old('email', $cliente->email ?? '') }}" required maxlength="120"></label>
<label>Telefone <input name="telefone" value="{{ old('telefone', $cliente->telefone ?? '') }}" required maxlength="20"></label>
<label>CPF <input name="cpf" placeholder="000.000.000-00" value="{{ old('cpf', $cliente->cpf ?? '') }}" required maxlength="14"></label>
<label>Nascimento <input type="date" name="data_nascimento" value="{{ old('data_nascimento', isset($cliente) ? $cliente->data_nascimento?->format('Y-m-d') : '') }}"></label>
<input type="hidden" name="ativo" value="0">
<label><input type="checkbox" name="ativo" value="1" @checked(old('ativo', $cliente->ativo ?? true))> Ativo</label>

<button type="submit">Salvar</button>
