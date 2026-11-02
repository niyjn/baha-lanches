<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class GrupoEntrega extends Model
{
    protected $table = 'grupos_entrega';

    protected $fillable = ['nome_grupo', 'valor_unitario'];

    protected function casts(): array
    {
        return [
            'valor_unitario' => 'decimal:2',
        ];
    }

    public function bairros(): HasMany
    {
        return $this->hasMany(BairroEntrega::class);
    }
}
