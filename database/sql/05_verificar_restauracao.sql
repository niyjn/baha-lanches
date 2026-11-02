-- Resume linhas, conteúdo e objetos do banco. Rode no banco original e no restaurado e compare as saídas.

SET search_path TO baha_lanches;

\qecho '--- Tabelas: linhas e md5 do conteúdo'
SELECT c.relname AS tabela,
       (xpath('/row/n/text()', query_to_xml(format('SELECT COUNT(*) AS n FROM %I', c.relname), false, true, '')))[1]::text AS linhas,
       (xpath('/row/m/text()', query_to_xml(format('SELECT md5(COALESCE(string_agg(t::text, ''|'' ORDER BY t.id), '''')) AS m FROM %I t', c.relname), false, true, '')))[1]::text AS md5
FROM pg_class c
WHERE c.relnamespace = 'baha_lanches'::regnamespace AND c.relkind = 'r'
ORDER BY 1;

\qecho '--- Functions e procedures'
SELECT p.proname AS nome, CASE p.prokind WHEN 'p' THEN 'procedure' ELSE 'function' END AS tipo
FROM pg_proc p
WHERE p.pronamespace = 'baha_lanches'::regnamespace
ORDER BY 1;

\qecho '--- Triggers'
SELECT c.relname AS tabela, t.tgname AS trigger
FROM pg_trigger t
JOIN pg_class c ON c.oid = t.tgrelid
WHERE c.relnamespace = 'baha_lanches'::regnamespace AND NOT t.tgisinternal
ORDER BY 1, 2;

\qecho '--- Índices criados para o sistema'
SELECT tablename AS tabela, indexname AS indice
FROM pg_indexes
WHERE schemaname = 'baha_lanches' AND (indexname LIKE 'idx\_%' OR indexname LIKE 'uq\_%')
ORDER BY 1, 2;

\qecho '--- Objetos em uso'
SELECT COUNT(*) AS pedidos_com_subtotal_divergente FROM pedidos WHERE subtotal <> fn_subtotal_pedido(id);
SELECT fn_taxa_entrega('Centro') AS taxa_centro, fn_taxa_entrega('Vila Jordão') AS taxa_vila_jordao;
