-- Consultas das telas do sistema; incluído pelo 06_explain_indices.sql.

\qecho '> idx_pedidos_abertos_data: pedidos em aberto, do mais antigo para o mais novo'
EXPLAIN (ANALYZE, BUFFERS, COSTS OFF)
SELECT id, status, data_pedido
FROM pedidos
WHERE status IN ('RECEBIDO', 'EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA')
ORDER BY data_pedido
LIMIT 50;

\qecho '> idx_gabriel_data_pedido_pedidos: pedidos de um período'
EXPLAIN (ANALYZE, BUFFERS, COSTS OFF)
SELECT id, status, valor_total
FROM pedidos
WHERE data_pedido >= '2024-01-01' AND data_pedido < '2024-01-08';

\qecho '> idx_gabriel_id_cliente_pedidos: pedidos de um cliente'
EXPLAIN (ANALYZE, BUFFERS, COSTS OFF)
SELECT id, status, valor_total
FROM pedidos
WHERE cliente_id = 1;

\qecho '> idx_gabriel_id_pedido_itens_pedido: itens de um pedido'
EXPLAIN (ANALYZE, BUFFERS, COSTS OFF)
SELECT id, produto_id, quantidade, subtotal_item
FROM itens_pedido
WHERE pedido_id = 1;
