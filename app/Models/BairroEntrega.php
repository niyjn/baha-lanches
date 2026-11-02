<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BairroEntrega extends Model
{
    protected $table = 'bairros_entrega';

    protected $fillable = ['bairro', 'grupo_entrega_id'];

    public function grupoEntrega(): BelongsTo
    {
        return $this->belongsTo(GrupoEntrega::class);
    }
}
