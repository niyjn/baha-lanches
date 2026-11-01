<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pagamentos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pedido_id')->constrained('pedidos')->cascadeOnDelete();
            $table->string('metodo_pagamento', 25);
            $table->string('status_pagamento', 20);
            $table->decimal('valor', 10, 2);
            $table->timestampTz('data_pagamento')->useCurrent();
            $table->timestampsTz();
        });

        DB::statement("ALTER TABLE pagamentos ADD CONSTRAINT pagamentos_metodo_pagamento_check CHECK (metodo_pagamento IN ('PIX', 'CARTAO_CREDITO', 'CARTAO_DEBITO', 'DINHEIRO', 'VALE_REFEICAO'))");
        DB::statement("ALTER TABLE pagamentos ADD CONSTRAINT pagamentos_status_pagamento_check CHECK (status_pagamento IN ('PENDENTE', 'APROVADO', 'RECUSADO', 'ESTORNADO'))");
        DB::statement('ALTER TABLE pagamentos ADD CONSTRAINT pagamentos_valor_check CHECK (valor > 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('pagamentos');
    }
};
