<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Ingrediente extends Model
{
    protected $table = 'ingredientes';

    protected $fillable = ['nome', 'preco_adicional', 'custo_unitario', 'disponivel'];

    protected function casts(): array
    {
        return [
            'preco_adicional' => 'decimal:2',
            'custo_unitario' => 'decimal:2',
            'disponivel' => 'boolean',
        ];
    }

    public function itemAdicionais(): HasMany
    {
        return $this->hasMany(ItemAdicional::class);
    }
}
