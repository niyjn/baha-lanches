<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Pedido extends Model
{
    protected $table = 'pedidos';

    protected $fillable = ['cliente_id', 'endereco_id', 'cupom_id', 'data_pedido', 'status', 'subtotal', 'taxa_entrega', 'valor_desconto', 'valor_total', 'observacoes'];

    protected function casts(): array
    {
        return [
            'data_pedido' => 'datetime',
            'subtotal' => 'decimal:2',
            'taxa_entrega' => 'decimal:2',
            'valor_desconto' => 'decimal:2',
            'valor_total' => 'decimal:2',
        ];
    }

    public function cliente(): BelongsTo
    {
        return $this->belongsTo(Cliente::class);
    }

    public function endereco(): BelongsTo
    {
        return $this->belongsTo(Endereco::class);
    }

    public function cupom(): BelongsTo
    {
        return $this->belongsTo(Cupom::class);
    }

    public function itens(): HasMany
    {
        return $this->hasMany(ItemPedido::class);
    }

    public function pagamentos(): HasMany
    {
        return $this->hasMany(Pagamento::class);
    }

    public function avaliacao(): HasOne
    {
        return $this->hasOne(Avaliacao::class);
    }
}
