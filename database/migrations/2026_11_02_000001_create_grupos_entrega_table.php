<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('grupos_entrega', function (Blueprint $table) {
            $table->id();
            $table->string('nome_grupo', 30)->unique();
            $table->decimal('valor_unitario', 10, 2);
            $table->timestampsTz();
        });

        DB::statement('ALTER TABLE grupos_entrega ADD CONSTRAINT grupos_entrega_valor_unitario_check CHECK (valor_unitario >= 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('grupos_entrega');
    }
};
