<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cupons', function (Blueprint $table) {
            $table->id();
            $table->string('codigo', 30)->unique();
            $table->string('tipo_desconto', 15);
            $table->decimal('valor_desconto', 10, 2);
            $table->decimal('valor_minimo', 10, 2)->default('0.00');
            $table->timestampTz('data_validade');
            $table->integer('limite_usos')->default(100);
            $table->boolean('ativo')->default(true);
            $table->timestampsTz();
        });

        DB::statement("ALTER TABLE cupons ADD CONSTRAINT cupons_tipo_desconto_check CHECK (tipo_desconto IN ('PERCENTUAL', 'VALOR_FIXO'))");
        DB::statement('ALTER TABLE cupons ADD CONSTRAINT cupons_valor_desconto_check CHECK (valor_desconto > 0)');
        DB::statement('ALTER TABLE cupons ADD CONSTRAINT cupons_valor_minimo_check CHECK (valor_minimo >= 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('cupons');
    }
};
