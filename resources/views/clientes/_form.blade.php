@csrf

<div class="bg-white border rounded p-4" style="max-width: 600px">
    <div class="mb-3">
        <label class="form-label" for="nome">Nome</label>
        <input class="form-control" id="nome" name="nome" value="{{ old('nome', $cliente->nome ?? '') }}" required maxlength="100">
    </div>

    <div class="mb-3">
        <label class="form-label" for="email">E-mail</label>
        <input class="form-control" type="email" id="email" name="email" value="{{ old('email', $cliente->email ?? '') }}" required maxlength="120">
    </div>

    <div class="mb-3">
        <label class="form-label" for="telefone">Telefone</label>
        <input class="form-control" id="telefone" name="telefone" value="{{ old('telefone', $cliente->telefone ?? '') }}" required maxlength="20">
    </div>

    <div class="mb-3">
        <label class="form-label" for="cpf">CPF</label>
        <input class="form-control" id="cpf" name="cpf" placeholder="000.000.000-00" value="{{ old('cpf', $cliente->cpf ?? '') }}" required maxlength="14">
    </div>

    <div class="mb-3">
        <label class="form-label" for="data_nascimento">Nascimento</label>
        <input class="form-control" type="date" id="data_nascimento" name="data_nascimento" value="{{ old('data_nascimento', isset($cliente) ? $cliente->data_nascimento?->format('Y-m-d') : '') }}">
    </div>

    <input type="hidden" name="ativo" value="0">
    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="ativo" name="ativo" value="1" @checked(old('ativo', $cliente->ativo ?? true))>
        <label class="form-check-label" for="ativo">Ativo</label>
    </div>

    <button type="submit" class="btn btn-primary">Salvar</button>
</div>
