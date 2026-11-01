-- Converte o banco do 1º bimestre (schema "baha_lanches_BD") para o padrão do Laravel.
-- Rodar uma única vez em um banco com a estrutura original. Em banco novo, use as migrations.

BEGIN;

DROP VIEW "baha_lanches_BD".vw_gabriel_clientes_fieis_rfm;
DROP VIEW "baha_lanches_BD".vw_gabriel_desempenho_bairros;
DROP VIEW "baha_lanches_BD".vw_gabriel_faturamento_diario;
DROP VIEW "baha_lanches_BD".vw_gabriel_preferencia_adicionais;
DROP VIEW "baha_lanches_BD".vw_gabriel_produtos_mais_lucrativos;

ALTER SCHEMA "baha_lanches_BD" RENAME TO baha_lanches;
SET LOCAL search_path TO baha_lanches;

-- Chaves primárias: id_x -> id
ALTER TABLE avaliacoes RENAME COLUMN id_avaliacao TO id;
ALTER TABLE categorias RENAME COLUMN id_categoria TO id;
ALTER TABLE clientes RENAME COLUMN id_cliente TO id;
ALTER TABLE cupons RENAME COLUMN id_cupom TO id;
ALTER TABLE enderecos RENAME COLUMN id_endereco TO id;
ALTER TABLE ingredientes RENAME COLUMN id_ingrediente TO id;
ALTER TABLE item_adicionais RENAME COLUMN id_item_adicional TO id;
ALTER TABLE itens_pedido RENAME COLUMN id_item_pedido TO id;
ALTER TABLE pagamentos RENAME COLUMN id_pagamento TO id;
ALTER TABLE pedidos RENAME COLUMN id_pedido TO id;
ALTER TABLE produtos RENAME COLUMN id_produto TO id;

-- Chaves estrangeiras: id_x -> x_id
ALTER TABLE avaliacoes RENAME COLUMN id_pedido TO pedido_id;
ALTER TABLE avaliacoes RENAME COLUMN id_cliente TO cliente_id;
ALTER TABLE enderecos RENAME COLUMN id_cliente TO cliente_id;
ALTER TABLE item_adicionais RENAME COLUMN id_item_pedido TO item_pedido_id;
ALTER TABLE item_adicionais RENAME COLUMN id_ingrediente TO ingrediente_id;
ALTER TABLE itens_pedido RENAME COLUMN id_pedido TO pedido_id;
ALTER TABLE itens_pedido RENAME COLUMN id_produto TO produto_id;
ALTER TABLE pagamentos RENAME COLUMN id_pedido TO pedido_id;
ALTER TABLE pedidos RENAME COLUMN id_cliente TO cliente_id;
ALTER TABLE pedidos RENAME COLUMN id_endereco TO endereco_id;
ALTER TABLE pedidos RENAME COLUMN id_cupom TO cupom_id;
ALTER TABLE produtos RENAME COLUMN id_categoria TO categoria_id;

-- Sequences com o nome que o Laravel geraria
ALTER SEQUENCE avaliacoes_id_avaliacao_seq RENAME TO avaliacoes_id_seq;
ALTER SEQUENCE categorias_id_categoria_seq RENAME TO categorias_id_seq;
ALTER SEQUENCE clientes_id_cliente_seq RENAME TO clientes_id_seq;
ALTER SEQUENCE cupons_id_cupom_seq RENAME TO cupons_id_seq;
ALTER SEQUENCE enderecos_id_endereco_seq RENAME TO enderecos_id_seq;
ALTER SEQUENCE ingredientes_id_ingrediente_seq RENAME TO ingredientes_id_seq;
ALTER SEQUENCE item_adicionais_id_item_adicional_seq RENAME TO item_adicionais_id_seq;
ALTER SEQUENCE itens_pedido_id_item_pedido_seq RENAME TO itens_pedido_id_seq;
ALTER SEQUENCE pagamentos_id_pagamento_seq RENAME TO pagamentos_id_seq;
ALTER SEQUENCE pedidos_id_pedido_seq RENAME TO pedidos_id_seq;
ALTER SEQUENCE produtos_id_produto_seq RENAME TO produtos_id_seq;

-- Constraints com o nome que as migrations geram
ALTER TABLE avaliacoes RENAME CONSTRAINT avaliacoes_id_pedido_key TO avaliacoes_pedido_id_unique;
ALTER TABLE categorias RENAME CONSTRAINT categorias_nome_key TO categorias_nome_unique;
ALTER TABLE clientes RENAME CONSTRAINT clientes_cpf_key TO clientes_cpf_unique;
ALTER TABLE clientes RENAME CONSTRAINT clientes_email_key TO clientes_email_unique;
ALTER TABLE cupons RENAME CONSTRAINT cupons_codigo_key TO cupons_codigo_unique;
ALTER TABLE ingredientes RENAME CONSTRAINT ingredientes_nome_key TO ingredientes_nome_unique;

ALTER TABLE avaliacoes RENAME CONSTRAINT avaliacoes_id_cliente_fkey TO avaliacoes_cliente_id_foreign;
ALTER TABLE avaliacoes RENAME CONSTRAINT avaliacoes_id_pedido_fkey TO avaliacoes_pedido_id_foreign;
ALTER TABLE enderecos RENAME CONSTRAINT enderecos_id_cliente_fkey TO enderecos_cliente_id_foreign;
ALTER TABLE item_adicionais RENAME CONSTRAINT item_adicionais_id_ingrediente_fkey TO item_adicionais_ingrediente_id_foreign;
ALTER TABLE item_adicionais RENAME CONSTRAINT item_adicionais_id_item_pedido_fkey TO item_adicionais_item_pedido_id_foreign;
ALTER TABLE itens_pedido RENAME CONSTRAINT itens_pedido_id_pedido_fkey TO itens_pedido_pedido_id_foreign;
ALTER TABLE itens_pedido RENAME CONSTRAINT itens_pedido_id_produto_fkey TO itens_pedido_produto_id_foreign;
ALTER TABLE pagamentos RENAME CONSTRAINT pagamentos_id_pedido_fkey TO pagamentos_pedido_id_foreign;
ALTER TABLE pedidos RENAME CONSTRAINT pedidos_id_cliente_fkey TO pedidos_cliente_id_foreign;
ALTER TABLE pedidos RENAME CONSTRAINT pedidos_id_cupom_fkey TO pedidos_cupom_id_foreign;
ALTER TABLE pedidos RENAME CONSTRAINT pedidos_id_endereco_fkey TO pedidos_endereco_id_foreign;
ALTER TABLE produtos RENAME CONSTRAINT produtos_id_categoria_fkey TO produtos_categoria_id_foreign;

-- O PostgreSQL 18 nomeia NOT NULL pela coluna original; alinha com os nomes novos
DO $$
DECLARE
    r record;
BEGIN
    FOR r IN
        SELECT c.conrelid::regclass AS tabela, t.relname, c.conname, a.attname
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_attribute a ON a.attrelid = c.conrelid AND a.attnum = c.conkey[1]
        WHERE c.contype = 'n'
          AND c.connamespace = 'baha_lanches'::regnamespace
          AND c.conname <> t.relname || '_' || a.attname || '_not_null'
    LOOP
        EXECUTE format('ALTER TABLE %s RENAME CONSTRAINT %I TO %I', r.tabela, r.conname, r.relname || '_' || r.attname || '_not_null');
    END LOOP;
END $$;

-- Timestamps usados pelo Eloquent, preenchidos com a data real de cada registro quando ela existe
ALTER TABLE avaliacoes ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE categorias ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE clientes ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE cupons ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE enderecos ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE ingredientes ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE item_adicionais ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE itens_pedido ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE pagamentos ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE pedidos ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;
ALTER TABLE produtos ADD COLUMN created_at timestamptz, ADD COLUMN updated_at timestamptz;

UPDATE avaliacoes SET created_at = data_avaliacao, updated_at = data_avaliacao;
UPDATE clientes SET created_at = data_cadastro, updated_at = data_cadastro;
UPDATE pagamentos SET created_at = data_pagamento, updated_at = data_pagamento;
UPDATE pedidos SET created_at = data_pedido, updated_at = data_pedido;
UPDATE itens_pedido i SET created_at = p.data_pedido, updated_at = p.data_pedido FROM pedidos p WHERE p.id = i.pedido_id;
UPDATE item_adicionais a SET created_at = i.created_at, updated_at = i.created_at FROM itens_pedido i WHERE i.id = a.item_pedido_id;
UPDATE categorias SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;
UPDATE cupons SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;
UPDATE enderecos SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;
UPDATE ingredientes SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;
UPDATE produtos SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;

-- Registra as tabelas como já migradas; o próximo "php artisan migrate" cria só os objetos do banco
CREATE TABLE migrations (
    id serial PRIMARY KEY,
    migration varchar(255) NOT NULL,
    batch integer NOT NULL
);

INSERT INTO migrations (migration, batch) VALUES
    ('2026_11_01_000001_create_categorias_table', 1),
    ('2026_11_01_000002_create_clientes_table', 1),
    ('2026_11_01_000003_create_cupons_table', 1),
    ('2026_11_01_000004_create_enderecos_table', 1),
    ('2026_11_01_000005_create_ingredientes_table', 1),
    ('2026_11_01_000006_create_produtos_table', 1),
    ('2026_11_01_000007_create_pedidos_table', 1),
    ('2026_11_01_000008_create_itens_pedido_table', 1),
    ('2026_11_01_000009_create_item_adicionais_table', 1),
    ('2026_11_01_000010_create_pagamentos_table', 1),
    ('2026_11_01_000011_create_avaliacoes_table', 1);

COMMIT;
