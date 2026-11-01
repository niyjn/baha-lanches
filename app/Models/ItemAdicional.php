<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ItemAdicional extends Model
{
    protected $table = 'item_adicionais';

    protected $fillable = ['item_pedido_id', 'ingrediente_id', 'quantidade', 'preco_unitario'];

    protected function casts(): array
    {
        return [
            'preco_unitario' => 'decimal:2',
        ];
    }

    public function itemPedido(): BelongsTo
    {
        return $this->belongsTo(ItemPedido::class);
    }

    public function ingrediente(): BelongsTo
    {
        return $this->belongsTo(Ingrediente::class);
    }
}
