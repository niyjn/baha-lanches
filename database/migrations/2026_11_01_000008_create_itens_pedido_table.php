<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('itens_pedido', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pedido_id')->constrained('pedidos')->cascadeOnDelete();
            $table->foreignId('produto_id')->constrained('produtos');
            $table->integer('quantidade');
            $table->decimal('preco_unitario', 10, 2);
            $table->decimal('subtotal_item', 10, 2);
            $table->string('observacao', 200)->nullable();
            $table->timestampsTz();

            $table->index('pedido_id', 'idx_gabriel_id_pedido_itens_pedido');
        });

        DB::statement('ALTER TABLE itens_pedido ADD CONSTRAINT itens_pedido_preco_unitario_check CHECK (preco_unitario >= 0)');
        DB::statement('ALTER TABLE itens_pedido ADD CONSTRAINT itens_pedido_quantidade_check CHECK (quantidade > 0)');
        DB::statement('ALTER TABLE itens_pedido ADD CONSTRAINT itens_pedido_subtotal_item_check CHECK (subtotal_item >= 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('itens_pedido');
    }
};
