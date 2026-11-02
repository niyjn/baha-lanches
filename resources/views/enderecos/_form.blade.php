@csrf

<label>Logradouro <input name="logradouro" value="{{ old('logradouro', $endereco->logradouro ?? '') }}" required maxlength="150"></label>
<label>Número <input name="numero" value="{{ old('numero', $endereco->numero ?? '') }}" required maxlength="20"></label>
<label>Complemento <input name="complemento" value="{{ old('complemento', $endereco->complemento ?? '') }}" maxlength="100"></label>
<label>Bairro
    <select name="bairro" required>
        @foreach ($bairros as $bairro)
            <option value="{{ $bairro }}" @selected(old('bairro', $endereco->bairro ?? null) === $bairro)>{{ $bairro }}</option>
        @endforeach
    </select>
</label>
<label>CEP <input name="cep" placeholder="00000-000" value="{{ old('cep', $endereco->cep ?? '') }}" required maxlength="10"></label>
<label>Ponto de referência <input name="ponto_referencia" value="{{ old('ponto_referencia', $endereco->ponto_referencia ?? '') }}" maxlength="150"></label>
<input type="hidden" name="e_principal" value="0">
<label><input type="checkbox" name="e_principal" value="1" @checked(old('e_principal', $endereco->e_principal ?? false))> Endereço principal</label>

<button type="submit">Salvar</button>
