<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Endereco extends Model
{
    protected $table = 'enderecos';

    protected $fillable = ['cliente_id', 'logradouro', 'numero', 'complemento', 'bairro', 'cidade', 'estado', 'cep', 'ponto_referencia', 'e_principal'];

    protected function casts(): array
    {
        return [
            'e_principal' => 'boolean',
        ];
    }

    public function cliente(): BelongsTo
    {
        return $this->belongsTo(Cliente::class);
    }

    public function pedidos(): HasMany
    {
        return $this->hasMany(Pedido::class);
    }
}
