<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pedidos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cliente_id')->constrained('clientes');
            $table->foreignId('endereco_id')->constrained('enderecos');
            $table->foreignId('cupom_id')->nullable()->constrained('cupons');
            $table->timestampTz('data_pedido')->useCurrent();
            $table->string('status', 25);
            $table->decimal('subtotal', 10, 2);
            $table->decimal('taxa_entrega', 10, 2)->default('0.00');
            $table->decimal('valor_desconto', 10, 2)->default('0.00');
            $table->decimal('valor_total', 10, 2);
            $table->text('observacoes')->nullable();
            $table->timestampsTz();

            $table->index('data_pedido', 'idx_gabriel_data_pedido_pedidos');
            $table->index('cliente_id', 'idx_gabriel_id_cliente_pedidos');
        });

        DB::statement("ALTER TABLE pedidos ADD CONSTRAINT pedidos_status_check CHECK (status IN ('RECEBIDO', 'EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA', 'ENTREGUE', 'CANCELADO'))");
        DB::statement('ALTER TABLE pedidos ADD CONSTRAINT pedidos_subtotal_check CHECK (subtotal >= 0)');
        DB::statement('ALTER TABLE pedidos ADD CONSTRAINT pedidos_taxa_entrega_check CHECK (taxa_entrega >= 0)');
        DB::statement('ALTER TABLE pedidos ADD CONSTRAINT pedidos_valor_desconto_check CHECK (valor_desconto >= 0)');
        DB::statement('ALTER TABLE pedidos ADD CONSTRAINT pedidos_valor_total_check CHECK (valor_total >= 0)');
    }

    public function down(): void
    {
        Schema::dropIfExists('pedidos');
    }
};
