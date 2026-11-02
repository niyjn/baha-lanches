<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Pagamento extends Model
{
    protected $table = 'pagamentos';

    protected $fillable = ['pedido_id', 'metodo_pagamento', 'status_pagamento', 'valor', 'data_pagamento'];

    protected function casts(): array
    {
        return [
            'valor' => 'decimal:2',
            'data_pagamento' => 'datetime',
        ];
    }

    public function pedido(): BelongsTo
    {
        return $this->belongsTo(Pedido::class);
    }
}
