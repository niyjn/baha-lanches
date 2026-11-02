-- Índices, functions, procedures e triggers das regras de negócio.
-- Executado pela migration create_objetos_banco; também pode rodar direto no psql.

SET search_path TO baha_lanches;

-- =====================================================================
-- Índices
-- =====================================================================

-- Regra: cada cliente tem no máximo um endereço principal
CREATE UNIQUE INDEX IF NOT EXISTS uq_enderecos_cliente_principal
    ON enderecos (cliente_id)
    WHERE e_principal;

-- Painel da cozinha: só os pedidos em aberto, do mais antigo para o mais novo
CREATE INDEX IF NOT EXISTS idx_pedidos_abertos_data
    ON pedidos (data_pedido)
    WHERE status IN ('RECEBIDO', 'EM_PREPARO', 'PRONTO', 'SAIU_PARA_ENTREGA');

-- =====================================================================
-- Functions
-- =====================================================================

-- Subtotal de um pedido: itens + adicionais
CREATE OR REPLACE FUNCTION fn_subtotal_pedido(p_pedido_id bigint)
RETURNS numeric
LANGUAGE sql
STABLE
SET search_path FROM CURRENT
AS $$
    SELECT COALESCE(SUM(i.subtotal_item), 0)
         + COALESCE((
             SELECT SUM(a.quantidade * a.preco_unitario)
             FROM item_adicionais a
             JOIN itens_pedido ia ON ia.id = a.item_pedido_id
             WHERE ia.pedido_id = p_pedido_id
           ), 0)
    FROM itens_pedido i
    WHERE i.pedido_id = p_pedido_id;
$$;

-- Desconto de um cupom sobre um subtotal. Retorna 0 quando o cupom não se aplica.
-- p_pedido_ignorado evita contar o próprio pedido no limite de usos.
CREATE OR REPLACE FUNCTION fn_calcular_desconto_cupom(
    p_cupom_id bigint,
    p_subtotal numeric,
    p_pedido_ignorado bigint DEFAULT NULL
)
RETURNS numeric
LANGUAGE plpgsql
STABLE
SET search_path FROM CURRENT
AS $$
DECLARE
    v_cupom cupons%ROWTYPE;
    v_usos integer;
    v_desconto numeric;
BEGIN
    SELECT * INTO v_cupom FROM cupons WHERE id = p_cupom_id;

    IF NOT FOUND
       OR NOT v_cupom.ativo
       OR v_cupom.data_validade < CURRENT_TIMESTAMP
       OR p_subtotal < v_cupom.valor_minimo THEN
        RETURN 0;
    END IF;

    SELECT COUNT(*) INTO v_usos
    FROM pedidos
    WHERE cupom_id = p_cupom_id
      AND status <> 'CANCELADO'
      AND id IS DISTINCT FROM p_pedido_ignorado;

    IF v_usos >= v_cupom.limite_usos THEN
        RETURN 0;
    END IF;

    IF v_cupom.tipo_desconto = 'PERCENTUAL' THEN
        v_desconto := round(p_subtotal * v_cupom.valor_desconto / 100, 2);
    ELSE
        v_desconto := v_cupom.valor_desconto;
    END IF;

    RETURN LEAST(v_desconto, p_subtotal);
END;
$$;

-- Taxa de entrega do bairro, conforme o grupo de distância em relação ao restaurante
CREATE OR REPLACE FUNCTION fn_taxa_entrega(p_bairro varchar)
RETURNS numeric
LANGUAGE plpgsql
STABLE
SET search_path FROM CURRENT
AS $$
DECLARE
    v_taxa numeric;
BEGIN
    SELECT g.valor_unitario INTO v_taxa
    FROM bairros_entrega b
    JOIN grupos_entrega g ON g.id = b.grupo_entrega_id
    WHERE b.bairro = p_bairro;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Não há entrega para o bairro %', p_bairro;
    END IF;

    RETURN v_taxa;
END;
$$;

-- =====================================================================
-- Stored procedures
-- =====================================================================

-- Aplica um cupom a um pedido em aberto e atualiza desconto e total
CREATE OR REPLACE PROCEDURE sp_aplicar_cupom(p_pedido_id bigint, p_codigo varchar)
LANGUAGE plpgsql
SET search_path FROM CURRENT
AS $$
DECLARE
    v_pedido pedidos%ROWTYPE;
    v_cupom_id bigint;
    v_desconto numeric;
BEGIN
    SELECT * INTO v_pedido FROM pedidos WHERE id = p_pedido_id FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pedido % não encontrado', p_pedido_id;
    END IF;

    IF v_pedido.status IN ('ENTREGUE', 'CANCELADO') THEN
        RAISE EXCEPTION 'Pedido % já está encerrado (%)', p_pedido_id, v_pedido.status;
    END IF;

    IF v_pedido.cupom_id IS NOT NULL THEN
        RAISE EXCEPTION 'Pedido % já possui cupom', p_pedido_id;
    END IF;

    IF EXISTS (SELECT 1 FROM pagamentos WHERE pedido_id = p_pedido_id) THEN
        RAISE EXCEPTION 'Pedido % já tem pagamento e não aceita cupom', p_pedido_id;
    END IF;

    SELECT id INTO v_cupom_id FROM cupons WHERE codigo = upper(p_codigo);

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cupom % não encontrado', p_codigo;
    END IF;

    v_desconto := fn_calcular_desconto_cupom(v_cupom_id, v_pedido.subtotal, p_pedido_id);

    IF v_desconto = 0 THEN
        RAISE EXCEPTION 'Cupom % não pode ser aplicado a este pedido', p_codigo;
    END IF;

    UPDATE pedidos
    SET cupom_id = v_cupom_id,
        valor_desconto = v_desconto,
        valor_total = subtotal + taxa_entrega - v_desconto,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_pedido_id;
END;
$$;

-- Cancela um pedido em aberto e ajusta os pagamentos: aprovado vira estornado, pendente vira recusado
CREATE OR REPLACE PROCEDURE sp_cancelar_pedido(p_pedido_id bigint)
LANGUAGE plpgsql
SET search_path FROM CURRENT
AS $$
DECLARE
    v_status varchar;
BEGIN
    SELECT status INTO v_status FROM pedidos WHERE id = p_pedido_id FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pedido % não encontrado', p_pedido_id;
    END IF;

    IF v_status IN ('ENTREGUE', 'CANCELADO') THEN
        RAISE EXCEPTION 'Pedido % já está encerrado (%)', p_pedido_id, v_status;
    END IF;

    UPDATE pedidos
    SET status = 'CANCELADO',
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_pedido_id;

    UPDATE pagamentos
    SET status_pagamento = CASE status_pagamento WHEN 'APROVADO' THEN 'ESTORNADO' ELSE 'RECUSADO' END,
        updated_at = CURRENT_TIMESTAMP
    WHERE pedido_id = p_pedido_id
      AND status_pagamento IN ('APROVADO', 'PENDENTE');
END;
$$;

-- =====================================================================
-- Triggers
-- =====================================================================

-- Recalcula subtotal, desconto e total do pedido quando itens ou adicionais mudam.
-- Sem pedido encontrado (exclusão em cascata), não há o que recalcular.
CREATE OR REPLACE FUNCTION fn_trg_recalcular_total_pedido()
RETURNS trigger
LANGUAGE plpgsql
SET search_path FROM CURRENT
AS $$
DECLARE
    v_item_id bigint;
    v_pedido pedidos%ROWTYPE;
    v_pedido_id bigint;
    v_subtotal numeric;
    v_desconto numeric;
BEGIN
    IF TG_TABLE_NAME = 'itens_pedido' THEN
        v_pedido_id := CASE WHEN TG_OP = 'DELETE' THEN OLD.pedido_id ELSE NEW.pedido_id END;
    ELSE
        v_item_id := CASE WHEN TG_OP = 'DELETE' THEN OLD.item_pedido_id ELSE NEW.item_pedido_id END;
        SELECT pedido_id INTO v_pedido_id FROM itens_pedido WHERE id = v_item_id;
    END IF;

    SELECT * INTO v_pedido FROM pedidos WHERE id = v_pedido_id FOR UPDATE;

    IF NOT FOUND THEN
        RETURN NULL;
    END IF;

    IF v_pedido.status IN ('ENTREGUE', 'CANCELADO') THEN
        RAISE EXCEPTION 'Pedido % já está encerrado (%) e não aceita alterações nos itens', v_pedido_id, v_pedido.status;
    END IF;

    IF EXISTS (SELECT 1 FROM pagamentos WHERE pedido_id = v_pedido_id) THEN
        RAISE EXCEPTION 'Pedido % já tem pagamento e não aceita alterações nos itens', v_pedido_id;
    END IF;

    v_subtotal := fn_subtotal_pedido(v_pedido_id);
    v_desconto := v_pedido.valor_desconto;

    IF v_pedido.cupom_id IS NOT NULL THEN
        v_desconto := fn_calcular_desconto_cupom(v_pedido.cupom_id, v_subtotal, v_pedido_id);
    END IF;

    UPDATE pedidos
    SET subtotal = v_subtotal,
        valor_desconto = v_desconto,
        valor_total = v_subtotal + taxa_entrega - v_desconto,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = v_pedido_id;

    RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER trg_itens_recalcular_total
    AFTER INSERT OR UPDATE OR DELETE ON itens_pedido
    FOR EACH ROW
    EXECUTE FUNCTION fn_trg_recalcular_total_pedido();

CREATE OR REPLACE TRIGGER trg_adicionais_recalcular_total
    AFTER INSERT OR UPDATE OR DELETE ON item_adicionais
    FOR EACH ROW
    EXECUTE FUNCTION fn_trg_recalcular_total_pedido();

-- Pedido entregue ou cancelado não muda mais de status
CREATE OR REPLACE FUNCTION fn_trg_validar_status_pedido()
RETURNS trigger
LANGUAGE plpgsql
SET search_path FROM CURRENT
AS $$
BEGIN
    IF OLD.status IN ('ENTREGUE', 'CANCELADO') AND NEW.status <> OLD.status THEN
        RAISE EXCEPTION 'Pedido % já está encerrado (%) e não pode mudar para %', OLD.id, OLD.status, NEW.status;
    END IF;

    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER trg_pedidos_validar_status
    BEFORE UPDATE OF status ON pedidos
    FOR EACH ROW
    EXECUTE FUNCTION fn_trg_validar_status_pedido();
