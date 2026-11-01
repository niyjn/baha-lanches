<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Cupom extends Model
{
    protected $table = 'cupons';

    protected $fillable = ['codigo', 'tipo_desconto', 'valor_desconto', 'valor_minimo', 'data_validade', 'limite_usos', 'ativo'];

    protected function casts(): array
    {
        return [
            'valor_desconto' => 'decimal:2',
            'valor_minimo' => 'decimal:2',
            'data_validade' => 'datetime',
            'ativo' => 'boolean',
        ];
    }

    public function pedidos(): HasMany
    {
        return $this->hasMany(Pedido::class);
    }
}
