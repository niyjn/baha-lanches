-- Define as taxas de entrega por bairro de Guarapuava/PR e leva os endereços de São Paulo para a cidade.
-- Rodar uma única vez, depois das migrations, em um banco que já tem os dados antigos.
-- Os pedidos antigos mantêm a taxa e o total com que foram registrados.

BEGIN;

SET LOCAL search_path TO baha_lanches;

INSERT INTO grupos_entrega (nome_grupo, valor_unitario, created_at, updated_at) VALUES
    ('Grupo 1', 6.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Grupo 2', 7.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Grupo 3', 8.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Grupo 4', 9.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO bairros_entrega (bairro, grupo_entrega_id, created_at, updated_at)
SELECT b.bairro, g.id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM (VALUES
    ('Centro', 'Grupo 1'),
    ('Trianon', 'Grupo 1'),
    ('Santa Cruz', 'Grupo 1'),
    ('Batel', 'Grupo 1'),
    ('Alto da XV', 'Grupo 1'),
    ('Dos Estados', 'Grupo 1'),
    ('Santana', 'Grupo 2'),
    ('Vila Carli', 'Grupo 2'),
    ('Bonsucesso', 'Grupo 2'),
    ('Conradinho', 'Grupo 2'),
    ('Cascavel', 'Grupo 2'),
    ('Primavera', 'Grupo 2'),
    ('Morro Alto', 'Grupo 3'),
    ('Vila Bela', 'Grupo 3'),
    ('São Cristóvão', 'Grupo 3'),
    ('Jardim das Américas', 'Grupo 3'),
    ('Alto Cascavel', 'Grupo 3'),
    ('Imóvel Morro Alto', 'Grupo 3'),
    ('Boqueirão', 'Grupo 4'),
    ('Industrial', 'Grupo 4'),
    ('Cidade dos Lagos', 'Grupo 4'),
    ('Vila Jordão', 'Grupo 4')
) AS b (bairro, nome_grupo)
JOIN grupos_entrega g ON g.nome_grupo = b.nome_grupo;

UPDATE enderecos e
SET bairro = m.novo,
    cidade = 'Guarapuava',
    estado = 'PR',
    cep = '85010-000',
    updated_at = CURRENT_TIMESTAMP
FROM (VALUES
    ('Centro', 'Centro'),
    ('Bela Vista', 'Trianon'),
    ('Consolação', 'Santa Cruz'),
    ('Jardins', 'Batel'),
    ('Perdizes', 'Dos Estados'),
    ('Vila Mariana', 'Alto da XV'),
    ('Santana', 'Santana'),
    ('Mooca', 'Vila Carli'),
    ('Pinheiros', 'Bonsucesso'),
    ('Vila Madalena', 'Conradinho'),
    ('Lapa', 'Cascavel'),
    ('Moema', 'Primavera'),
    ('Itaim Bibi', 'Morro Alto'),
    ('Tatuapé', 'Vila Bela'),
    ('Santo Amaro', 'Boqueirão')
) AS m (antigo, novo)
WHERE e.bairro = m.antigo;

COMMIT;
