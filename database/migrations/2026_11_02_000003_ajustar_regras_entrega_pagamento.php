<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('enderecos', function (Blueprint $table) {
            $table->char('estado', 2)->default('PR')->change();
        });

        Schema::table('pagamentos', function (Blueprint $table) {
            $table->unique('pedido_id');
        });

        // Atualiza os objetos do banco com as regras de entrega e pagamento
        DB::unprepared(file_get_contents(database_path('sql/02_objetos.sql')));
    }

    public function down(): void
    {
        Schema::table('pagamentos', function (Blueprint $table) {
            $table->dropUnique(['pedido_id']);
        });

        Schema::table('enderecos', function (Blueprint $table) {
            $table->char('estado', 2)->default('SP')->change();
        });
    }
};
