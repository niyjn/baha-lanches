<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('clientes', function (Blueprint $table) {
            $table->id();
            $table->string('nome', 100);
            $table->string('email', 120)->unique();
            $table->string('telefone', 20);
            $table->string('cpf', 14)->unique();
            $table->date('data_nascimento')->nullable();
            $table->timestampTz('data_cadastro')->useCurrent();
            $table->boolean('ativo')->default(true);
            $table->timestampsTz();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('clientes');
    }
};
