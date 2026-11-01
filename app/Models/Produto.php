<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Produto extends Model
{
    protected $table = 'produtos';

    protected $fillable = ['categoria_id', 'nome', 'descricao', 'preco', 'custo_producao', 'disponivel'];

    protected function casts(): array
    {
        return [
            'preco' => 'decimal:2',
            'custo_producao' => 'decimal:2',
            'disponivel' => 'boolean',
        ];
    }

    public function categoria(): BelongsTo
    {
        return $this->belongsTo(Categoria::class);
    }

    public function itensPedido(): HasMany
    {
        return $this->hasMany(ItemPedido::class);
    }
}
