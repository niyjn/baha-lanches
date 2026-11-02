<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('produtos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('categoria_id')->constrained('categorias');
            $table->string('nome', 100);
            $table->text('descricao')->nullable();
            $table->decimal('preco', 10, 2);
            $table->decimal('custo_producao', 10, 2);
            $table->boolean('disponivel')->default(true);
            $table->timestampsTz();
        });

        DB::statement('ALTER TABLE produtos ADD CONSTRAINT produtos_custo_producao_check CHECK (custo_producao >= 0)');
        DB::statement('ALTER TABLE produtos ADD CONSTRAINT produtos_preco_check CHECK (preco >= 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('produtos');
    }
};
