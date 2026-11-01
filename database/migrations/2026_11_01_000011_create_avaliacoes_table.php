<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('avaliacoes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pedido_id')->unique()->constrained('pedidos')->cascadeOnDelete();
            $table->foreignId('cliente_id')->constrained('clientes');
            $table->integer('nota');
            $table->text('comentario')->nullable();
            $table->timestampTz('data_avaliacao')->useCurrent();
            $table->timestampsTz();
        });

        DB::statement('ALTER TABLE avaliacoes ADD CONSTRAINT avaliacoes_nota_check CHECK (nota >= 1 AND nota <= 5)');
    }

    public function down(): void
    {
        Schema::dropIfExists('avaliacoes');
    }
};
