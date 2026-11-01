<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('item_adicionais', function (Blueprint $table) {
            $table->id();
            $table->foreignId('item_pedido_id')->constrained('itens_pedido')->cascadeOnDelete();
            $table->foreignId('ingrediente_id')->constrained('ingredientes');
            $table->integer('quantidade')->default(1);
            $table->decimal('preco_unitario', 10, 2);
            $table->timestampsTz();
        });

        DB::statement('ALTER TABLE item_adicionais ADD CONSTRAINT item_adicionais_preco_unitario_check CHECK (preco_unitario >= 0)');
        DB::statement('ALTER TABLE item_adicionais ADD CONSTRAINT item_adicionais_quantidade_check CHECK (quantidade > 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('item_adicionais');
    }
};
