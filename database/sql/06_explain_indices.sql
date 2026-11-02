-- Compara os planos de execução sem e com os índices, com os dados reais e com volume simulado.
-- Tudo roda em uma transação desfeita no final, mas use um banco restaurado, nunca o principal:
-- DROP INDEX bloqueia as tabelas até o fim da transação.

\set ON_ERROR_STOP on

SET search_path TO baha_lanches;

BEGIN;

\qecho '=============================================================='
\qecho '1. Dados reais, SEM os índices'
\qecho '=============================================================='
DROP INDEX idx_pedidos_abertos_data, idx_gabriel_data_pedido_pedidos, idx_gabriel_id_cliente_pedidos, idx_gabriel_id_pedido_itens_pedido;
ANALYZE pedidos, itens_pedido;
\ir 06_explain_consultas.sql

\qecho '=============================================================='
\qecho '2. Dados reais, COM os índices'
\qecho '=============================================================='
CREATE INDEX idx_pedidos_abertos_data ON pedidos (data_pedido) WHERE status IN ('RECEBIDO', 'EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA');
CREATE INDEX idx_gabriel_data_pedido_pedidos ON pedidos (data_pedido);
CREATE INDEX idx_gabriel_id_cliente_pedidos ON pedidos (cliente_id);
CREATE INDEX idx_gabriel_id_pedido_itens_pedido ON itens_pedido (pedido_id);
ANALYZE pedidos, itens_pedido;
\ir 06_explain_consultas.sql

\qecho '=============================================================='
\qecho '3. Volume simulado (+100 mil pedidos e +200 mil itens), SEM os índices'
\qecho '=============================================================='
DROP INDEX idx_pedidos_abertos_data, idx_gabriel_data_pedido_pedidos, idx_gabriel_id_cliente_pedidos, idx_gabriel_id_pedido_itens_pedido;
ALTER TABLE itens_pedido DISABLE TRIGGER USER;

INSERT INTO pedidos (cliente_id, endereco_id, data_pedido, status, subtotal, taxa_entrega, valor_desconto, valor_total)
SELECT e.cliente_id, e.id, TIMESTAMPTZ '2021-01-01' + g * INTERVAL '20 minutes',
       CASE WHEN g % 100 = 0 THEN 'EM_PREPARO' WHEN g % 100 = 1 THEN 'CANCELADO' ELSE 'ENTREGUE' END,
       50, 6, 0, 56
FROM generate_series(1, 100000) AS g
JOIN enderecos e ON e.id = g % 120 + 1;

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario, subtotal_item)
SELECT p.id, (p.id + n) % 31 + 1, 1, 25, 25
FROM pedidos p
CROSS JOIN generate_series(1, 2) AS n
WHERE p.id > 480;

ANALYZE pedidos, itens_pedido;
\ir 06_explain_consultas.sql

\qecho '=============================================================='
\qecho '4. Volume simulado, COM os índices'
\qecho '=============================================================='
CREATE INDEX idx_pedidos_abertos_data ON pedidos (data_pedido) WHERE status IN ('RECEBIDO', 'EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA');
CREATE INDEX idx_gabriel_data_pedido_pedidos ON pedidos (data_pedido);
CREATE INDEX idx_gabriel_id_cliente_pedidos ON pedidos (cliente_id);
CREATE INDEX idx_gabriel_id_pedido_itens_pedido ON itens_pedido (pedido_id);
ANALYZE pedidos, itens_pedido;
\ir 06_explain_consultas.sql

ROLLBACK;
