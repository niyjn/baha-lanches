<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::unprepared(file_get_contents(database_path('sql/02_objetos.sql')));
    }

    public function down(): void
    {
        DB::unprepared(<<<'SQL'
            DROP TRIGGER IF EXISTS trg_pedidos_validar_status ON pedidos;
            DROP TRIGGER IF EXISTS trg_adicionais_recalcular_total ON item_adicionais;
            DROP TRIGGER IF EXISTS trg_itens_recalcular_total ON itens_pedido;
            DROP FUNCTION IF EXISTS fn_trg_validar_status_pedido();
            DROP FUNCTION IF EXISTS fn_trg_recalcular_total_pedido();
            DROP PROCEDURE IF EXISTS sp_cancelar_pedido(bigint);
            DROP PROCEDURE IF EXISTS sp_aplicar_cupom(bigint, varchar);
            DROP FUNCTION IF EXISTS fn_taxa_entrega(varchar);
            DROP FUNCTION IF EXISTS fn_calcular_desconto_cupom(bigint, numeric, bigint);
            DROP FUNCTION IF EXISTS fn_subtotal_pedido(bigint);
            DROP INDEX IF EXISTS idx_pedidos_abertos_data;
            DROP INDEX IF EXISTS uq_enderecos_cliente_principal;
            SQL);
    }
};
