<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ItemPedido extends Model
{
    protected $table = 'itens_pedido';

    protected $fillable = ['pedido_id', 'produto_id', 'quantidade', 'preco_unitario', 'subtotal_item', 'observacao'];

    protected function casts(): array
    {
        return [
            'preco_unitario' => 'decimal:2',
            'subtotal_item' => 'decimal:2',
        ];
    }

    public function pedido(): BelongsTo
    {
        return $this->belongsTo(Pedido::class);
    }

    public function produto(): BelongsTo
    {
        return $this->belongsTo(Produto::class);
    }

    public function adicionais(): HasMany
    {
        return $this->hasMany(ItemAdicional::class);
    }
}
