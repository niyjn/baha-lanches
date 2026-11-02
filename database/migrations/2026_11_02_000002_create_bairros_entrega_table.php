<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('bairros_entrega', function (Blueprint $table) {
            $table->id();
            $table->string('bairro', 80)->unique();
            $table->foreignId('grupo_entrega_id')->constrained('grupos_entrega');
            $table->timestampsTz();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bairros_entrega');
    }
};
