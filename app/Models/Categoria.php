<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Categoria extends Model
{
    protected $table = 'categorias';

    protected $fillable = ['nome', 'descricao', 'ordem_exibicao', 'ativo'];

    protected function casts(): array
    {
        return [
            'ativo' => 'boolean',
        ];
    }

    public function produtos(): HasMany
    {
        return $this->hasMany(Produto::class);
    }
}
