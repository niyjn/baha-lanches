<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Cliente extends Model
{
    protected $table = 'clientes';

    protected $fillable = ['nome', 'email', 'telefone', 'cpf', 'data_nascimento', 'data_cadastro', 'ativo'];

    protected function casts(): array
    {
        return [
            'data_nascimento' => 'date',
            'data_cadastro' => 'datetime',
            'ativo' => 'boolean',
        ];
    }

    public function enderecos(): HasMany
    {
        return $this->hasMany(Endereco::class);
    }

    public function pedidos(): HasMany
    {
        return $this->hasMany(Pedido::class);
    }

    public function avaliacoes(): HasMany
    {
        return $this->hasMany(Avaliacao::class);
    }
}
