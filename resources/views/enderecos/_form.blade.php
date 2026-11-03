@csrf

<div class="bg-white border rounded p-4" style="max-width: 600px">
    <div class="mb-3">
        <label class="form-label" for="logradouro">Logradouro</label>
        <input class="form-control" id="logradouro" name="logradouro" value="{{ old('logradouro', $endereco->logradouro ?? '') }}" required maxlength="150">
    </div>

    <div class="mb-3">
        <label class="form-label" for="numero">Número</label>
        <input class="form-control" id="numero" name="numero" value="{{ old('numero', $endereco->numero ?? '') }}" required maxlength="20">
    </div>

    <div class="mb-3">
        <label class="form-label" for="complemento">Complemento</label>
        <input class="form-control" id="complemento" name="complemento" value="{{ old('complemento', $endereco->complemento ?? '') }}" maxlength="100">
    </div>

    <div class="mb-3">
        <label class="form-label" for="bairro">Bairro</label>
        <select class="form-select" id="bairro" name="bairro" required>
            @foreach ($bairros as $bairro)
                <option value="{{ $bairro }}" @selected(old('bairro', $endereco->bairro ?? null) === $bairro)>{{ $bairro }}</option>
            @endforeach
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label" for="cep">CEP</label>
        <input class="form-control" id="cep" name="cep" placeholder="00000-000" value="{{ old('cep', $endereco->cep ?? '') }}" required maxlength="10">
    </div>

    <div class="mb-3">
        <label class="form-label" for="ponto_referencia">Ponto de referência</label>
        <input class="form-control" id="ponto_referencia" name="ponto_referencia" value="{{ old('ponto_referencia', $endereco->ponto_referencia ?? '') }}" maxlength="150">
    </div>

    <input type="hidden" name="e_principal" value="0">
    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="e_principal" name="e_principal" value="1" @checked(old('e_principal', $endereco->e_principal ?? false))>
        <label class="form-check-label" for="e_principal">Endereço principal</label>
    </div>

    <button type="submit" class="btn btn-primary">Salvar</button>
</div>
