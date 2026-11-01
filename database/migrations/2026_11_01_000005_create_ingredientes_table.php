<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ingredientes', function (Blueprint $table) {
            $table->id();
            $table->string('nome', 80)->unique();
            $table->decimal('preco_adicional', 10, 2);
            $table->decimal('custo_unitario', 10, 2);
            $table->boolean('disponivel')->default(true);
            $table->timestampsTz();
        });

        DB::statement('ALTER TABLE ingredientes ADD CONSTRAINT ingredientes_custo_unitario_check CHECK (custo_unitario >= 0)');
        DB::statement('ALTER TABLE ingredientes ADD CONSTRAINT ingredientes_preco_adicional_check CHECK (preco_adicional >= 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('ingredientes');
    }
};
