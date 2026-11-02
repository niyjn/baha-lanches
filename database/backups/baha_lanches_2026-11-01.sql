--
-- PostgreSQL database dump
--


-- Dumped from database version 18.6 (4e5fd08)
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY baha_lanches.produtos DROP CONSTRAINT IF EXISTS produtos_categoria_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.pedidos DROP CONSTRAINT IF EXISTS pedidos_endereco_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.pedidos DROP CONSTRAINT IF EXISTS pedidos_cupom_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.pedidos DROP CONSTRAINT IF EXISTS pedidos_cliente_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.pagamentos DROP CONSTRAINT IF EXISTS pagamentos_pedido_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.itens_pedido DROP CONSTRAINT IF EXISTS itens_pedido_produto_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.itens_pedido DROP CONSTRAINT IF EXISTS itens_pedido_pedido_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.item_adicionais DROP CONSTRAINT IF EXISTS item_adicionais_item_pedido_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.item_adicionais DROP CONSTRAINT IF EXISTS item_adicionais_ingrediente_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.enderecos DROP CONSTRAINT IF EXISTS enderecos_cliente_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.bairros_entrega DROP CONSTRAINT IF EXISTS bairros_entrega_grupo_entrega_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.avaliacoes DROP CONSTRAINT IF EXISTS avaliacoes_pedido_id_foreign;
ALTER TABLE IF EXISTS ONLY baha_lanches.avaliacoes DROP CONSTRAINT IF EXISTS avaliacoes_cliente_id_foreign;
DROP TRIGGER IF EXISTS trg_pedidos_validar_status ON baha_lanches.pedidos;
DROP TRIGGER IF EXISTS trg_itens_recalcular_total ON baha_lanches.itens_pedido;
DROP TRIGGER IF EXISTS trg_adicionais_recalcular_total ON baha_lanches.item_adicionais;
DROP INDEX IF EXISTS baha_lanches.uq_enderecos_cliente_principal;
DROP INDEX IF EXISTS baha_lanches.idx_pedidos_abertos_data;
DROP INDEX IF EXISTS baha_lanches.idx_gabriel_id_pedido_itens_pedido;
DROP INDEX IF EXISTS baha_lanches.idx_gabriel_id_cliente_pedidos;
DROP INDEX IF EXISTS baha_lanches.idx_gabriel_data_pedido_pedidos;
ALTER TABLE IF EXISTS ONLY baha_lanches.produtos DROP CONSTRAINT IF EXISTS produtos_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.pedidos DROP CONSTRAINT IF EXISTS pedidos_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.pagamentos DROP CONSTRAINT IF EXISTS pagamentos_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.pagamentos DROP CONSTRAINT IF EXISTS pagamentos_pedido_id_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.itens_pedido DROP CONSTRAINT IF EXISTS itens_pedido_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.item_adicionais DROP CONSTRAINT IF EXISTS item_adicionais_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.ingredientes DROP CONSTRAINT IF EXISTS ingredientes_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.ingredientes DROP CONSTRAINT IF EXISTS ingredientes_nome_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.grupos_entrega DROP CONSTRAINT IF EXISTS grupos_entrega_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.grupos_entrega DROP CONSTRAINT IF EXISTS grupos_entrega_nome_grupo_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.enderecos DROP CONSTRAINT IF EXISTS enderecos_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.cupons DROP CONSTRAINT IF EXISTS cupons_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.cupons DROP CONSTRAINT IF EXISTS cupons_codigo_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.clientes DROP CONSTRAINT IF EXISTS clientes_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.clientes DROP CONSTRAINT IF EXISTS clientes_email_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.clientes DROP CONSTRAINT IF EXISTS clientes_cpf_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.categorias DROP CONSTRAINT IF EXISTS categorias_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.categorias DROP CONSTRAINT IF EXISTS categorias_nome_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.bairros_entrega DROP CONSTRAINT IF EXISTS bairros_entrega_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.bairros_entrega DROP CONSTRAINT IF EXISTS bairros_entrega_bairro_unique;
ALTER TABLE IF EXISTS ONLY baha_lanches.avaliacoes DROP CONSTRAINT IF EXISTS avaliacoes_pkey;
ALTER TABLE IF EXISTS ONLY baha_lanches.avaliacoes DROP CONSTRAINT IF EXISTS avaliacoes_pedido_id_unique;
ALTER TABLE IF EXISTS baha_lanches.produtos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.pedidos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.pagamentos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.itens_pedido ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.item_adicionais ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.ingredientes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.grupos_entrega ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.enderecos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.cupons ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.clientes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.categorias ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.bairros_entrega ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS baha_lanches.avaliacoes ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS baha_lanches.produtos_id_seq;
DROP TABLE IF EXISTS baha_lanches.produtos;
DROP SEQUENCE IF EXISTS baha_lanches.pedidos_id_seq;
DROP TABLE IF EXISTS baha_lanches.pedidos;
DROP SEQUENCE IF EXISTS baha_lanches.pagamentos_id_seq;
DROP TABLE IF EXISTS baha_lanches.pagamentos;
DROP SEQUENCE IF EXISTS baha_lanches.migrations_id_seq;
DROP TABLE IF EXISTS baha_lanches.migrations;
DROP SEQUENCE IF EXISTS baha_lanches.itens_pedido_id_seq;
DROP TABLE IF EXISTS baha_lanches.itens_pedido;
DROP SEQUENCE IF EXISTS baha_lanches.item_adicionais_id_seq;
DROP TABLE IF EXISTS baha_lanches.item_adicionais;
DROP SEQUENCE IF EXISTS baha_lanches.ingredientes_id_seq;
DROP TABLE IF EXISTS baha_lanches.ingredientes;
DROP SEQUENCE IF EXISTS baha_lanches.grupos_entrega_id_seq;
DROP TABLE IF EXISTS baha_lanches.grupos_entrega;
DROP SEQUENCE IF EXISTS baha_lanches.enderecos_id_seq;
DROP TABLE IF EXISTS baha_lanches.enderecos;
DROP SEQUENCE IF EXISTS baha_lanches.cupons_id_seq;
DROP TABLE IF EXISTS baha_lanches.cupons;
DROP SEQUENCE IF EXISTS baha_lanches.clientes_id_seq;
DROP TABLE IF EXISTS baha_lanches.clientes;
DROP SEQUENCE IF EXISTS baha_lanches.categorias_id_seq;
DROP TABLE IF EXISTS baha_lanches.categorias;
DROP SEQUENCE IF EXISTS baha_lanches.bairros_entrega_id_seq;
DROP TABLE IF EXISTS baha_lanches.bairros_entrega;
DROP SEQUENCE IF EXISTS baha_lanches.avaliacoes_id_seq;
DROP TABLE IF EXISTS baha_lanches.avaliacoes;
DROP PROCEDURE IF EXISTS baha_lanches.sp_cancelar_pedido(IN p_pedido_id bigint);
DROP PROCEDURE IF EXISTS baha_lanches.sp_aplicar_cupom(IN p_pedido_id bigint, IN p_codigo character varying);
DROP FUNCTION IF EXISTS baha_lanches.fn_trg_validar_status_pedido();
DROP FUNCTION IF EXISTS baha_lanches.fn_trg_recalcular_total_pedido();
DROP FUNCTION IF EXISTS baha_lanches.fn_taxa_entrega(p_bairro character varying);
DROP FUNCTION IF EXISTS baha_lanches.fn_subtotal_pedido(p_pedido_id bigint);
DROP FUNCTION IF EXISTS baha_lanches.fn_calcular_desconto_cupom(p_cupom_id bigint, p_subtotal numeric, p_pedido_ignorado bigint);
DROP SCHEMA IF EXISTS baha_lanches;
--
-- Name: baha_lanches; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA baha_lanches;


--
-- Name: fn_calcular_desconto_cupom(bigint, numeric, bigint); Type: FUNCTION; Schema: baha_lanches; Owner: -
--

CREATE FUNCTION baha_lanches.fn_calcular_desconto_cupom(p_cupom_id bigint, p_subtotal numeric, p_pedido_ignorado bigint DEFAULT NULL::bigint) RETURNS numeric
    LANGUAGE plpgsql STABLE
    SET search_path TO 'baha_lanches'
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


--
-- Name: fn_subtotal_pedido(bigint); Type: FUNCTION; Schema: baha_lanches; Owner: -
--

CREATE FUNCTION baha_lanches.fn_subtotal_pedido(p_pedido_id bigint) RETURNS numeric
    LANGUAGE sql STABLE
    SET search_path TO 'baha_lanches'
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


--
-- Name: fn_taxa_entrega(character varying); Type: FUNCTION; Schema: baha_lanches; Owner: -
--

CREATE FUNCTION baha_lanches.fn_taxa_entrega(p_bairro character varying) RETURNS numeric
    LANGUAGE plpgsql STABLE
    SET search_path TO 'baha_lanches'
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


--
-- Name: fn_trg_recalcular_total_pedido(); Type: FUNCTION; Schema: baha_lanches; Owner: -
--

CREATE FUNCTION baha_lanches.fn_trg_recalcular_total_pedido() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'baha_lanches'
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


--
-- Name: fn_trg_validar_status_pedido(); Type: FUNCTION; Schema: baha_lanches; Owner: -
--

CREATE FUNCTION baha_lanches.fn_trg_validar_status_pedido() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'baha_lanches'
    AS $$
BEGIN
    IF OLD.status IN ('ENTREGUE', 'CANCELADO') AND NEW.status <> OLD.status THEN
        RAISE EXCEPTION 'Pedido % já está encerrado (%) e não pode mudar para %', OLD.id, OLD.status, NEW.status;
    END IF;

    RETURN NEW;
END;
$$;


--
-- Name: sp_aplicar_cupom(bigint, character varying); Type: PROCEDURE; Schema: baha_lanches; Owner: -
--

CREATE PROCEDURE baha_lanches.sp_aplicar_cupom(IN p_pedido_id bigint, IN p_codigo character varying)
    LANGUAGE plpgsql
    SET search_path TO 'baha_lanches'
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


--
-- Name: sp_cancelar_pedido(bigint); Type: PROCEDURE; Schema: baha_lanches; Owner: -
--

CREATE PROCEDURE baha_lanches.sp_cancelar_pedido(IN p_pedido_id bigint)
    LANGUAGE plpgsql
    SET search_path TO 'baha_lanches'
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: avaliacoes; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.avaliacoes (
    id bigint NOT NULL,
    pedido_id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    nota integer NOT NULL,
    comentario text,
    data_avaliacao timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT avaliacoes_nota_check CHECK (((nota >= 1) AND (nota <= 5)))
);


--
-- Name: avaliacoes_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: avaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.avaliacoes_id_seq OWNED BY baha_lanches.avaliacoes.id;


--
-- Name: bairros_entrega; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.bairros_entrega (
    id bigint NOT NULL,
    bairro character varying(80) NOT NULL,
    grupo_entrega_id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: bairros_entrega_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.bairros_entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bairros_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.bairros_entrega_id_seq OWNED BY baha_lanches.bairros_entrega.id;


--
-- Name: categorias; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.categorias (
    id bigint NOT NULL,
    nome character varying(60) NOT NULL,
    descricao text,
    ordem_exibicao integer DEFAULT 1 NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.categorias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.categorias_id_seq OWNED BY baha_lanches.categorias.id;


--
-- Name: clientes; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.clientes (
    id bigint NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(120) NOT NULL,
    telefone character varying(20) NOT NULL,
    cpf character varying(14) NOT NULL,
    data_nascimento date,
    data_cadastro timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.clientes_id_seq OWNED BY baha_lanches.clientes.id;


--
-- Name: cupons; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.cupons (
    id bigint NOT NULL,
    codigo character varying(30) NOT NULL,
    tipo_desconto character varying(15) NOT NULL,
    valor_desconto numeric(10,2) NOT NULL,
    valor_minimo numeric(10,2) DEFAULT 0.00 NOT NULL,
    data_validade timestamp with time zone NOT NULL,
    limite_usos integer DEFAULT 100 NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT cupons_tipo_desconto_check CHECK (((tipo_desconto)::text = ANY ((ARRAY['PERCENTUAL'::character varying, 'VALOR_FIXO'::character varying])::text[]))),
    CONSTRAINT cupons_valor_desconto_check CHECK ((valor_desconto > (0)::numeric)),
    CONSTRAINT cupons_valor_minimo_check CHECK ((valor_minimo >= (0)::numeric))
);


--
-- Name: cupons_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.cupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cupons_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.cupons_id_seq OWNED BY baha_lanches.cupons.id;


--
-- Name: enderecos; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.enderecos (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    logradouro character varying(150) NOT NULL,
    numero character varying(20) NOT NULL,
    complemento character varying(100),
    bairro character varying(80) NOT NULL,
    cidade character varying(80) NOT NULL,
    estado character(2) DEFAULT 'PR'::bpchar NOT NULL,
    cep character varying(10) NOT NULL,
    ponto_referencia character varying(150),
    e_principal boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: enderecos_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.enderecos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enderecos_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.enderecos_id_seq OWNED BY baha_lanches.enderecos.id;


--
-- Name: grupos_entrega; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.grupos_entrega (
    id bigint NOT NULL,
    nome_grupo character varying(30) NOT NULL,
    valor_unitario numeric(10,2) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT grupos_entrega_valor_unitario_check CHECK ((valor_unitario >= (0)::numeric))
);


--
-- Name: grupos_entrega_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.grupos_entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grupos_entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.grupos_entrega_id_seq OWNED BY baha_lanches.grupos_entrega.id;


--
-- Name: ingredientes; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.ingredientes (
    id bigint NOT NULL,
    nome character varying(80) NOT NULL,
    preco_adicional numeric(10,2) NOT NULL,
    custo_unitario numeric(10,2) NOT NULL,
    disponivel boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT ingredientes_custo_unitario_check CHECK ((custo_unitario >= (0)::numeric)),
    CONSTRAINT ingredientes_preco_adicional_check CHECK ((preco_adicional >= (0)::numeric))
);


--
-- Name: ingredientes_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.ingredientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredientes_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.ingredientes_id_seq OWNED BY baha_lanches.ingredientes.id;


--
-- Name: item_adicionais; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.item_adicionais (
    id bigint NOT NULL,
    item_pedido_id bigint NOT NULL,
    ingrediente_id bigint NOT NULL,
    quantidade integer DEFAULT 1 NOT NULL,
    preco_unitario numeric(10,2) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT item_adicionais_preco_unitario_check CHECK ((preco_unitario >= (0)::numeric)),
    CONSTRAINT item_adicionais_quantidade_check CHECK ((quantidade > 0))
);


--
-- Name: item_adicionais_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.item_adicionais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: item_adicionais_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.item_adicionais_id_seq OWNED BY baha_lanches.item_adicionais.id;


--
-- Name: itens_pedido; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.itens_pedido (
    id bigint NOT NULL,
    pedido_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    quantidade integer NOT NULL,
    preco_unitario numeric(10,2) NOT NULL,
    subtotal_item numeric(10,2) NOT NULL,
    observacao character varying(200),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT itens_pedido_preco_unitario_check CHECK ((preco_unitario >= (0)::numeric)),
    CONSTRAINT itens_pedido_quantidade_check CHECK ((quantidade > 0)),
    CONSTRAINT itens_pedido_subtotal_item_check CHECK ((subtotal_item >= (0)::numeric))
);


--
-- Name: itens_pedido_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.itens_pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: itens_pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.itens_pedido_id_seq OWNED BY baha_lanches.itens_pedido.id;


--
-- Name: migrations; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.migrations_id_seq OWNED BY baha_lanches.migrations.id;


--
-- Name: pagamentos; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.pagamentos (
    id bigint NOT NULL,
    pedido_id bigint NOT NULL,
    metodo_pagamento character varying(25) NOT NULL,
    status_pagamento character varying(20) NOT NULL,
    valor numeric(10,2) NOT NULL,
    data_pagamento timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT pagamentos_metodo_pagamento_check CHECK (((metodo_pagamento)::text = ANY ((ARRAY['PIX'::character varying, 'CARTAO_CREDITO'::character varying, 'CARTAO_DEBITO'::character varying, 'DINHEIRO'::character varying, 'VALE_REFEICAO'::character varying])::text[]))),
    CONSTRAINT pagamentos_status_pagamento_check CHECK (((status_pagamento)::text = ANY ((ARRAY['PENDENTE'::character varying, 'APROVADO'::character varying, 'RECUSADO'::character varying, 'ESTORNADO'::character varying])::text[]))),
    CONSTRAINT pagamentos_valor_check CHECK ((valor > (0)::numeric))
);


--
-- Name: pagamentos_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.pagamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pagamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.pagamentos_id_seq OWNED BY baha_lanches.pagamentos.id;


--
-- Name: pedidos; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.pedidos (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    endereco_id bigint NOT NULL,
    cupom_id bigint,
    data_pedido timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status character varying(25) NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    taxa_entrega numeric(10,2) DEFAULT 0.00 NOT NULL,
    valor_desconto numeric(10,2) DEFAULT 0.00 NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    observacoes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT pedidos_status_check CHECK (((status)::text = ANY ((ARRAY['RECEBIDO'::character varying, 'EM_PREPARO'::character varying, 'PRONTO'::character varying, 'SAIU_PARA_ENTREGA'::character varying, 'ENTREGUE'::character varying, 'CANCELADO'::character varying])::text[]))),
    CONSTRAINT pedidos_subtotal_check CHECK ((subtotal >= (0)::numeric)),
    CONSTRAINT pedidos_taxa_entrega_check CHECK ((taxa_entrega >= (0)::numeric)),
    CONSTRAINT pedidos_valor_desconto_check CHECK ((valor_desconto >= (0)::numeric)),
    CONSTRAINT pedidos_valor_total_check CHECK ((valor_total >= (0)::numeric))
);


--
-- Name: pedidos_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.pedidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.pedidos_id_seq OWNED BY baha_lanches.pedidos.id;


--
-- Name: produtos; Type: TABLE; Schema: baha_lanches; Owner: -
--

CREATE TABLE baha_lanches.produtos (
    id bigint NOT NULL,
    categoria_id bigint NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text,
    preco numeric(10,2) NOT NULL,
    custo_producao numeric(10,2) NOT NULL,
    disponivel boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT produtos_custo_producao_check CHECK ((custo_producao >= (0)::numeric)),
    CONSTRAINT produtos_preco_check CHECK ((preco >= (0)::numeric))
);


--
-- Name: produtos_id_seq; Type: SEQUENCE; Schema: baha_lanches; Owner: -
--

CREATE SEQUENCE baha_lanches.produtos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: produtos_id_seq; Type: SEQUENCE OWNED BY; Schema: baha_lanches; Owner: -
--

ALTER SEQUENCE baha_lanches.produtos_id_seq OWNED BY baha_lanches.produtos.id;


--
-- Name: avaliacoes id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.avaliacoes ALTER COLUMN id SET DEFAULT nextval('baha_lanches.avaliacoes_id_seq'::regclass);


--
-- Name: bairros_entrega id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.bairros_entrega ALTER COLUMN id SET DEFAULT nextval('baha_lanches.bairros_entrega_id_seq'::regclass);


--
-- Name: categorias id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.categorias ALTER COLUMN id SET DEFAULT nextval('baha_lanches.categorias_id_seq'::regclass);


--
-- Name: clientes id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.clientes ALTER COLUMN id SET DEFAULT nextval('baha_lanches.clientes_id_seq'::regclass);


--
-- Name: cupons id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.cupons ALTER COLUMN id SET DEFAULT nextval('baha_lanches.cupons_id_seq'::regclass);


--
-- Name: enderecos id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.enderecos ALTER COLUMN id SET DEFAULT nextval('baha_lanches.enderecos_id_seq'::regclass);


--
-- Name: grupos_entrega id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.grupos_entrega ALTER COLUMN id SET DEFAULT nextval('baha_lanches.grupos_entrega_id_seq'::regclass);


--
-- Name: ingredientes id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.ingredientes ALTER COLUMN id SET DEFAULT nextval('baha_lanches.ingredientes_id_seq'::regclass);


--
-- Name: item_adicionais id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.item_adicionais ALTER COLUMN id SET DEFAULT nextval('baha_lanches.item_adicionais_id_seq'::regclass);


--
-- Name: itens_pedido id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.itens_pedido ALTER COLUMN id SET DEFAULT nextval('baha_lanches.itens_pedido_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.migrations ALTER COLUMN id SET DEFAULT nextval('baha_lanches.migrations_id_seq'::regclass);


--
-- Name: pagamentos id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pagamentos ALTER COLUMN id SET DEFAULT nextval('baha_lanches.pagamentos_id_seq'::regclass);


--
-- Name: pedidos id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pedidos ALTER COLUMN id SET DEFAULT nextval('baha_lanches.pedidos_id_seq'::regclass);


--
-- Name: produtos id; Type: DEFAULT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.produtos ALTER COLUMN id SET DEFAULT nextval('baha_lanches.produtos_id_seq'::regclass);


--
-- Data for Name: avaliacoes; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.avaliacoes (id, pedido_id, cliente_id, nota, comentario, data_avaliacao, created_at, updated_at) FROM stdin;
1	2	21	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-10 21:39:00+00	2023-12-10 21:39:00+00	2023-12-10 21:39:00+00
2	4	78	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-02-20 21:31:00+00	2024-02-20 21:31:00+00	2024-02-20 21:31:00+00
3	9	74	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-11-21 20:49:00+00	2023-11-21 20:49:00+00	2023-11-21 20:49:00+00
4	10	29	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-13 22:28:00+00	2023-12-13 22:28:00+00	2023-12-13 22:28:00+00
5	11	40	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-10-09 11:56:00+00	2023-10-09 11:56:00+00	2023-10-09 11:56:00+00
6	12	64	1	A embalagem veio amassada e o refrigerante morno.	2023-12-30 14:35:00+00	2023-12-30 14:35:00+00	2023-12-30 14:35:00+00
7	14	49	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-11-24 12:10:00+00	2023-11-24 12:10:00+00	2023-11-24 12:10:00+00
8	15	1	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-19 14:30:00+00	2023-10-19 14:30:00+00	2023-10-19 14:30:00+00
9	16	14	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-01-22 15:05:00+00	2024-01-22 15:05:00+00	2024-01-22 15:05:00+00
10	20	24	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-24 22:50:00+00	2023-11-24 22:50:00+00	2023-11-24 22:50:00+00
11	23	63	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-10-21 12:55:00+00	2023-10-21 12:55:00+00	2023-10-21 12:55:00+00
12	25	3	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-12-26 21:21:00+00	2023-12-26 21:21:00+00	2023-12-26 21:21:00+00
13	26	45	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-10-28 21:55:00+00	2023-10-28 21:55:00+00	2023-10-28 21:55:00+00
14	27	16	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-11-07 01:55:00+00	2023-11-07 01:55:00+00	2023-11-07 01:55:00+00
15	28	21	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-02-14 23:27:00+00	2024-02-14 23:27:00+00	2024-02-14 23:27:00+00
16	30	1	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-11-07 14:30:00+00	2023-11-07 14:30:00+00	2023-11-07 14:30:00+00
17	34	21	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2023-10-26 15:51:00+00	2023-10-26 15:51:00+00	2023-10-26 15:51:00+00
18	35	22	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-12-30 23:30:00+00	2023-12-30 23:30:00+00	2023-12-30 23:30:00+00
19	37	35	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2023-10-07 14:05:00+00	2023-10-07 14:05:00+00	2023-10-07 14:05:00+00
20	39	54	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-28 02:30:00+00	2023-11-28 02:30:00+00	2023-11-28 02:30:00+00
21	45	55	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-10-10 21:19:00+00	2023-10-10 21:19:00+00	2023-10-10 21:19:00+00
22	50	13	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-11-01 22:57:00+00	2023-11-01 22:57:00+00	2023-11-01 22:57:00+00
23	51	35	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-12-03 00:37:00+00	2023-12-03 00:37:00+00	2023-12-03 00:37:00+00
24	55	22	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-11-01 14:36:00+00	2023-11-01 14:36:00+00	2023-11-01 14:36:00+00
25	62	54	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-02-08 16:48:00+00	2024-02-08 16:48:00+00	2024-02-08 16:48:00+00
26	66	71	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-02-27 00:31:00+00	2024-02-27 00:31:00+00	2024-02-27 00:31:00+00
27	68	47	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-12-13 20:55:00+00	2023-12-13 20:55:00+00	2023-12-13 20:55:00+00
28	71	45	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2024-01-14 21:50:00+00	2024-01-14 21:50:00+00	2024-01-14 21:50:00+00
29	76	50	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2024-01-19 00:51:00+00	2024-01-19 00:51:00+00	2024-01-19 00:51:00+00
30	77	39	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-02-16 20:13:00+00	2024-02-16 20:13:00+00	2024-02-16 20:13:00+00
31	78	70	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2024-01-03 14:32:00+00	2024-01-03 14:32:00+00	2024-01-03 14:32:00+00
32	79	48	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-10-25 15:37:00+00	2023-10-25 15:37:00+00	2023-10-25 15:37:00+00
33	80	80	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-11-04 23:18:00+00	2023-11-04 23:18:00+00	2023-11-04 23:18:00+00
34	81	3	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-03-07 22:47:00+00	2024-03-07 22:47:00+00	2024-03-07 22:47:00+00
35	82	5	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-10-20 13:50:00+00	2023-10-20 13:50:00+00	2023-10-20 13:50:00+00
36	85	40	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-10-14 00:09:00+00	2023-10-14 00:09:00+00	2023-10-14 00:09:00+00
87	180	33	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-11-21 23:46:00+00	2023-11-21 23:46:00+00	2023-11-21 23:46:00+00
37	87	73	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-03 00:48:00+00	2023-11-03 00:48:00+00	2023-11-03 00:48:00+00
38	88	11	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2024-02-14 19:53:00+00	2024-02-14 19:53:00+00	2024-02-14 19:53:00+00
39	89	20	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-02-05 15:58:00+00	2024-02-05 15:58:00+00	2024-02-05 15:58:00+00
40	91	71	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-12-21 21:48:00+00	2023-12-21 21:48:00+00	2023-12-21 21:48:00+00
41	93	12	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-11-03 20:06:00+00	2023-11-03 20:06:00+00	2023-11-03 20:06:00+00
42	96	20	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2024-03-07 13:19:00+00	2024-03-07 13:19:00+00	2024-03-07 13:19:00+00
43	97	37	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-12-07 14:38:00+00	2023-12-07 14:38:00+00	2023-12-07 14:38:00+00
44	98	59	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2024-01-04 13:15:00+00	2024-01-04 13:15:00+00	2024-01-04 13:15:00+00
45	101	14	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-03-01 16:28:00+00	2024-03-01 16:28:00+00	2024-03-01 16:28:00+00
46	102	22	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-10-18 22:14:00+00	2023-10-18 22:14:00+00	2023-10-18 22:14:00+00
47	104	25	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2024-02-06 01:30:00+00	2024-02-06 01:30:00+00	2024-02-06 01:30:00+00
48	108	11	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2024-01-07 14:41:00+00	2024-01-07 14:41:00+00	2024-01-07 14:41:00+00
49	109	8	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-26 15:04:00+00	2024-01-26 15:04:00+00	2024-01-26 15:04:00+00
50	110	7	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-12-25 21:03:00+00	2023-12-25 21:03:00+00	2023-12-25 21:03:00+00
51	111	20	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-11-13 15:59:00+00	2023-11-13 15:59:00+00	2023-11-13 15:59:00+00
52	112	69	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2024-01-20 12:22:00+00	2024-01-20 12:22:00+00	2024-01-20 12:22:00+00
53	115	68	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-11-25 15:24:00+00	2023-11-25 15:24:00+00	2023-11-25 15:24:00+00
54	121	23	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-12-10 16:51:00+00	2023-12-10 16:51:00+00	2023-12-10 16:51:00+00
55	125	47	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-28 15:53:00+00	2023-10-28 15:53:00+00	2023-10-28 15:53:00+00
56	126	2	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2023-10-04 00:15:00+00	2023-10-04 00:15:00+00	2023-10-04 00:15:00+00
57	128	23	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-02-02 01:30:00+00	2024-02-02 01:30:00+00	2024-02-02 01:30:00+00
58	134	5	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2024-01-22 23:25:00+00	2024-01-22 23:25:00+00	2024-01-22 23:25:00+00
59	135	1	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-11-02 21:31:00+00	2023-11-02 21:31:00+00	2023-11-02 21:31:00+00
60	136	41	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-12-19 01:15:00+00	2023-12-19 01:15:00+00	2023-12-19 01:15:00+00
61	137	33	2	Veio faltando o bacon adicional que paguei. Experiência frustrante.	2023-10-12 23:43:00+00	2023-10-12 23:43:00+00	2023-10-12 23:43:00+00
62	140	6	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-02-25 22:18:00+00	2024-02-25 22:18:00+00	2024-02-25 22:18:00+00
63	141	21	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-14 12:31:00+00	2023-11-14 12:31:00+00	2023-11-14 12:31:00+00
64	144	40	1	Veio faltando o bacon adicional que paguei. Experiência frustrante.	2023-12-19 22:18:00+00	2023-12-19 22:18:00+00	2023-12-19 22:18:00+00
65	148	6	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-02-23 14:41:00+00	2024-02-23 14:41:00+00	2024-02-23 14:41:00+00
66	150	5	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-11-06 23:49:00+00	2023-11-06 23:49:00+00	2023-11-06 23:49:00+00
67	152	15	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-10-10 02:32:00+00	2023-10-10 02:32:00+00	2023-10-10 02:32:00+00
68	153	2	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-29 16:26:00+00	2024-02-29 16:26:00+00	2024-02-29 16:26:00+00
69	154	5	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-11-30 15:36:00+00	2023-11-30 15:36:00+00	2023-11-30 15:36:00+00
70	155	56	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-26 20:10:00+00	2024-01-26 20:10:00+00	2024-01-26 20:10:00+00
71	156	2	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-02-17 00:47:00+00	2024-02-17 00:47:00+00	2024-02-17 00:47:00+00
72	157	19	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2024-02-03 00:07:00+00	2024-02-03 00:07:00+00	2024-02-03 00:07:00+00
73	158	72	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-01-21 21:13:00+00	2024-01-21 21:13:00+00	2024-01-21 21:13:00+00
74	160	33	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-12-08 14:13:00+00	2023-12-08 14:13:00+00	2023-12-08 14:13:00+00
75	162	47	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-22 22:33:00+00	2024-01-22 22:33:00+00	2024-01-22 22:33:00+00
76	166	11	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-02-13 00:13:00+00	2024-02-13 00:13:00+00	2024-02-13 00:13:00+00
77	167	3	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-11-10 23:19:00+00	2023-11-10 23:19:00+00	2023-11-10 23:19:00+00
78	168	16	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-12 12:17:00+00	2023-10-12 12:17:00+00	2023-10-12 12:17:00+00
79	170	61	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-12-08 16:00:00+00	2023-12-08 16:00:00+00	2023-12-08 16:00:00+00
80	171	35	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-18 21:29:00+00	2023-10-18 21:29:00+00	2023-10-18 21:29:00+00
81	173	10	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-06 13:26:00+00	2024-01-06 13:26:00+00	2024-01-06 13:26:00+00
82	175	28	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2023-10-19 13:43:00+00	2023-10-19 13:43:00+00	2023-10-19 13:43:00+00
83	176	17	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-02-23 21:50:00+00	2024-02-23 21:50:00+00	2024-02-23 21:50:00+00
84	177	77	1	Infelizmente a entrega demorou muito e o lanche chegou quase frio.	2023-11-01 14:58:00+00	2023-11-01 14:58:00+00	2023-11-01 14:58:00+00
85	178	75	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-10-08 19:46:00+00	2023-10-08 19:46:00+00	2023-10-08 19:46:00+00
86	179	42	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-11-20 23:10:00+00	2023-11-20 23:10:00+00	2023-11-20 23:10:00+00
88	182	19	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-12-19 23:40:00+00	2023-12-19 23:40:00+00	2023-12-19 23:40:00+00
89	183	12	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-05 15:35:00+00	2024-02-05 15:35:00+00	2024-02-05 15:35:00+00
90	184	43	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-24 20:30:00+00	2023-11-24 20:30:00+00	2023-11-24 20:30:00+00
91	186	32	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-11-28 13:14:00+00	2023-11-28 13:14:00+00	2023-11-28 13:14:00+00
92	189	14	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-09 00:47:00+00	2024-01-09 00:47:00+00	2024-01-09 00:47:00+00
93	190	60	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-03-01 22:19:00+00	2024-03-01 22:19:00+00	2024-03-01 22:19:00+00
94	192	80	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-12-29 21:54:00+00	2023-12-29 21:54:00+00	2023-12-29 21:54:00+00
95	195	3	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-12-25 13:44:00+00	2023-12-25 13:44:00+00	2023-12-25 13:44:00+00
96	199	4	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2024-01-24 15:11:00+00	2024-01-24 15:11:00+00	2024-01-24 15:11:00+00
97	200	22	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-27 14:37:00+00	2024-02-27 14:37:00+00	2024-02-27 14:37:00+00
98	203	70	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2023-10-29 19:37:00+00	2023-10-29 19:37:00+00	2023-10-29 19:37:00+00
99	204	25	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-22 00:47:00+00	2024-02-22 00:47:00+00	2024-02-22 00:47:00+00
100	207	20	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-10-07 13:24:00+00	2023-10-07 13:24:00+00	2023-10-07 13:24:00+00
101	208	17	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-12-21 14:44:00+00	2023-12-21 14:44:00+00	2023-12-21 14:44:00+00
102	209	12	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-10-16 14:02:00+00	2023-10-16 14:02:00+00	2023-10-16 14:02:00+00
103	210	32	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2023-11-30 22:32:00+00	2023-11-30 22:32:00+00	2023-11-30 22:32:00+00
104	213	26	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-11-04 14:35:00+00	2023-11-04 14:35:00+00	2023-11-04 14:35:00+00
105	215	10	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-11-16 12:29:00+00	2023-11-16 12:29:00+00	2023-11-16 12:29:00+00
106	216	23	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-10-28 01:21:00+00	2023-10-28 01:21:00+00	2023-10-28 01:21:00+00
107	217	56	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-10-19 14:04:00+00	2023-10-19 14:04:00+00	2023-10-19 14:04:00+00
108	219	9	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2024-01-06 19:34:00+00	2024-01-06 19:34:00+00	2024-01-06 19:34:00+00
109	221	7	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-10-05 20:52:00+00	2023-10-05 20:52:00+00	2023-10-05 20:52:00+00
110	222	74	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-11-06 20:21:00+00	2023-11-06 20:21:00+00	2023-11-06 20:21:00+00
111	223	42	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-10-25 16:29:00+00	2023-10-25 16:29:00+00	2023-10-25 16:29:00+00
112	226	12	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-03-06 15:32:00+00	2024-03-06 15:32:00+00	2024-03-06 15:32:00+00
113	228	34	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-05 21:45:00+00	2024-01-05 21:45:00+00	2024-01-05 21:45:00+00
114	229	10	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-12-07 21:09:00+00	2023-12-07 21:09:00+00	2023-12-07 21:09:00+00
115	234	70	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-12-21 23:05:00+00	2023-12-21 23:05:00+00	2023-12-21 23:05:00+00
116	235	5	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-01-30 12:52:00+00	2024-01-30 12:52:00+00	2024-01-30 12:52:00+00
117	236	57	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-11-30 22:25:00+00	2023-11-30 22:25:00+00	2023-11-30 22:25:00+00
118	237	76	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-11-10 00:49:00+00	2023-11-10 00:49:00+00	2023-11-10 00:49:00+00
119	239	66	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-12-07 01:01:00+00	2023-12-07 01:01:00+00	2023-12-07 01:01:00+00
120	241	5	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-22 20:48:00+00	2023-12-22 20:48:00+00	2023-12-22 20:48:00+00
121	242	14	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-03 12:49:00+00	2023-11-03 12:49:00+00	2023-11-03 12:49:00+00
122	243	14	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-12 14:35:00+00	2023-12-12 14:35:00+00	2023-12-12 14:35:00+00
123	244	68	1	Infelizmente a entrega demorou muito e o lanche chegou quase frio.	2024-01-02 14:00:00+00	2024-01-02 14:00:00+00	2024-01-02 14:00:00+00
124	245	10	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-12-21 13:50:00+00	2023-12-21 13:50:00+00	2023-12-21 13:50:00+00
125	246	23	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-14 21:51:00+00	2024-01-14 21:51:00+00	2024-01-14 21:51:00+00
126	248	56	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2024-02-09 00:43:00+00	2024-02-09 00:43:00+00	2024-02-09 00:43:00+00
127	249	65	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-05 23:43:00+00	2023-12-05 23:43:00+00	2023-12-05 23:43:00+00
128	253	20	2	Infelizmente a entrega demorou muito e o lanche chegou quase frio.	2023-11-25 13:07:00+00	2023-11-25 13:07:00+00	2023-11-25 13:07:00+00
129	258	8	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-20 02:17:00+00	2023-12-20 02:17:00+00	2023-12-20 02:17:00+00
130	259	28	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-12-09 23:57:00+00	2023-12-09 23:57:00+00	2023-12-09 23:57:00+00
131	261	22	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-02-19 00:25:00+00	2024-02-19 00:25:00+00	2024-02-19 00:25:00+00
132	263	13	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-17 15:43:00+00	2024-01-17 15:43:00+00	2024-01-17 15:43:00+00
133	264	5	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-02-08 20:58:00+00	2024-02-08 20:58:00+00	2024-02-08 20:58:00+00
134	265	54	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-11-26 19:21:00+00	2023-11-26 19:21:00+00	2023-11-26 19:21:00+00
135	267	43	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-11-14 20:53:00+00	2023-11-14 20:53:00+00	2023-11-14 20:53:00+00
136	271	27	1	A embalagem veio amassada e o refrigerante morno.	2023-12-09 21:41:00+00	2023-12-09 21:41:00+00	2023-12-09 21:41:00+00
137	273	29	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-02-06 13:51:00+00	2024-02-06 13:51:00+00	2024-02-06 13:51:00+00
138	277	56	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-12-20 00:48:00+00	2023-12-20 00:48:00+00	2023-12-20 00:48:00+00
139	278	36	2	Veio faltando o bacon adicional que paguei. Experiência frustrante.	2023-12-12 02:18:00+00	2023-12-12 02:18:00+00	2023-12-12 02:18:00+00
140	281	20	2	A embalagem veio amassada e o refrigerante morno.	2024-02-13 01:46:00+00	2024-02-13 01:46:00+00	2024-02-13 01:46:00+00
141	284	43	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-21 15:24:00+00	2023-10-21 15:24:00+00	2023-10-21 15:24:00+00
142	285	55	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-24 02:09:00+00	2024-02-24 02:09:00+00	2024-02-24 02:09:00+00
143	286	62	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2023-10-27 23:42:00+00	2023-10-27 23:42:00+00	2023-10-27 23:42:00+00
144	288	74	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-11-19 15:11:00+00	2023-11-19 15:11:00+00	2023-11-19 15:11:00+00
145	293	1	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-01-19 14:50:00+00	2024-01-19 14:50:00+00	2024-01-19 14:50:00+00
146	294	11	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-01-28 23:52:00+00	2024-01-28 23:52:00+00	2024-01-28 23:52:00+00
147	298	57	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-03-02 14:19:00+00	2024-03-02 14:19:00+00	2024-03-02 14:19:00+00
148	299	30	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-02-21 14:28:00+00	2024-02-21 14:28:00+00	2024-02-21 14:28:00+00
149	300	31	2	Infelizmente a entrega demorou muito e o lanche chegou quase frio.	2024-03-02 20:21:00+00	2024-03-02 20:21:00+00	2024-03-02 20:21:00+00
150	301	20	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-11-13 13:24:00+00	2023-11-13 13:24:00+00	2023-11-13 13:24:00+00
151	304	5	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-29 23:47:00+00	2023-12-29 23:47:00+00	2023-12-29 23:47:00+00
152	305	71	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-11-01 13:11:00+00	2023-11-01 13:11:00+00	2023-11-01 13:11:00+00
153	308	70	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-02-03 13:31:00+00	2024-02-03 13:31:00+00	2024-02-03 13:31:00+00
154	312	18	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-02-19 11:55:00+00	2024-02-19 11:55:00+00	2024-02-19 11:55:00+00
155	317	51	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-03-07 00:08:00+00	2024-03-07 00:08:00+00	2024-03-07 00:08:00+00
156	319	67	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-03 00:08:00+00	2023-11-03 00:08:00+00	2023-11-03 00:08:00+00
157	320	67	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-06 20:05:00+00	2024-01-06 20:05:00+00	2024-01-06 20:05:00+00
158	321	2	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-10-24 00:12:00+00	2023-10-24 00:12:00+00	2023-10-24 00:12:00+00
159	325	70	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-20 19:24:00+00	2024-02-20 19:24:00+00	2024-02-20 19:24:00+00
160	328	30	2	A embalagem veio amassada e o refrigerante morno.	2024-01-25 20:28:00+00	2024-01-25 20:28:00+00	2024-01-25 20:28:00+00
161	329	51	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-14 23:23:00+00	2023-11-14 23:23:00+00	2023-11-14 23:23:00+00
162	330	5	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-12-20 02:45:00+00	2023-12-20 02:45:00+00	2023-12-20 02:45:00+00
163	333	70	2	A embalagem veio amassada e o refrigerante morno.	2023-12-31 22:07:00+00	2023-12-31 22:07:00+00	2023-12-31 22:07:00+00
164	334	42	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-12-14 12:29:00+00	2023-12-14 12:29:00+00	2023-12-14 12:29:00+00
165	335	14	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2024-02-07 22:48:00+00	2024-02-07 22:48:00+00	2024-02-07 22:48:00+00
166	337	24	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-10-08 20:25:00+00	2023-10-08 20:25:00+00	2023-10-08 20:25:00+00
167	339	21	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-01-18 01:00:00+00	2024-01-18 01:00:00+00	2024-01-18 01:00:00+00
168	340	16	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-01-17 22:05:00+00	2024-01-17 22:05:00+00	2024-01-17 22:05:00+00
169	342	13	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-02-11 21:53:00+00	2024-02-11 21:53:00+00	2024-02-11 21:53:00+00
170	343	6	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-10-05 22:16:00+00	2023-10-05 22:16:00+00	2023-10-05 22:16:00+00
171	346	23	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2024-01-28 20:34:00+00	2024-01-28 20:34:00+00	2024-01-28 20:34:00+00
172	348	27	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-20 01:07:00+00	2024-01-20 01:07:00+00	2024-01-20 01:07:00+00
173	352	14	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-11-06 15:28:00+00	2023-11-06 15:28:00+00	2023-11-06 15:28:00+00
174	354	71	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2024-01-11 00:20:00+00	2024-01-11 00:20:00+00	2024-01-11 00:20:00+00
175	355	11	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-21 20:09:00+00	2023-12-21 20:09:00+00	2023-12-21 20:09:00+00
176	357	33	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-11-28 21:16:00+00	2023-11-28 21:16:00+00	2023-11-28 21:16:00+00
177	360	2	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-11-30 21:09:00+00	2023-11-30 21:09:00+00	2023-11-30 21:09:00+00
178	365	47	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-04 22:29:00+00	2024-01-04 22:29:00+00	2024-01-04 22:29:00+00
179	366	31	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-12-27 20:50:00+00	2023-12-27 20:50:00+00	2023-12-27 20:50:00+00
180	367	5	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-08 15:01:00+00	2024-01-08 15:01:00+00	2024-01-08 15:01:00+00
181	368	4	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-11-18 14:49:00+00	2023-11-18 14:49:00+00	2023-11-18 14:49:00+00
182	369	63	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-10-28 01:02:00+00	2023-10-28 01:02:00+00	2023-10-28 01:02:00+00
183	370	13	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2024-03-07 22:23:00+00	2024-03-07 22:23:00+00	2024-03-07 22:23:00+00
184	371	49	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-11-10 23:30:00+00	2023-11-10 23:30:00+00	2023-11-10 23:30:00+00
185	375	20	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-03-07 22:31:00+00	2024-03-07 22:31:00+00	2024-03-07 22:31:00+00
186	376	13	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-06 01:40:00+00	2023-12-06 01:40:00+00	2023-12-06 01:40:00+00
187	377	32	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-10-04 12:36:00+00	2023-10-04 12:36:00+00	2023-10-04 12:36:00+00
188	378	80	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-05 15:51:00+00	2024-02-05 15:51:00+00	2024-02-05 15:51:00+00
189	379	46	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-12-22 23:38:00+00	2023-12-22 23:38:00+00	2023-12-22 23:38:00+00
190	381	56	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-02-22 20:47:00+00	2024-02-22 20:47:00+00	2024-02-22 20:47:00+00
191	383	78	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-22 22:20:00+00	2024-01-22 22:20:00+00	2024-01-22 22:20:00+00
192	384	15	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-23 23:38:00+00	2023-10-23 23:38:00+00	2023-10-23 23:38:00+00
193	385	1	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-12-05 20:55:00+00	2023-12-05 20:55:00+00	2023-12-05 20:55:00+00
194	387	13	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-12-16 20:50:00+00	2023-12-16 20:50:00+00	2023-12-16 20:50:00+00
195	392	9	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-11-07 23:50:00+00	2023-11-07 23:50:00+00	2023-11-07 23:50:00+00
196	393	49	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-03-04 15:02:00+00	2024-03-04 15:02:00+00	2024-03-04 15:02:00+00
197	395	3	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-01-13 12:52:00+00	2024-01-13 12:52:00+00	2024-01-13 12:52:00+00
198	398	10	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-25 19:45:00+00	2024-01-25 19:45:00+00	2024-01-25 19:45:00+00
199	399	23	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-02-18 00:32:00+00	2024-02-18 00:32:00+00	2024-02-18 00:32:00+00
200	400	15	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-10-10 15:06:00+00	2023-10-10 15:06:00+00	2023-10-10 15:06:00+00
201	402	57	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-10-15 14:28:00+00	2023-10-15 14:28:00+00	2023-10-15 14:28:00+00
202	404	39	2	Infelizmente a entrega demorou muito e o lanche chegou quase frio.	2024-02-14 15:27:00+00	2024-02-14 15:27:00+00	2024-02-14 15:27:00+00
203	405	51	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-12-11 13:45:00+00	2023-12-11 13:45:00+00	2023-12-11 13:45:00+00
204	406	29	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-02-22 00:39:00+00	2024-02-22 00:39:00+00	2024-02-22 00:39:00+00
205	407	49	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-10-13 21:59:00+00	2023-10-13 21:59:00+00	2023-10-13 21:59:00+00
206	409	33	1	Veio faltando o bacon adicional que paguei. Experiência frustrante.	2023-10-11 01:00:00+00	2023-10-11 01:00:00+00	2023-10-11 01:00:00+00
207	410	71	5	Entrega muito rápida, entregador educado e comida deliciosa.	2024-02-11 23:14:00+00	2024-02-11 23:14:00+00	2024-02-11 23:14:00+00
208	411	4	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-10-07 16:09:00+00	2023-10-07 16:09:00+00	2023-10-07 16:09:00+00
209	413	7	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-11-08 22:53:00+00	2023-11-08 22:53:00+00	2023-11-08 22:53:00+00
210	417	44	5	Entrega muito rápida, entregador educado e comida deliciosa.	2023-12-14 19:08:00+00	2023-12-14 19:08:00+00	2023-12-14 19:08:00+00
211	420	78	4	Tudo ótimo, apenas a batata poderia ter chegado um pouquinho mais crocante.	2023-12-19 21:59:00+00	2023-12-19 21:59:00+00	2023-12-19 21:59:00+00
212	421	3	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-11-06 15:11:00+00	2023-11-06 15:11:00+00	2023-11-06 15:11:00+00
213	423	68	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-12-06 00:27:00+00	2023-12-06 00:27:00+00	2023-12-06 00:27:00+00
214	425	78	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-19 23:51:00+00	2023-11-19 23:51:00+00	2023-11-19 23:51:00+00
215	426	22	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-10-28 22:24:00+00	2023-10-28 22:24:00+00	2023-10-28 22:24:00+00
216	432	7	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-11-03 22:34:00+00	2023-11-03 22:34:00+00	2023-11-03 22:34:00+00
217	434	4	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2024-01-03 19:17:00+00	2024-01-03 19:17:00+00	2024-01-03 19:17:00+00
218	435	13	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-11-10 00:37:00+00	2023-11-10 00:37:00+00	2023-11-10 00:37:00+00
219	438	25	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-03-04 19:18:00+00	2024-03-04 19:18:00+00	2024-03-04 19:18:00+00
220	443	66	2	A embalagem veio amassada e o refrigerante morno.	2024-01-21 15:17:00+00	2024-01-21 15:17:00+00	2024-01-21 15:17:00+00
221	444	40	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2023-10-18 21:22:00+00	2023-10-18 21:22:00+00	2023-10-18 21:22:00+00
222	445	24	3	O lanche estava bom, mas o pedido atrasou uns 20 minutos além da previsão.	2024-01-07 00:56:00+00	2024-01-07 00:56:00+00	2024-01-07 00:56:00+00
223	446	23	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-02-25 19:06:00+00	2024-02-25 19:06:00+00	2024-02-25 19:06:00+00
224	447	49	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2023-12-29 22:29:00+00	2023-12-29 22:29:00+00	2023-12-29 22:29:00+00
225	448	1	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-12-04 14:29:00+00	2023-12-04 14:29:00+00	2023-12-04 14:29:00+00
226	449	69	3	Comida saborosa, porém esqueceram de mandar o refrigerante do combo e tiveram que trazer depois.	2023-12-15 19:56:00+00	2023-12-15 19:56:00+00	2023-12-15 19:56:00+00
227	452	24	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-02-01 23:42:00+00	2024-02-01 23:42:00+00	2024-02-01 23:42:00+00
228	453	23	2	Infelizmente a entrega demorou muito e o lanche chegou quase frio.	2024-03-07 13:40:00+00	2024-03-07 13:40:00+00	2024-03-07 13:40:00+00
229	454	15	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2024-03-06 22:59:00+00	2024-03-06 22:59:00+00	2024-03-06 22:59:00+00
230	458	17	2	Infelizmente a entrega demorou muito e o lanche chegou quase frio.	2024-02-26 14:26:00+00	2024-02-26 14:26:00+00	2024-02-26 14:26:00+00
231	459	22	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-12-01 00:24:00+00	2023-12-01 00:24:00+00	2023-12-01 00:24:00+00
232	461	18	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-25 23:50:00+00	2023-10-25 23:50:00+00	2023-10-25 23:50:00+00
233	465	11	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-01-02 22:31:00+00	2024-01-02 22:31:00+00	2024-01-02 22:31:00+00
234	467	55	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-02-17 20:45:00+00	2024-02-17 20:45:00+00	2024-02-17 20:45:00+00
235	468	17	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-01-21 21:15:00+00	2024-01-21 21:15:00+00	2024-01-21 21:15:00+00
236	469	69	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2024-01-01 20:52:00+00	2024-01-01 20:52:00+00	2024-01-01 20:52:00+00
237	471	19	5	Sensacional! O Smash Bacon Lovers é surreal de tão saboroso.	2023-10-30 14:23:00+00	2023-10-30 14:23:00+00	2023-10-30 14:23:00+00
238	472	12	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2024-01-07 02:05:00+00	2024-01-07 02:05:00+00	2024-01-07 02:05:00+00
239	473	12	5	Simplesmente o melhor hambúrguer da região! Chegou super quente e embalagem impecável.	2024-03-06 12:22:00+00	2024-03-06 12:22:00+00	2024-03-06 12:22:00+00
240	476	18	5	Pão super macio, carne suculenta e a maionese verde é divina. Ganharam um cliente fiel.	2023-10-24 21:54:00+00	2023-10-24 21:54:00+00	2023-10-24 21:54:00+00
241	477	36	4	Lanche muito gostoso e bem montado. Chegou dentro do prazo estipulado.	2023-12-14 01:01:00+00	2023-12-14 01:01:00+00	2023-12-14 01:01:00+00
242	478	11	4	Excelente custo-benefício, burger muito bem servido e saboroso.	2024-01-05 00:29:00+00	2024-01-05 00:29:00+00	2024-01-05 00:29:00+00
243	479	1	5	Batata rústica crocante e o blend de costela é inacreditável de bom.	2023-12-11 15:13:00+00	2023-12-11 15:13:00+00	2023-12-11 15:13:00+00
\.


--
-- Data for Name: bairros_entrega; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.bairros_entrega (id, bairro, grupo_entrega_id, created_at, updated_at) FROM stdin;
1	Dos Estados	1	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
2	Alto da XV	1	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
3	Batel	1	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
4	Santa Cruz	1	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
5	Trianon	1	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
6	Centro	1	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
7	Primavera	2	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
8	Cascavel	2	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
9	Conradinho	2	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
10	Bonsucesso	2	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
11	Vila Carli	2	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
12	Santana	2	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
13	Imóvel Morro Alto	3	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
14	Alto Cascavel	3	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
15	Jardim das Américas	3	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
16	São Cristóvão	3	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
17	Vila Bela	3	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
18	Morro Alto	3	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
19	Vila Jordão	4	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
20	Cidade dos Lagos	4	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
21	Industrial	4	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
22	Boqueirão	4	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
\.


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.categorias (id, nome, descricao, ordem_exibicao, ativo, created_at, updated_at) FROM stdin;
1	Smash Burgers	Burgers prensados na chapa ultra quente, com crosta caramelizada irresistível e queijo derretido.	1	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
2	Burgers Artesanais	Blends nobres de 180g grelhados ao ponto certo no pão brioche amanteigado selado.	2	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
3	Combos Especiais	A combinação perfeita com burger + acompanhamento crocante + bebida gelada com desconto.	3	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
4	Porções & Fritas	Batatas crocantes rústicas, tradicionais, onion rings e petiscos artesanais.	4	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
5	Bebidas & Milkshakes	Refrigerantes, cervejas artesanais selecionadas e milkshakes cremosos especiais.	5	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
6	Sobremesas & Molhos	Sobremesas clássicas da hamburgueria e potes extras dos molhos autorais da casa.	6	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
\.


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.clientes (id, nome, email, telefone, cpf, data_nascimento, data_cadastro, ativo, created_at, updated_at) FROM stdin;
1	Gabriel Souza	gabriel.souza1@email.com	(11) 98925-3977	100.012.345-67	2003-10-10	2023-04-27 00:00:00+00	t	2023-04-27 00:00:00+00	2023-04-27 00:00:00+00
2	Lucas Alves	lucas.alves2@email.com	(11) 99963-7718	100.024.691-34	2004-12-25	2023-05-30 00:00:00+00	t	2023-05-30 00:00:00+00	2023-05-30 00:00:00+00
3	Mateus Gomes	mateus.gomes3@email.com	(11) 99183-5016	100.037.037-01	2000-12-16	2023-07-15 00:00:00+00	t	2023-07-15 00:00:00+00	2023-07-15 00:00:00+00
4	Guilherme Martins	guilherme.martins4@email.com	(11) 98703-9639	100.049.382-68	2003-10-07	2023-06-22 00:00:00+00	t	2023-06-22 00:00:00+00	2023-06-22 00:00:00+00
5	Pedro Lopes	pedro.lopes5@email.com	(11) 99227-6410	100.061.728-35	1996-02-24	2024-02-15 00:00:00+00	t	2024-02-15 00:00:00+00	2024-02-15 00:00:00+00
6	Felipe Vieira	felipe.vieira6@email.com	(11) 97845-8676	100.074.074-02	2002-11-05	2023-10-14 00:00:00+00	t	2023-10-14 00:00:00+00	2023-10-14 00:00:00+00
7	Enzo Dias	enzo.dias7@email.com	(11) 97870-7748	100.086.419-69	1981-06-21	2023-08-16 00:00:00+00	t	2023-08-16 00:00:00+00	2023-08-16 00:00:00+00
8	Gustavo Moreira	gustavo.moreira8@email.com	(11) 98908-3034	100.098.765-36	2003-12-05	2024-02-09 00:00:00+00	t	2024-02-09 00:00:00+00	2024-02-09 00:00:00+00
9	Leonardo Machado	leonardo.machado9@email.com	(11) 98339-7394	100.111.111-03	1990-06-26	2023-04-27 00:00:00+00	t	2023-04-27 00:00:00+00	2023-04-27 00:00:00+00
10	Bruno Cardoso	bruno.cardoso10@email.com	(11) 98333-7992	100.123.456-70	1993-06-19	2023-05-04 00:00:00+00	t	2023-05-04 00:00:00+00	2023-05-04 00:00:00+00
11	Thiago Santana	thiago.santana11@email.com	(11) 98666-4753	100.135.802-37	1986-01-24	2023-05-10 00:00:00+00	t	2023-05-10 00:00:00+00	2023-05-10 00:00:00+00
12	Rodrigo Castro	rodrigo.castro12@email.com	(11) 97079-5241	100.148.148-04	1996-06-25	2024-05-20 00:00:00+00	t	2024-05-20 00:00:00+00	2024-05-20 00:00:00+00
13	Rafael Monteiro	rafael.monteiro13@email.com	(11) 99335-7898	100.160.493-71	1999-02-11	2024-03-25 00:00:00+00	t	2024-03-25 00:00:00+00	2024-03-25 00:00:00+00
14	Matheus Oliveira	matheus.oliveira14@email.com	(11) 99673-4778	100.172.839-38	1987-08-12	2023-03-25 00:00:00+00	t	2023-03-25 00:00:00+00	2023-03-25 00:00:00+00
15	Vitor Ferreira	vitor.ferreira15@email.com	(11) 97831-7042	100.185.185-05	1995-10-27	2023-12-02 00:00:00+00	t	2023-12-02 00:00:00+00	2023-12-02 00:00:00+00
16	Alexandre Lima	alexandre.lima16@email.com	(11) 97579-5291	100.197.530-72	1992-10-11	2023-07-05 00:00:00+00	t	2023-07-05 00:00:00+00	2023-07-05 00:00:00+00
17	Caio Ribeiro	caio.ribeiro17@email.com	(11) 99902-8617	100.209.876-39	1985-11-23	2024-02-12 00:00:00+00	t	2024-02-12 00:00:00+00	2024-02-12 00:00:00+00
18	Arthur Almeida	arthur.almeida18@email.com	(11) 97540-6436	100.222.222-06	1986-10-22	2023-02-17 00:00:00+00	t	2023-02-17 00:00:00+00	2023-02-17 00:00:00+00
19	Vinicius Fernandes	vinicius.fernandes19@email.com	(11) 97401-3846	100.234.567-73	1980-03-15	2024-01-10 00:00:00+00	t	2024-01-10 00:00:00+00	2024-01-10 00:00:00+00
20	Daniel Rocha	daniel.rocha20@email.com	(11) 97965-6739	100.246.913-40	1987-02-07	2024-03-01 00:00:00+00	t	2024-03-01 00:00:00+00	2024-03-01 00:00:00+00
21	Mariana Andrade	mariana.andrade21@email.com	(11) 98164-4920	100.259.259-07	2002-08-20	2023-05-29 00:00:00+00	t	2023-05-29 00:00:00+00	2023-05-29 00:00:00+00
22	Beatriz Marques	beatriz.marques22@email.com	(11) 98974-9580	100.271.604-74	1993-11-14	2023-04-27 00:00:00+00	t	2023-04-27 00:00:00+00	2023-04-27 00:00:00+00
23	Larissa Freitas	larissa.freitas23@email.com	(11) 97290-5937	100.283.950-41	1989-05-05	2023-10-31 00:00:00+00	t	2023-10-31 00:00:00+00	2023-10-31 00:00:00+00
24	Camila Goncalves	camila.goncalves24@email.com	(11) 99709-5096	100.296.296-08	1996-02-16	2023-05-06 00:00:00+00	t	2023-05-06 00:00:00+00	2023-05-06 00:00:00+00
25	Fernanda Araujo	fernanda.araujo25@email.com	(11) 97800-7366	100.308.641-75	1985-09-28	2023-05-09 00:00:00+00	t	2023-05-09 00:00:00+00	2023-05-09 00:00:00+00
26	Julia Cavalcanti	julia.cavalcanti26@email.com	(11) 98310-6809	100.320.987-42	2004-12-26	2023-02-07 00:00:00+00	t	2023-02-07 00:00:00+00	2023-02-07 00:00:00+00
27	Amanda Santos	amanda.santos27@email.com	(11) 99371-9915	100.333.333-09	1992-12-24	2024-05-15 00:00:00+00	t	2024-05-15 00:00:00+00	2024-05-15 00:00:00+00
28	Leticia Rodrigues	leticia.rodrigues28@email.com	(11) 99594-2202	100.345.678-76	1983-04-02	2023-10-07 00:00:00+00	t	2023-10-07 00:00:00+00	2023-10-07 00:00:00+00
29	Carolina Pereira	carolina.pereira29@email.com	(11) 97513-4444	100.358.024-43	2000-10-03	2024-05-13 00:00:00+00	t	2024-05-13 00:00:00+00	2024-05-13 00:00:00+00
30	Gabriela Costa	gabriela.costa30@email.com	(11) 99064-3846	100.370.370-10	1987-08-19	2024-02-28 00:00:00+00	t	2024-02-28 00:00:00+00	2024-02-28 00:00:00+00
31	Bruna Carvalho	bruna.carvalho31@email.com	(11) 99997-3704	100.382.715-77	1985-02-05	2023-11-27 00:00:00+00	t	2023-11-27 00:00:00+00	2023-11-27 00:00:00+00
32	Renata Soares	renata.soares32@email.com	(11) 97427-1494	100.395.061-44	1999-02-18	2023-04-17 00:00:00+00	t	2023-04-17 00:00:00+00	2023-04-17 00:00:00+00
33	Juliana Barbosa	juliana.barbosa33@email.com	(11) 99229-6156	100.407.407-11	1980-02-09	2023-01-29 00:00:00+00	t	2023-01-29 00:00:00+00	2023-01-29 00:00:00+00
34	Vanessa Nascimento	vanessa.nascimento34@email.com	(11) 97746-2007	100.419.752-78	1983-11-28	2023-11-30 00:00:00+00	t	2023-11-30 00:00:00+00	2023-11-30 00:00:00+00
35	Patricia Nunes	patricia.nunes35@email.com	(11) 99758-4443	100.432.098-45	1998-04-21	2023-04-22 00:00:00+00	t	2023-04-22 00:00:00+00	2023-04-22 00:00:00+00
36	Aline Mendes	aline.mendes36@email.com	(11) 98888-4050	100.444.444-12	1995-06-09	2024-01-25 00:00:00+00	t	2024-01-25 00:00:00+00	2024-01-25 00:00:00+00
37	Bianca Ramos	bianca.ramos37@email.com	(11) 98859-8194	100.456.789-79	2002-04-13	2023-11-11 00:00:00+00	t	2023-11-11 00:00:00+00	2023-11-11 00:00:00+00
75	Theo Nunes	theo.nunes75@email.com	(11) 97535-6546	100.925.925-25	1993-06-21	2024-01-08 00:00:00+00	t	2024-01-08 00:00:00+00	2024-01-08 00:00:00+00
38	Jessica Teixeira	jessica.teixeira38@email.com	(11) 98838-7855	100.469.135-46	1999-12-05	2024-04-10 00:00:00+00	t	2024-04-10 00:00:00+00	2024-04-10 00:00:00+00
39	Natalia Moura	natalia.moura39@email.com	(11) 97858-3627	100.481.481-13	1989-07-07	2024-02-04 00:00:00+00	t	2024-02-04 00:00:00+00	2024-02-04 00:00:00+00
40	Isabela Silva	isabela.silva40@email.com	(11) 97734-6843	100.493.826-80	1994-11-01	2023-03-17 00:00:00+00	t	2023-03-17 00:00:00+00	2023-03-17 00:00:00+00
41	Andre Souza	andre.souza41@email.com	(11) 98373-1047	100.506.172-47	2004-04-25	2023-10-01 00:00:00+00	t	2023-10-01 00:00:00+00	2023-10-01 00:00:00+00
42	Diego Alves	diego.alves42@email.com	(11) 98717-1615	100.518.518-14	1986-10-15	2023-10-25 00:00:00+00	t	2023-10-25 00:00:00+00	2023-10-25 00:00:00+00
43	Eduardo Gomes	eduardo.gomes43@email.com	(11) 99033-9965	100.530.863-81	1981-07-11	2023-01-20 00:00:00+00	t	2023-01-20 00:00:00+00	2023-01-20 00:00:00+00
44	Danilo Martins	danilo.martins44@email.com	(11) 99088-6570	100.543.209-48	1997-05-22	2024-01-25 00:00:00+00	t	2024-01-25 00:00:00+00	2024-01-25 00:00:00+00
45	Fabio Lopes	fabio.lopes45@email.com	(11) 97645-4688	100.555.555-15	1999-02-27	2024-02-26 00:00:00+00	t	2024-02-26 00:00:00+00	2024-02-26 00:00:00+00
46	Marcelo Vieira	marcelo.vieira46@email.com	(11) 98765-2106	100.567.900-82	1984-03-01	2024-03-30 00:00:00+00	t	2024-03-30 00:00:00+00	2024-03-30 00:00:00+00
47	Ricardo Dias	ricardo.dias47@email.com	(11) 98384-6037	100.580.246-49	1988-08-06	2023-07-19 00:00:00+00	t	2023-07-19 00:00:00+00	2023-07-19 00:00:00+00
48	Leandro Moreira	leandro.moreira48@email.com	(11) 98909-8108	100.592.592-16	1995-10-11	2023-04-06 00:00:00+00	t	2023-04-06 00:00:00+00	2023-04-06 00:00:00+00
49	Henrique Machado	henrique.machado49@email.com	(11) 97152-2992	100.604.937-83	1983-06-14	2023-12-06 00:00:00+00	t	2023-12-06 00:00:00+00	2023-12-06 00:00:00+00
50	Murilo Cardoso	murilo.cardoso50@email.com	(11) 97739-9278	100.617.283-50	2002-02-02	2023-12-18 00:00:00+00	t	2023-12-18 00:00:00+00	2023-12-18 00:00:00+00
51	Carla Santana	carla.santana51@email.com	(11) 98784-1429	100.629.629-17	1988-04-04	2023-06-26 00:00:00+00	t	2023-06-26 00:00:00+00	2023-06-26 00:00:00+00
52	Tatiane Castro	tatiane.castro52@email.com	(11) 99225-3252	100.641.974-84	1986-10-19	2023-03-11 00:00:00+00	t	2023-03-11 00:00:00+00	2023-03-11 00:00:00+00
53	Daniela Monteiro	daniela.monteiro53@email.com	(11) 98766-2682	100.654.320-51	1999-12-23	2023-05-31 00:00:00+00	t	2023-05-31 00:00:00+00	2023-05-31 00:00:00+00
54	Priscila Oliveira	priscila.oliveira54@email.com	(11) 98777-3611	100.666.666-18	2004-04-01	2023-10-05 00:00:00+00	t	2023-10-05 00:00:00+00	2023-10-05 00:00:00+00
55	Debora Ferreira	debora.ferreira55@email.com	(11) 97509-4257	100.679.011-85	1992-09-19	2023-08-11 00:00:00+00	t	2023-08-11 00:00:00+00	2023-08-11 00:00:00+00
56	Renan Lima	renan.lima56@email.com	(11) 98825-3831	100.691.357-52	2000-04-18	2024-04-29 00:00:00+00	t	2024-04-29 00:00:00+00	2024-04-29 00:00:00+00
57	Igor Ribeiro	igor.ribeiro57@email.com	(11) 98195-5528	100.703.703-19	1998-06-15	2023-12-07 00:00:00+00	t	2023-12-07 00:00:00+00	2023-12-07 00:00:00+00
58	Hugo Almeida	hugo.almeida58@email.com	(11) 97456-7626	100.716.048-86	1992-05-11	2023-09-28 00:00:00+00	t	2023-09-28 00:00:00+00	2023-09-28 00:00:00+00
59	Marcio Fernandes	marcio.fernandes59@email.com	(11) 99138-4738	100.728.394-53	1987-06-08	2023-08-18 00:00:00+00	t	2023-08-18 00:00:00+00	2023-08-18 00:00:00+00
60	Flavia Rocha	flavia.rocha60@email.com	(11) 98914-6056	100.740.740-20	1989-11-22	2024-05-01 00:00:00+00	t	2024-05-01 00:00:00+00	2024-05-01 00:00:00+00
61	Alice Andrade	alice.andrade61@email.com	(11) 97794-8673	100.753.085-87	2000-09-02	2023-05-24 00:00:00+00	t	2023-05-24 00:00:00+00	2023-05-24 00:00:00+00
62	Sophia Marques	sophia.marques62@email.com	(11) 98558-4432	100.765.431-54	1988-07-17	2023-03-24 00:00:00+00	t	2023-03-24 00:00:00+00	2023-03-24 00:00:00+00
63	Helena Freitas	helena.freitas63@email.com	(11) 99672-6182	100.777.777-21	1989-12-18	2024-03-02 00:00:00+00	t	2024-03-02 00:00:00+00	2024-03-02 00:00:00+00
64	Valentina Goncalves	valentina.goncalves64@email.com	(11) 97549-2525	100.790.122-88	1996-04-15	2023-11-22 00:00:00+00	t	2023-11-22 00:00:00+00	2023-11-22 00:00:00+00
65	Laura Araujo	laura.araujo65@email.com	(11) 98151-5860	100.802.468-55	1987-11-17	2023-08-02 00:00:00+00	t	2023-08-02 00:00:00+00	2023-08-02 00:00:00+00
66	Manuela Cavalcanti	manuela.cavalcanti66@email.com	(11) 98154-4011	100.814.814-22	1995-06-01	2023-11-16 00:00:00+00	t	2023-11-16 00:00:00+00	2023-11-16 00:00:00+00
67	Isabella Santos	isabella.santos67@email.com	(11) 99640-7145	100.827.159-89	2002-02-25	2024-01-20 00:00:00+00	t	2024-01-20 00:00:00+00	2024-01-20 00:00:00+00
68	Luiza Rodrigues	luiza.rodrigues68@email.com	(11) 97547-2660	100.839.505-56	1993-10-11	2023-04-22 00:00:00+00	t	2023-04-22 00:00:00+00	2023-04-22 00:00:00+00
69	Lorena Pereira	lorena.pereira69@email.com	(11) 97311-5165	100.851.851-23	1981-11-25	2023-05-28 00:00:00+00	t	2023-05-28 00:00:00+00	2023-05-28 00:00:00+00
70	Giovanna Costa	giovanna.costa70@email.com	(11) 99747-9528	100.864.196-90	1986-07-06	2023-04-23 00:00:00+00	t	2023-04-23 00:00:00+00	2023-04-23 00:00:00+00
71	Heitor Carvalho	heitor.carvalho71@email.com	(11) 99924-8737	100.876.542-57	1988-02-15	2023-03-19 00:00:00+00	t	2023-03-19 00:00:00+00	2023-03-19 00:00:00+00
72	Bernardo Soares	bernardo.soares72@email.com	(11) 97410-5389	100.888.888-24	1984-12-13	2024-02-19 00:00:00+00	t	2024-02-19 00:00:00+00	2024-02-19 00:00:00+00
73	Davi Barbosa	davi.barbosa73@email.com	(11) 99413-2603	100.901.233-91	1987-10-08	2023-04-09 00:00:00+00	t	2023-04-09 00:00:00+00	2023-04-09 00:00:00+00
74	Lorenzo Nascimento	lorenzo.nascimento74@email.com	(11) 98210-3256	100.913.579-58	2002-07-22	2023-03-11 00:00:00+00	t	2023-03-11 00:00:00+00	2023-03-11 00:00:00+00
76	Benjamin Mendes	benjamin.mendes76@email.com	(11) 98366-9962	100.938.270-92	2004-04-01	2023-11-19 00:00:00+00	t	2023-11-19 00:00:00+00	2023-11-19 00:00:00+00
77	Samuel Ramos	samuel.ramos77@email.com	(11) 98141-7258	100.950.616-59	1984-10-09	2023-04-12 00:00:00+00	t	2023-04-12 00:00:00+00	2023-04-12 00:00:00+00
78	Joao Teixeira	joao.teixeira78@email.com	(11) 99072-5217	100.962.962-26	1986-09-05	2024-01-09 00:00:00+00	t	2024-01-09 00:00:00+00	2024-01-09 00:00:00+00
79	Nicolas Moura	nicolas.moura79@email.com	(11) 98755-9883	100.975.307-93	1986-03-27	2023-03-22 00:00:00+00	t	2023-03-22 00:00:00+00	2023-03-22 00:00:00+00
80	Bryan Silva	bryan.silva80@email.com	(11) 99765-4805	100.987.653-60	1988-01-21	2023-11-26 00:00:00+00	t	2023-11-26 00:00:00+00	2023-11-26 00:00:00+00
\.


--
-- Data for Name: cupons; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.cupons (id, codigo, tipo_desconto, valor_desconto, valor_minimo, data_validade, limite_usos, ativo, created_at, updated_at) FROM stdin;
1	BAHABEMVINDO	PERCENTUAL	15.00	40.00	2026-12-31 23:59:59+00	500	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
2	BURGER10	PERCENTUAL	10.00	30.00	2026-12-31 23:59:59+00	1000	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
3	SEXTOU15	VALOR_FIXO	15.00	70.00	2026-12-31 23:59:59+00	200	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
4	QUARTASMASH	VALOR_FIXO	10.00	50.00	2026-12-31 23:59:59+00	300	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
5	FRETEGRATIS	VALOR_FIXO	10.00	60.00	2026-12-31 23:59:59+00	500	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
6	VIP20	PERCENTUAL	20.00	100.00	2026-12-31 23:59:59+00	100	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
7	COMBO5	VALOR_FIXO	5.00	45.00	2026-12-31 23:59:59+00	400	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
8	FDSBURGER	PERCENTUAL	12.00	80.00	2026-12-31 23:59:59+00	250	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
9	TOPBURGER	VALOR_FIXO	25.00	120.00	2026-12-31 23:59:59+00	150	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
10	BLACKBURGER	PERCENTUAL	25.00	90.00	2026-12-31 23:59:59+00	100	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
\.


--
-- Data for Name: enderecos; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.enderecos (id, cliente_id, logradouro, numero, complemento, bairro, cidade, estado, cep, ponto_referencia, e_principal, created_at, updated_at) FROM stdin;
2	2	Rua da Consolação	648	Apto 44B	Bonsucesso	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
3	3	Rua Pamplona	1202	Bloco C Apto 102	Vila Bela	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
4	4	Rua Clélia	2272	Conjunto 51	Vila Bela	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
5	5	Rua Clélia	1171	Apto 12	Batel	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
6	6	Rua Vergueiro	2039	Conjunto 51	Batel	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
7	7	Rua da Consolação	1499	Apto 12	Vila Carli	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
8	8	Rua Serra de Bragança	2268	Apto 44B	Vila Carli	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
9	9	Rua Bela Cintra	1921	Apto 44B	Primavera	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
10	10	Rua Fradique Coutinho	481	Bloco C Apto 102	Bonsucesso	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
11	11	Rua Tuiuti	344	Conjunto 51	Trianon	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
12	12	Rua da Consolação	1904	Apto 12	Batel	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
13	13	Avenida Braz Leme	962	Conjunto 51	Vila Carli	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
14	14	Rua Domingos de Morais	1249	Bloco C Apto 102	Batel	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
15	15	Avenida Paulista	874	Conjunto 51	Dos Estados	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
16	16	Rua Voluntários da Pátria	1017	Apto 44B	Vila Bela	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
17	17	Rua Teodoro Sampaio	170	Apto 12	Trianon	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
18	18	Rua Juventus	2219	Apto 44B	Vila Carli	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
19	19	Rua Fradique Coutinho	227	Apto 44B	Centro	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
20	20	Rua Teodoro Sampaio	1300	Apto 12	Dos Estados	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
21	21	Avenida Ibirapuera	1869	Casa 2	Santa Cruz	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
22	22	Rua dos Pinheiros	1989	Conjunto 51	Primavera	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
23	23	Avenida Paulista	1699	Apto 12	Santana	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
24	24	Rua Pamplona	64	Bloco C Apto 102	Primavera	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
25	25	Rua Haddock Lobo	1024	\N	Alto da XV	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
26	26	Rua Cardoso de Almeida	1854	Apto 44B	Cascavel	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
27	27	Avenida Braz Leme	2449	Sala 304	Boqueirão	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
28	28	Rua Voluntários da Pátria	1820	Apto 12	Santana	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
29	29	Rua dos Pinheiros	2092	Conjunto 51	Cascavel	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
30	30	Avenida Rebouças	2044	Bloco C Apto 102	Vila Bela	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
31	31	Avenida Paulista	1848	Sala 304	Santa Cruz	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
32	32	Rua Oscar Freire	1107	Sala 304	Cascavel	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
33	33	Rua Monte Alegre	2203	Sala 304	Centro	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
34	34	Rua Teodoro Sampaio	1992	Casa 2	Conradinho	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
35	35	Avenida Santo Amaro	1133	Conjunto 51	Vila Bela	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
36	36	Rua da Mooca	1546	Casa 2	Boqueirão	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
37	37	Rua dos Pinheiros	85	Apto 12	Santa Cruz	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
38	38	Rua Clélia	1766	Apto 12	Santa Cruz	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
39	39	Rua Augusta	73	Apto 44B	Morro Alto	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
40	40	Rua Teodoro Sampaio	676	Apto 12	Conradinho	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
41	41	Rua Domingos de Morais	1130	Sala 304	Santa Cruz	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
42	42	Rua da Mooca	179	Apto 44B	Primavera	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
43	43	Rua Domingos de Morais	1526	Casa 2	Conradinho	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
44	44	Rua Pamplona	1045	Sala 304	Conradinho	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
45	45	Rua Juventus	2372	Casa 2	Alto da XV	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
46	46	Rua Bela Cintra	1004	Sala 304	Santana	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
47	47	Rua Tuiuti	591	Sala 304	Batel	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
48	48	Rua Mourato Coelho	22	Bloco C Apto 102	Trianon	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
49	49	Rua Bela Cintra	247	Apto 12	Centro	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
50	50	Rua Oscar Freire	2425	Sala 304	Centro	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
51	51	Rua Oscar Freire	361	Apto 12	Vila Bela	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
52	52	Rua Oscar Freire	672	Conjunto 51	Alto da XV	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
53	53	Rua Vergueiro	820	Apto 12	Morro Alto	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
54	54	Rua Haddock Lobo	2389	\N	Cascavel	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
55	55	Rua Domingos de Morais	1582	Casa 2	Alto da XV	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
56	56	Rua da Mooca	597	Apto 12	Cascavel	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
1	1	Rua dos Pinheiros	1745	Casa 2	Batel	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
57	57	Rua Harmonia	645	Bloco C Apto 102	Boqueirão	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
58	58	Rua Serra de Bragança	537	Apto 44B	Boqueirão	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
59	59	Rua Clélia	990	Conjunto 51	Batel	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
60	60	Rua da Mooca	656	Bloco C Apto 102	Santana	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
61	61	Rua Clélia	2352	Conjunto 51	Vila Bela	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
62	62	Alameda Santos	2234	Apto 44B	Boqueirão	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
63	63	Rua Teodoro Sampaio	491	Conjunto 51	Primavera	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
64	64	Rua Pamplona	2031	\N	Conradinho	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
65	65	Rua Fradique Coutinho	2148	Apto 12	Morro Alto	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
66	66	Rua Cardoso de Almeida	2488	Bloco C Apto 102	Conradinho	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
67	67	Rua Tuiuti	2321	Casa 2	Boqueirão	Guarapuava	PR	85010-000	Ao lado do supermercado	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
68	68	Rua Bela Cintra	2004	Apto 44B	Boqueirão	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
69	69	Rua da Mooca	2156	Apto 12	Centro	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
70	70	Rua Cardoso de Almeida	1705	\N	Morro Alto	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
71	71	Rua Serra de Bragança	2115	Apto 44B	Vila Bela	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
72	72	Rua Serra de Bragança	676	Conjunto 51	Trianon	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
73	73	Rua Aspicuelta	909	Casa 2	Trianon	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
74	74	Rua Monte Alegre	1899	Apto 44B	Santana	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
75	75	Rua Voluntários da Pátria	363	Bloco C Apto 102	Santa Cruz	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
76	76	Avenida Ibirapuera	1390	\N	Santa Cruz	Guarapuava	PR	85010-000	Portão preto	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
77	77	Rua Serra de Bragança	1961	Apto 12	Morro Alto	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
78	78	Rua Haddock Lobo	2115	\N	Vila Bela	Guarapuava	PR	85010-000	Próximo à estação do metrô	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
79	79	Rua Monte Alegre	2298	Bloco C Apto 102	Vila Bela	Guarapuava	PR	85010-000	Em frente à praça	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
80	80	Rua Domingos de Morais	1410	Sala 304	Trianon	Guarapuava	PR	85010-000	\N	t	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
81	2	Rua Harmonia	355	Apto Comercial	Primavera	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
82	4	Rua Monte Alegre	2268	Apto Comercial	Vila Carli	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
83	6	Avenida Engenheiro Luis Carlos Berrini	2810	Apto Comercial	Bonsucesso	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
84	8	Avenida Braz Leme	909	Apto Comercial	Vila Bela	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
85	10	Rua Juventus	2652	Apto Comercial	Cascavel	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
86	12	Avenida Faria Lima	656	Apto Comercial	Boqueirão	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
87	14	Alameda Santos	1647	Apto Comercial	Conradinho	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
88	16	Rua Vergueiro	3116	Apto Comercial	Primavera	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
89	18	Rua Teodoro Sampaio	1289	Apto Comercial	Vila Carli	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
90	20	Avenida Santo Amaro	2988	Apto Comercial	Alto da XV	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
91	22	Avenida Braz Leme	2916	Apto Comercial	Centro	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
92	24	Rua da Consolação	777	Apto Comercial	Centro	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
93	26	Rua Aspicuelta	3140	Apto Comercial	Vila Bela	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
94	28	Rua Bela Cintra	338	Apto Comercial	Santana	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
95	30	Rua Serra de Bragança	3116	Apto Comercial	Vila Carli	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
96	32	Avenida Paulista	1711	Apto Comercial	Bonsucesso	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
97	34	Avenida Faria Lima	2825	Apto Comercial	Trianon	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
98	36	Avenida Santo Amaro	201	Apto Comercial	Morro Alto	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
99	38	Rua dos Pinheiros	2442	Apto Comercial	Cascavel	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
100	40	Rua Monte Alegre	863	Apto Comercial	Primavera	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
101	42	Rua Oscar Freire	780	Apto Comercial	Santa Cruz	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
102	44	Rua dos Pinheiros	434	Apto Comercial	Cascavel	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
103	46	Rua Augusta	2984	Apto Comercial	Centro	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
104	48	Rua Mourato Coelho	966	Apto Comercial	Conradinho	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
105	50	Rua da Mooca	2454	Apto Comercial	Cascavel	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
106	52	Rua Domingos de Morais	1900	Apto Comercial	Dos Estados	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
107	54	Rua da Consolação	837	Apto Comercial	Morro Alto	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
108	56	Avenida Ibirapuera	3019	Apto Comercial	Bonsucesso	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
109	58	Rua da Mooca	1459	Apto Comercial	Santa Cruz	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
110	60	Rua Tuiuti	1162	Apto Comercial	Santana	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
111	62	Rua Oscar Freire	3061	Apto Comercial	Bonsucesso	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
112	64	Rua da Mooca	2865	Apto Comercial	Vila Carli	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
113	66	Rua Bela Cintra	1533	Apto Comercial	Alto da XV	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
114	68	Rua Haddock Lobo	2233	Apto Comercial	Centro	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
115	70	Rua Bela Cintra	625	Apto Comercial	Morro Alto	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
116	72	Avenida Ibirapuera	3065	Apto Comercial	Conradinho	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
117	74	Avenida Braz Leme	526	Apto Comercial	Cascavel	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
118	76	Avenida Faria Lima	2773	Apto Comercial	Cascavel	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
119	78	Rua Juventus	932	Apto Comercial	Batel	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
120	80	Rua Pamplona	2178	Apto Comercial	Dos Estados	Guarapuava	PR	85010-000	Prédio comercial	f	2026-11-01 23:30:01.516593+00	2026-11-02 02:14:26.824016+00
\.


--
-- Data for Name: grupos_entrega; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.grupos_entrega (id, nome_grupo, valor_unitario, created_at, updated_at) FROM stdin;
1	Grupo 1	6.00	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
2	Grupo 2	7.00	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
3	Grupo 3	8.00	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
4	Grupo 4	9.00	2026-11-02 02:14:26.824016+00	2026-11-02 02:14:26.824016+00
\.


--
-- Data for Name: ingredientes; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.ingredientes (id, nome, preco_adicional, custo_unitario, disponivel, created_at, updated_at) FROM stdin;
1	Bacon em Fatias Crocante	6.00	2.20	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
2	Queijo Cheddar Inglês Melt	5.00	1.80	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
3	Cebola Caramelizada	4.50	1.20	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
4	Hambúrguer Smash 100g Extra	9.00	3.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
5	Blend Artesanal 180g Extra	14.00	5.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
6	Ovo Frito na Manteiga	4.00	1.10	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
7	Creme de Gorgonzola Especial	6.50	2.40	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
8	Picles Artesanal Crocante	3.50	0.90	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
9	Pimenta Jalapeño Fatiada	4.00	1.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
10	Catupiry Original Gratinado	5.50	2.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
11	Salada (Alface & Tomate)	3.00	0.80	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
12	Maionese Baha Especial Extra	3.50	0.90	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
\.


--
-- Data for Name: item_adicionais; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.item_adicionais (id, item_pedido_id, ingrediente_id, quantidade, preco_unitario, created_at, updated_at) FROM stdin;
1	2	8	1	3.50	2023-12-30 18:08:00+00	2023-12-30 18:08:00+00
2	16	7	1	6.50	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00
4	26	2	1	5.00	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
3	26	8	1	3.50	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
6	31	7	1	6.50	2023-10-19 12:49:00+00	2023-10-19 12:49:00+00
5	31	1	1	6.00	2023-10-19 12:49:00+00	2023-10-19 12:49:00+00
7	32	3	1	4.50	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00
9	33	2	1	5.00	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00
8	33	1	1	6.00	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00
11	38	7	1	6.50	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
10	38	8	1	3.50	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
13	53	5	1	14.00	2024-02-28 20:44:00+00	2024-02-28 20:44:00+00
12	53	11	1	3.00	2024-02-28 20:44:00+00	2024-02-28 20:44:00+00
14	55	9	1	4.00	2023-12-26 19:40:00+00	2023-12-26 19:40:00+00
15	62	4	1	9.00	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00
17	64	11	1	3.00	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
16	64	3	1	4.50	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
18	66	6	1	4.00	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
20	71	4	1	9.00	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00
19	71	9	1	4.00	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00
22	76	7	1	6.50	2023-12-30 20:32:00+00	2023-12-30 20:32:00+00
21	76	2	1	5.00	2023-12-30 20:32:00+00	2023-12-30 20:32:00+00
23	84	5	1	14.00	2024-02-16 18:54:00+00	2024-02-16 18:54:00+00
24	87	3	1	4.50	2024-02-22 23:00:00+00	2024-02-22 23:00:00+00
26	92	6	1	4.00	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
25	92	7	1	6.50	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
27	108	9	1	4.00	2023-11-01 22:13:00+00	2023-11-01 22:13:00+00
29	112	9	1	4.00	2024-01-13 18:35:00+00	2024-01-13 18:35:00+00
28	112	7	1	6.50	2024-01-13 18:35:00+00	2024-01-13 18:35:00+00
30	132	8	1	3.50	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00
32	136	6	1	4.00	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
31	136	5	1	14.00	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
33	140	10	1	5.50	2023-12-05 23:17:00+00	2023-12-05 23:17:00+00
35	143	7	1	6.50	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00
34	143	9	1	4.00	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00
36	150	4	1	9.00	2023-12-24 13:28:00+00	2023-12-24 13:28:00+00
38	167	4	1	9.00	2024-02-16 18:02:00+00	2024-02-16 18:02:00+00
37	167	11	1	3.00	2024-02-16 18:02:00+00	2024-02-16 18:02:00+00
39	172	5	1	14.00	2023-10-25 13:27:00+00	2023-10-25 13:27:00+00
40	182	11	1	3.00	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00
41	184	3	1	4.50	2024-02-06 23:18:00+00	2024-02-06 23:18:00+00
42	193	1	1	6.00	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00
43	197	6	1	4.00	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
45	200	9	1	4.00	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
44	200	3	1	4.50	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
47	203	5	1	14.00	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00
46	203	3	1	4.50	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00
48	206	2	1	5.00	2023-11-03 19:17:00+00	2023-11-03 19:17:00+00
50	220	4	1	9.00	2023-10-05 13:02:00+00	2023-10-05 13:02:00+00
49	220	6	1	4.00	2023-10-05 13:02:00+00	2023-10-05 13:02:00+00
52	222	2	1	5.00	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
51	222	6	1	4.00	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
54	227	6	1	4.00	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00
53	227	5	1	14.00	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00
56	228	1	1	6.00	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
55	228	8	1	3.50	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
58	239	7	1	6.50	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
57	239	2	1	5.00	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
59	242	3	1	4.50	2024-01-07 12:56:00+00	2024-01-07 12:56:00+00
61	260	2	1	5.00	2023-12-25 11:06:00+00	2023-12-25 11:06:00+00
60	260	5	1	14.00	2023-12-25 11:06:00+00	2023-12-25 11:06:00+00
63	278	2	1	5.00	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00
62	278	8	1	3.50	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00
64	286	6	1	4.00	2023-11-01 12:09:00+00	2023-11-01 12:09:00+00
66	291	10	1	5.50	2023-12-09 23:03:00+00	2023-12-09 23:03:00+00
65	291	6	1	4.00	2023-12-09 23:03:00+00	2023-12-09 23:03:00+00
68	295	12	1	3.50	2023-11-02 20:36:00+00	2023-11-02 20:36:00+00
67	295	2	1	5.00	2023-11-02 20:36:00+00	2023-11-02 20:36:00+00
69	299	7	1	6.50	2023-10-12 21:07:00+00	2023-10-12 21:07:00+00
71	307	3	1	4.50	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
70	307	2	1	5.00	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
72	308	10	1	5.50	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
73	325	12	1	3.50	2024-02-23 13:26:00+00	2024-02-23 13:26:00+00
75	342	12	1	3.50	2023-11-30 12:40:00+00	2023-11-30 12:40:00+00
74	342	10	1	5.50	2023-11-30 12:40:00+00	2023-11-30 12:40:00+00
76	348	7	1	6.50	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
77	351	4	1	9.00	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
79	355	9	1	4.00	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
78	355	4	1	9.00	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
81	357	11	1	3.00	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
80	357	12	1	3.50	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
82	369	1	1	6.00	2024-02-02 22:57:00+00	2024-02-02 22:57:00+00
83	370	10	1	5.50	2024-02-12 21:51:00+00	2024-02-12 21:51:00+00
84	376	12	1	3.50	2024-01-22 21:53:00+00	2024-01-22 21:53:00+00
85	378	10	1	5.50	2023-12-08 13:23:00+00	2023-12-08 13:23:00+00
86	384	1	1	6.00	2024-01-06 12:25:00+00	2024-01-06 12:25:00+00
87	387	6	1	4.00	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
89	388	2	1	5.00	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
88	388	12	1	3.50	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
91	390	6	1	4.00	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
90	390	7	1	6.50	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
92	394	7	1	6.50	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
94	395	6	1	4.00	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
93	395	7	1	6.50	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
96	396	1	1	6.00	2023-11-20 21:45:00+00	2023-11-20 21:45:00+00
95	396	5	1	14.00	2023-11-20 21:45:00+00	2023-11-20 21:45:00+00
97	398	5	1	14.00	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
99	400	11	1	3.00	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
98	400	6	1	4.00	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
100	410	2	1	5.00	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00
101	419	11	1	3.00	2023-12-29 19:07:00+00	2023-12-29 19:07:00+00
102	424	2	1	5.00	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00
104	434	6	1	4.00	2024-02-18 13:24:00+00	2024-02-18 13:24:00+00
103	434	7	1	6.50	2024-02-18 13:24:00+00	2024-02-18 13:24:00+00
105	435	9	1	4.00	2024-01-24 13:08:00+00	2024-01-24 13:08:00+00
107	441	4	1	9.00	2023-10-29 18:54:00+00	2023-10-29 18:54:00+00
106	441	2	1	5.00	2023-10-29 18:54:00+00	2023-10-29 18:54:00+00
109	443	1	1	6.00	2024-02-21 22:26:00+00	2024-02-21 22:26:00+00
108	443	2	1	5.00	2024-02-21 22:26:00+00	2024-02-21 22:26:00+00
110	451	2	1	5.00	2023-10-07 12:39:00+00	2023-10-07 12:39:00+00
111	453	10	1	5.50	2023-12-21 13:26:00+00	2023-12-21 13:26:00+00
112	459	12	1	3.50	2023-10-10 18:00:00+00	2023-10-10 18:00:00+00
114	478	11	1	3.00	2023-10-05 18:45:00+00	2023-10-05 18:45:00+00
113	478	9	1	4.00	2023-10-05 18:45:00+00	2023-10-05 18:45:00+00
115	480	12	1	3.50	2023-11-06 19:15:00+00	2023-11-06 19:15:00+00
116	484	8	1	3.50	2023-10-13 13:44:00+00	2023-10-13 13:44:00+00
117	486	5	1	14.00	2023-12-04 18:58:00+00	2023-12-04 18:58:00+00
118	491	8	1	3.50	2024-01-12 12:46:00+00	2024-01-12 12:46:00+00
120	500	7	1	6.50	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
119	500	3	1	4.50	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
121	502	4	1	9.00	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
123	512	6	1	4.00	2024-01-30 11:20:00+00	2024-01-30 11:20:00+00
122	512	4	1	9.00	2024-01-30 11:20:00+00	2024-01-30 11:20:00+00
125	514	4	1	9.00	2023-11-30 21:21:00+00	2023-11-30 21:21:00+00
124	514	3	1	4.50	2023-11-30 21:21:00+00	2023-11-30 21:21:00+00
127	519	4	1	9.00	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
126	519	7	1	6.50	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
129	521	6	1	4.00	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
128	521	3	1	4.50	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
130	530	3	1	4.50	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00
132	544	1	1	6.00	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00
131	544	10	1	5.50	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00
133	547	2	1	5.00	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
135	549	8	1	3.50	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
134	549	5	1	14.00	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
136	554	8	1	3.50	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00
137	556	6	1	4.00	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
139	558	10	1	5.50	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
138	558	12	1	3.50	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
140	563	7	1	6.50	2024-02-27 11:12:00+00	2024-02-27 11:12:00+00
142	569	10	1	5.50	2023-12-19 23:21:00+00	2023-12-19 23:21:00+00
141	569	8	1	3.50	2023-12-19 23:21:00+00	2023-12-19 23:21:00+00
143	577	8	1	3.50	2023-10-25 20:50:00+00	2023-10-25 20:50:00+00
145	582	8	1	3.50	2024-02-08 18:17:00+00	2024-02-08 18:17:00+00
144	582	9	1	4.00	2024-02-08 18:17:00+00	2024-02-08 18:17:00+00
147	597	10	1	5.50	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
146	597	1	1	6.00	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
149	599	9	1	4.00	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
148	599	2	1	5.00	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
151	606	8	1	3.50	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
150	606	1	1	6.00	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
152	607	6	1	4.00	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
153	613	11	1	3.00	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00
154	621	4	1	9.00	2023-10-21 12:50:00+00	2023-10-21 12:50:00+00
155	638	6	1	4.00	2024-02-01 11:46:00+00	2024-02-01 11:46:00+00
157	642	10	1	5.50	2024-02-04 23:26:00+00	2024-02-04 23:26:00+00
156	642	6	1	4.00	2024-02-04 23:26:00+00	2024-02-04 23:26:00+00
158	646	9	1	4.00	2024-01-19 12:06:00+00	2024-01-19 12:06:00+00
160	659	2	1	5.00	2024-02-21 11:30:00+00	2024-02-21 11:30:00+00
159	659	8	1	3.50	2024-02-21 11:30:00+00	2024-02-21 11:30:00+00
162	661	11	1	3.00	2024-03-02 18:21:00+00	2024-03-02 18:21:00+00
161	661	6	1	4.00	2024-03-02 18:21:00+00	2024-03-02 18:21:00+00
164	667	6	1	4.00	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
163	667	1	1	6.00	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
165	673	10	1	5.50	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00
166	676	7	1	6.50	2023-11-01 12:11:00+00	2023-11-01 12:11:00+00
168	678	11	1	3.00	2024-02-23 19:03:00+00	2024-02-23 19:03:00+00
167	678	12	1	3.50	2024-02-23 19:03:00+00	2024-02-23 19:03:00+00
170	680	8	1	3.50	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00
169	680	11	1	3.00	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00
171	699	10	1	5.50	2023-11-14 20:14:00+00	2023-11-14 20:14:00+00
172	701	12	1	3.50	2023-10-30 22:01:00+00	2023-10-30 22:01:00+00
173	702	2	1	5.00	2024-03-06 21:14:00+00	2024-03-06 21:14:00+00
174	720	11	1	3.00	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00
176	732	6	1	4.00	2023-11-14 21:04:00+00	2023-11-14 21:04:00+00
175	732	3	1	4.50	2023-11-14 21:04:00+00	2023-11-14 21:04:00+00
178	737	12	1	3.50	2023-12-31 21:13:00+00	2023-12-31 21:13:00+00
177	737	10	1	5.50	2023-12-31 21:13:00+00	2023-12-31 21:13:00+00
179	753	4	1	9.00	2023-11-12 18:35:00+00	2023-11-12 18:35:00+00
180	762	5	1	14.00	2024-03-02 11:58:00+00	2024-03-02 11:58:00+00
181	778	11	1	3.00	2024-01-10 22:55:00+00	2024-01-10 22:55:00+00
182	786	5	1	14.00	2024-03-02 11:28:00+00	2024-03-02 11:28:00+00
183	795	8	1	3.50	2023-10-02 11:43:00+00	2023-10-02 11:43:00+00
184	797	6	1	4.00	2023-11-06 21:27:00+00	2023-11-06 21:27:00+00
186	802	12	1	3.50	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00
185	802	3	1	4.50	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00
187	820	9	1	4.00	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00
189	824	8	1	3.50	2023-12-18 23:53:00+00	2023-12-18 23:53:00+00
188	824	6	1	4.00	2023-12-18 23:53:00+00	2023-12-18 23:53:00+00
191	829	12	1	3.50	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
190	829	4	1	9.00	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
192	851	7	1	6.50	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
194	852	1	1	6.00	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
193	852	10	1	5.50	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
195	853	7	1	6.50	2023-12-24 19:05:00+00	2023-12-24 19:05:00+00
197	857	10	1	5.50	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
196	857	4	1	9.00	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
199	864	7	1	6.50	2023-11-10 23:21:00+00	2023-11-10 23:21:00+00
198	864	6	1	4.00	2023-11-10 23:21:00+00	2023-11-10 23:21:00+00
200	868	5	1	14.00	2023-12-14 22:41:00+00	2023-12-14 22:41:00+00
202	871	1	1	6.00	2024-01-13 11:08:00+00	2024-01-13 11:08:00+00
201	871	10	1	5.50	2024-01-13 11:08:00+00	2024-01-13 11:08:00+00
203	873	5	1	14.00	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
205	875	1	1	6.00	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
204	875	8	1	3.50	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
207	881	7	1	6.50	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00
206	881	11	1	3.00	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00
208	883	8	1	3.50	2023-10-14 22:57:00+00	2023-10-14 22:57:00+00
210	904	6	1	4.00	2023-12-12 21:19:00+00	2023-12-12 21:19:00+00
209	904	2	1	5.00	2023-12-12 21:19:00+00	2023-12-12 21:19:00+00
212	921	10	1	5.50	2024-01-17 18:09:00+00	2024-01-17 18:09:00+00
211	921	8	1	3.50	2024-01-17 18:09:00+00	2024-01-17 18:09:00+00
214	923	2	1	5.00	2023-12-19 19:56:00+00	2023-12-19 19:56:00+00
213	923	12	1	3.50	2023-12-19 19:56:00+00	2023-12-19 19:56:00+00
215	928	8	1	3.50	2023-11-09 19:19:00+00	2023-11-09 19:19:00+00
216	937	10	1	5.50	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00
217	943	5	1	14.00	2023-12-23 18:29:00+00	2023-12-23 18:29:00+00
218	953	12	1	3.50	2023-11-09 23:11:00+00	2023-11-09 23:11:00+00
220	970	4	1	9.00	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
219	970	8	1	3.50	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
222	971	7	1	6.50	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
221	971	5	1	14.00	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
223	979	10	1	5.50	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00
225	996	6	1	4.00	2024-02-17 22:51:00+00	2024-02-17 22:51:00+00
224	996	4	1	9.00	2024-02-17 22:51:00+00	2024-02-17 22:51:00+00
226	999	12	1	3.50	2023-11-30 23:13:00+00	2023-11-30 23:13:00+00
228	1008	8	1	3.50	2024-02-12 23:43:00+00	2024-02-12 23:43:00+00
227	1008	5	1	14.00	2024-02-12 23:43:00+00	2024-02-12 23:43:00+00
229	1012	10	1	5.50	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00
231	1013	7	1	6.50	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00
230	1013	3	1	4.50	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00
233	1028	3	1	4.50	2024-03-06 11:23:00+00	2024-03-06 11:23:00+00
232	1028	2	1	5.00	2024-03-06 11:23:00+00	2024-03-06 11:23:00+00
235	1036	5	1	14.00	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
234	1036	9	1	4.00	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
236	1039	7	1	6.50	2023-10-24 19:27:00+00	2023-10-24 19:27:00+00
237	1041	3	1	4.50	2023-12-13 22:51:00+00	2023-12-13 22:51:00+00
\.


--
-- Data for Name: itens_pedido; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.itens_pedido (id, pedido_id, produto_id, quantidade, preco_unitario, subtotal_item, observacao, created_at, updated_at) FROM stdin;
1	1	3	1	36.90	36.90	\N	2023-12-30 18:08:00+00	2023-12-30 18:08:00+00
2	1	1	1	24.90	24.90	\N	2023-12-30 18:08:00+00	2023-12-30 18:08:00+00
3	2	26	2	23.90	47.80	\N	2023-12-10 18:47:00+00	2023-12-10 18:47:00+00
4	2	21	2	7.50	15.00	\N	2023-12-10 18:47:00+00	2023-12-10 18:47:00+00
5	3	14	1	18.90	18.90	\N	2023-10-14 23:51:00+00	2023-10-14 23:51:00+00
6	3	13	1	149.90	149.90	\N	2023-10-14 23:51:00+00	2023-10-14 23:51:00+00
7	4	21	1	7.50	7.50	\N	2024-02-20 20:31:00+00	2024-02-20 20:31:00+00
8	5	14	1	18.90	18.90	\N	2023-11-04 19:46:00+00	2023-11-04 19:46:00+00
9	5	20	1	7.50	7.50	\N	2023-11-04 19:46:00+00	2023-11-04 19:46:00+00
10	6	29	1	4.50	4.50	\N	2024-02-07 22:11:00+00	2024-02-07 22:11:00+00
11	6	28	1	24.90	24.90	\N	2024-02-07 22:11:00+00	2024-02-07 22:11:00+00
12	6	1	1	24.90	24.90	\N	2024-02-07 22:11:00+00	2024-02-07 22:11:00+00
13	7	18	1	26.90	26.90	\N	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00
14	7	19	1	28.90	28.90	\N	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00
15	7	14	1	18.90	18.90	\N	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00
16	7	3	1	36.90	36.90	\N	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00
17	8	15	1	22.90	22.90	\N	2024-02-07 11:57:00+00	2024-02-07 11:57:00+00
18	8	13	1	149.90	149.90	\N	2024-02-07 11:57:00+00	2024-02-07 11:57:00+00
19	9	10	1	46.90	46.90	\N	2023-11-21 18:03:00+00	2023-11-21 18:03:00+00
20	9	13	1	149.90	149.90	\N	2023-11-21 18:03:00+00	2023-11-21 18:03:00+00
21	10	15	1	22.90	22.90	\N	2023-12-13 20:55:00+00	2023-12-13 20:55:00+00
22	10	10	1	46.90	46.90	\N	2023-12-13 20:55:00+00	2023-12-13 20:55:00+00
23	11	2	1	32.90	32.90	\N	2023-10-09 11:06:00+00	2023-10-09 11:06:00+00
24	11	14	1	18.90	18.90	\N	2023-10-09 11:06:00+00	2023-10-09 11:06:00+00
25	12	6	2	44.90	89.80	\N	2023-12-30 12:31:00+00	2023-12-30 12:31:00+00
26	13	3	2	36.90	73.80	\N	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
27	13	10	1	46.90	46.90	\N	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
28	13	25	1	5.00	5.00	\N	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
29	13	12	1	62.90	62.90	\N	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
30	14	12	1	62.90	62.90	\N	2023-11-24 11:04:00+00	2023-11-24 11:04:00+00
31	15	2	1	32.90	32.90	\N	2023-10-19 12:49:00+00	2023-10-19 12:49:00+00
32	16	4	1	42.90	42.90	\N	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00
33	16	7	1	41.90	41.90	\N	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00
34	17	29	2	4.50	9.00	\N	2023-11-08 11:51:00+00	2023-11-08 11:51:00+00
35	17	17	1	24.90	24.90	\N	2023-11-08 11:51:00+00	2023-11-08 11:51:00+00
36	18	30	1	4.50	4.50	\N	2023-12-02 13:05:00+00	2023-12-02 13:05:00+00
37	18	17	1	24.90	24.90	\N	2023-12-02 13:05:00+00	2023-12-02 13:05:00+00
38	19	8	1	34.90	34.90	\N	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
39	19	5	2	39.90	79.80	\N	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
40	19	14	2	18.90	37.80	\N	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
41	19	13	1	149.90	149.90	\N	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
42	20	12	1	62.90	62.90	\N	2023-11-24 20:12:00+00	2023-11-24 20:12:00+00
43	20	26	1	23.90	23.90	\N	2023-11-24 20:12:00+00	2023-11-24 20:12:00+00
44	20	24	1	9.90	9.90	\N	2023-11-24 20:12:00+00	2023-11-24 20:12:00+00
45	21	15	1	22.90	22.90	\N	2023-11-20 18:27:00+00	2023-11-20 18:27:00+00
46	21	31	1	4.50	4.50	\N	2023-11-20 18:27:00+00	2023-11-20 18:27:00+00
47	22	10	1	46.90	46.90	\N	2023-12-19 11:37:00+00	2023-12-19 11:37:00+00
48	22	30	1	4.50	4.50	\N	2023-12-19 11:37:00+00	2023-12-19 11:37:00+00
49	22	6	1	44.90	44.90	\N	2023-12-19 11:37:00+00	2023-12-19 11:37:00+00
50	23	11	1	82.90	82.90	\N	2023-10-21 12:05:00+00	2023-10-21 12:05:00+00
51	23	15	2	22.90	45.80	\N	2023-10-21 12:05:00+00	2023-10-21 12:05:00+00
52	24	1	1	24.90	24.90	\N	2024-02-28 20:44:00+00	2024-02-28 20:44:00+00
53	24	4	1	42.90	42.90	\N	2024-02-28 20:44:00+00	2024-02-28 20:44:00+00
54	25	3	1	36.90	36.90	\N	2023-12-26 19:40:00+00	2023-12-26 19:40:00+00
55	25	2	1	32.90	32.90	\N	2023-12-26 19:40:00+00	2023-12-26 19:40:00+00
56	26	19	1	28.90	28.90	\N	2023-10-28 19:17:00+00	2023-10-28 19:17:00+00
57	26	18	1	26.90	26.90	\N	2023-10-28 19:17:00+00	2023-10-28 19:17:00+00
58	27	28	1	24.90	24.90	\N	2023-11-06 23:02:00+00	2023-11-06 23:02:00+00
59	28	20	1	7.50	7.50	\N	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00
60	28	18	1	26.90	26.90	\N	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00
61	28	26	1	23.90	23.90	\N	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00
62	28	4	1	42.90	42.90	\N	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00
63	29	29	1	4.50	4.50	\N	2023-12-08 20:59:00+00	2023-12-08 20:59:00+00
64	30	2	1	32.90	32.90	\N	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
65	30	10	1	46.90	46.90	\N	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
66	30	4	1	42.90	42.90	\N	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
67	30	7	2	41.90	83.80	\N	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
68	31	15	1	22.90	22.90	\N	2023-10-20 12:36:00+00	2023-10-20 12:36:00+00
69	31	14	2	18.90	37.80	\N	2023-10-20 12:36:00+00	2023-10-20 12:36:00+00
70	32	10	1	46.90	46.90	\N	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00
71	32	8	1	34.90	34.90	\N	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00
72	32	11	1	82.90	82.90	\N	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00
73	33	29	1	4.50	4.50	\N	2023-12-26 18:16:00+00	2023-12-26 18:16:00+00
74	34	23	2	16.90	33.80	\N	2023-10-26 13:58:00+00	2023-10-26 13:58:00+00
75	35	18	1	26.90	26.90	\N	2023-12-30 20:32:00+00	2023-12-30 20:32:00+00
76	35	9	1	37.90	37.90	\N	2023-12-30 20:32:00+00	2023-12-30 20:32:00+00
77	36	8	1	34.90	34.90	\N	2024-01-22 11:37:00+00	2024-01-22 11:37:00+00
78	37	28	1	24.90	24.90	\N	2023-10-07 13:23:00+00	2023-10-07 13:23:00+00
79	37	16	1	29.90	29.90	\N	2023-10-07 13:23:00+00	2023-10-07 13:23:00+00
80	38	23	1	16.90	16.90	\N	2023-12-09 21:47:00+00	2023-12-09 21:47:00+00
81	39	13	1	149.90	149.90	\N	2023-11-27 23:55:00+00	2023-11-27 23:55:00+00
82	39	19	1	28.90	28.90	\N	2023-11-27 23:55:00+00	2023-11-27 23:55:00+00
83	39	10	1	46.90	46.90	\N	2023-11-27 23:55:00+00	2023-11-27 23:55:00+00
84	40	6	2	44.90	89.80	\N	2024-02-16 18:54:00+00	2024-02-16 18:54:00+00
85	40	23	1	16.90	16.90	\N	2024-02-16 18:54:00+00	2024-02-16 18:54:00+00
86	41	14	1	18.90	18.90	\N	2024-02-22 23:00:00+00	2024-02-22 23:00:00+00
87	41	3	2	36.90	73.80	\N	2024-02-22 23:00:00+00	2024-02-22 23:00:00+00
88	41	28	2	24.90	49.80	\N	2024-02-22 23:00:00+00	2024-02-22 23:00:00+00
89	42	10	1	46.90	46.90	\N	2023-12-26 11:57:00+00	2023-12-26 11:57:00+00
90	43	22	1	7.00	7.00	\N	2024-03-01 18:45:00+00	2024-03-01 18:45:00+00
91	43	19	1	28.90	28.90	\N	2024-03-01 18:45:00+00	2024-03-01 18:45:00+00
92	44	4	1	42.90	42.90	\N	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
93	44	10	1	46.90	46.90	\N	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
94	44	7	1	41.90	41.90	\N	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
95	44	22	1	7.00	7.00	\N	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
96	45	25	1	5.00	5.00	\N	2023-10-10 19:29:00+00	2023-10-10 19:29:00+00
97	45	17	2	24.90	49.80	\N	2023-10-10 19:29:00+00	2023-10-10 19:29:00+00
98	46	28	1	24.90	24.90	\N	2024-01-19 12:04:00+00	2024-01-19 12:04:00+00
99	46	5	1	39.90	39.90	\N	2024-01-19 12:04:00+00	2024-01-19 12:04:00+00
100	47	16	1	29.90	29.90	\N	2023-10-26 13:55:00+00	2023-10-26 13:55:00+00
101	47	29	1	4.50	4.50	\N	2023-10-26 13:55:00+00	2023-10-26 13:55:00+00
102	47	24	1	9.90	9.90	\N	2023-10-26 13:55:00+00	2023-10-26 13:55:00+00
103	47	4	1	42.90	42.90	\N	2023-10-26 13:55:00+00	2023-10-26 13:55:00+00
104	48	6	1	44.90	44.90	\N	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
105	48	30	1	4.50	4.50	\N	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
106	49	16	1	29.90	29.90	\N	2023-11-08 11:13:00+00	2023-11-08 11:13:00+00
107	50	29	2	4.50	9.00	\N	2023-11-01 22:13:00+00	2023-11-01 22:13:00+00
108	50	1	1	24.90	24.90	\N	2023-11-01 22:13:00+00	2023-11-01 22:13:00+00
109	50	6	1	44.90	44.90	\N	2023-11-01 22:13:00+00	2023-11-01 22:13:00+00
110	51	2	1	32.90	32.90	\N	2023-12-02 23:20:00+00	2023-12-02 23:20:00+00
111	51	23	2	16.90	33.80	\N	2023-12-02 23:20:00+00	2023-12-02 23:20:00+00
112	52	2	2	32.90	65.80	\N	2024-01-13 18:35:00+00	2024-01-13 18:35:00+00
113	53	19	1	28.90	28.90	\N	2023-10-13 12:33:00+00	2023-10-13 12:33:00+00
114	54	9	1	37.90	37.90	\N	2023-10-02 21:25:00+00	2023-10-02 21:25:00+00
115	54	3	1	36.90	36.90	\N	2023-10-02 21:25:00+00	2023-10-02 21:25:00+00
116	55	29	1	4.50	4.50	\N	2023-11-01 12:16:00+00	2023-11-01 12:16:00+00
117	55	17	1	24.90	24.90	\N	2023-11-01 12:16:00+00	2023-11-01 12:16:00+00
118	55	4	1	42.90	42.90	\N	2023-11-01 12:16:00+00	2023-11-01 12:16:00+00
119	56	14	1	18.90	18.90	\N	2023-10-26 23:43:00+00	2023-10-26 23:43:00+00
120	56	9	2	37.90	75.80	\N	2023-10-26 23:43:00+00	2023-10-26 23:43:00+00
121	57	26	2	23.90	47.80	\N	2023-10-28 19:54:00+00	2023-10-28 19:54:00+00
122	57	26	1	23.90	23.90	\N	2023-10-28 19:54:00+00	2023-10-28 19:54:00+00
123	57	20	1	7.50	7.50	\N	2023-10-28 19:54:00+00	2023-10-28 19:54:00+00
124	58	25	1	5.00	5.00	\N	2024-03-07 22:15:00+00	2024-03-07 22:15:00+00
125	59	18	2	26.90	53.80	\N	2024-01-21 18:55:00+00	2024-01-21 18:55:00+00
126	59	21	1	7.50	7.50	\N	2024-01-21 18:55:00+00	2024-01-21 18:55:00+00
127	60	24	1	9.90	9.90	\N	2023-12-21 12:56:00+00	2023-12-21 12:56:00+00
128	61	6	1	44.90	44.90	\N	2023-10-30 22:08:00+00	2023-10-30 22:08:00+00
129	61	13	1	149.90	149.90	\N	2023-10-30 22:08:00+00	2023-10-30 22:08:00+00
130	62	11	1	82.90	82.90	\N	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00
131	62	20	1	7.50	7.50	\N	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00
132	62	5	1	39.90	39.90	\N	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00
133	62	20	1	7.50	7.50	\N	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00
134	63	14	1	18.90	18.90	\N	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
135	63	22	1	7.00	7.00	\N	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
136	63	4	1	42.90	42.90	\N	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
137	63	16	1	29.90	29.90	\N	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
138	64	22	1	7.00	7.00	\N	2023-12-05 23:17:00+00	2023-12-05 23:17:00+00
139	64	19	1	28.90	28.90	\N	2023-12-05 23:17:00+00	2023-12-05 23:17:00+00
140	64	4	1	42.90	42.90	\N	2023-12-05 23:17:00+00	2023-12-05 23:17:00+00
141	65	11	1	82.90	82.90	\N	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00
142	65	3	1	36.90	36.90	\N	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00
143	65	8	1	34.90	34.90	\N	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00
144	66	6	2	44.90	89.80	\N	2024-02-26 22:11:00+00	2024-02-26 22:11:00+00
145	66	26	1	23.90	23.90	\N	2024-02-26 22:11:00+00	2024-02-26 22:11:00+00
146	67	31	1	4.50	4.50	\N	2024-01-03 11:17:00+00	2024-01-03 11:17:00+00
147	68	25	1	5.00	5.00	\N	2023-12-13 18:49:00+00	2023-12-13 18:49:00+00
148	68	11	1	82.90	82.90	\N	2023-12-13 18:49:00+00	2023-12-13 18:49:00+00
149	69	3	2	36.90	73.80	\N	2023-12-24 13:28:00+00	2023-12-24 13:28:00+00
150	69	8	1	34.90	34.90	\N	2023-12-24 13:28:00+00	2023-12-24 13:28:00+00
151	69	7	1	41.90	41.90	\N	2023-12-24 13:28:00+00	2023-12-24 13:28:00+00
152	70	17	1	24.90	24.90	\N	2024-01-22 22:09:00+00	2024-01-22 22:09:00+00
153	70	13	1	149.90	149.90	\N	2024-01-22 22:09:00+00	2024-01-22 22:09:00+00
154	71	30	1	4.50	4.50	\N	2024-01-14 20:20:00+00	2024-01-14 20:20:00+00
155	72	17	1	24.90	24.90	\N	2023-10-21 11:23:00+00	2023-10-21 11:23:00+00
156	72	27	1	21.90	21.90	\N	2023-10-21 11:23:00+00	2023-10-21 11:23:00+00
157	72	25	1	5.00	5.00	\N	2023-10-21 11:23:00+00	2023-10-21 11:23:00+00
158	73	20	1	7.50	7.50	\N	2024-01-15 12:53:00+00	2024-01-15 12:53:00+00
159	74	23	1	16.90	16.90	\N	2024-01-08 13:43:00+00	2024-01-08 13:43:00+00
160	74	4	1	42.90	42.90	\N	2024-01-08 13:43:00+00	2024-01-08 13:43:00+00
161	74	25	1	5.00	5.00	\N	2024-01-08 13:43:00+00	2024-01-08 13:43:00+00
162	74	1	2	24.90	49.80	\N	2024-01-08 13:43:00+00	2024-01-08 13:43:00+00
163	75	12	1	62.90	62.90	\N	2023-10-05 13:33:00+00	2023-10-05 13:33:00+00
164	75	8	1	34.90	34.90	\N	2023-10-05 13:33:00+00	2023-10-05 13:33:00+00
165	76	3	2	36.90	73.80	\N	2024-01-18 23:58:00+00	2024-01-18 23:58:00+00
166	76	15	1	22.90	22.90	\N	2024-01-18 23:58:00+00	2024-01-18 23:58:00+00
167	77	6	1	44.90	44.90	\N	2024-02-16 18:02:00+00	2024-02-16 18:02:00+00
168	77	20	1	7.50	7.50	\N	2024-02-16 18:02:00+00	2024-02-16 18:02:00+00
169	78	13	1	149.90	149.90	\N	2024-01-03 12:51:00+00	2024-01-03 12:51:00+00
170	78	26	1	23.90	23.90	\N	2024-01-03 12:51:00+00	2024-01-03 12:51:00+00
171	79	14	1	18.90	18.90	\N	2023-10-25 13:27:00+00	2023-10-25 13:27:00+00
172	79	9	1	37.90	37.90	\N	2023-10-25 13:27:00+00	2023-10-25 13:27:00+00
173	80	28	1	24.90	24.90	\N	2023-11-04 21:39:00+00	2023-11-04 21:39:00+00
174	80	26	2	23.90	47.80	\N	2023-11-04 21:39:00+00	2023-11-04 21:39:00+00
175	81	18	1	26.90	26.90	\N	2024-03-07 21:43:00+00	2024-03-07 21:43:00+00
176	81	18	1	26.90	26.90	\N	2024-03-07 21:43:00+00	2024-03-07 21:43:00+00
177	81	25	1	5.00	5.00	\N	2024-03-07 21:43:00+00	2024-03-07 21:43:00+00
178	82	27	2	21.90	43.80	\N	2023-10-20 12:56:00+00	2023-10-20 12:56:00+00
179	82	14	1	18.90	18.90	\N	2023-10-20 12:56:00+00	2023-10-20 12:56:00+00
180	83	5	1	39.90	39.90	\N	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00
181	83	14	2	18.90	37.80	\N	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00
182	83	9	2	37.90	75.80	\N	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00
183	83	28	1	24.90	24.90	\N	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00
184	84	8	2	34.90	69.80	\N	2024-02-06 23:18:00+00	2024-02-06 23:18:00+00
185	84	7	1	41.90	41.90	\N	2024-02-06 23:18:00+00	2024-02-06 23:18:00+00
186	84	8	1	34.90	34.90	\N	2024-02-06 23:18:00+00	2024-02-06 23:18:00+00
187	85	10	1	46.90	46.90	\N	2023-10-13 21:52:00+00	2023-10-13 21:52:00+00
188	85	13	1	149.90	149.90	\N	2023-10-13 21:52:00+00	2023-10-13 21:52:00+00
189	86	2	1	32.90	32.90	\N	2024-02-15 23:38:00+00	2024-02-15 23:38:00+00
190	87	21	1	7.50	7.50	\N	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00
191	87	11	1	82.90	82.90	\N	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00
192	87	18	2	26.90	53.80	\N	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00
193	87	8	1	34.90	34.90	\N	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00
194	88	26	1	23.90	23.90	\N	2024-02-14 18:10:00+00	2024-02-14 18:10:00+00
195	88	2	1	32.90	32.90	\N	2024-02-14 18:10:00+00	2024-02-14 18:10:00+00
196	89	11	1	82.90	82.90	\N	2024-02-05 13:34:00+00	2024-02-05 13:34:00+00
197	90	9	1	37.90	37.90	\N	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
198	90	17	2	24.90	49.80	\N	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
199	90	19	1	28.90	28.90	\N	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
200	90	1	1	24.90	24.90	\N	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
201	91	15	1	22.90	22.90	\N	2023-12-21 19:38:00+00	2023-12-21 19:38:00+00
202	91	13	1	149.90	149.90	\N	2023-12-21 19:38:00+00	2023-12-21 19:38:00+00
203	92	3	1	36.90	36.90	\N	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00
204	92	12	1	62.90	62.90	\N	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00
205	92	11	1	82.90	82.90	\N	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00
206	93	7	2	41.90	83.80	\N	2023-11-03 19:17:00+00	2023-11-03 19:17:00+00
207	93	18	1	26.90	26.90	\N	2023-11-03 19:17:00+00	2023-11-03 19:17:00+00
208	93	29	1	4.50	4.50	\N	2023-11-03 19:17:00+00	2023-11-03 19:17:00+00
209	94	25	1	5.00	5.00	\N	2024-02-17 12:34:00+00	2024-02-17 12:34:00+00
210	94	17	1	24.90	24.90	\N	2024-02-17 12:34:00+00	2024-02-17 12:34:00+00
211	94	25	1	5.00	5.00	\N	2024-02-17 12:34:00+00	2024-02-17 12:34:00+00
212	95	11	1	82.90	82.90	\N	2023-11-08 22:08:00+00	2023-11-08 22:08:00+00
213	96	6	1	44.90	44.90	\N	2024-03-07 11:10:00+00	2024-03-07 11:10:00+00
214	96	30	2	4.50	9.00	\N	2024-03-07 11:10:00+00	2024-03-07 11:10:00+00
215	97	26	1	23.90	23.90	\N	2023-12-07 13:26:00+00	2023-12-07 13:26:00+00
216	97	5	1	39.90	39.90	\N	2023-12-07 13:26:00+00	2023-12-07 13:26:00+00
217	98	26	1	23.90	23.90	\N	2024-01-04 11:37:00+00	2024-01-04 11:37:00+00
218	98	28	1	24.90	24.90	\N	2024-01-04 11:37:00+00	2024-01-04 11:37:00+00
219	99	24	2	9.90	19.80	\N	2023-10-05 13:02:00+00	2023-10-05 13:02:00+00
220	99	6	2	44.90	89.80	\N	2023-10-05 13:02:00+00	2023-10-05 13:02:00+00
221	100	30	1	4.50	4.50	\N	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
222	100	3	1	36.90	36.90	\N	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
223	100	3	1	36.90	36.90	\N	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
224	100	13	1	149.90	149.90	\N	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
225	101	16	1	29.90	29.90	\N	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00
226	101	30	2	4.50	9.00	\N	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00
227	101	9	1	37.90	37.90	\N	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00
228	102	5	1	39.90	39.90	\N	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
229	102	8	1	34.90	34.90	\N	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
230	102	9	1	37.90	37.90	\N	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
231	102	15	1	22.90	22.90	\N	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
232	103	26	1	23.90	23.90	\N	2024-02-13 13:30:00+00	2024-02-13 13:30:00+00
233	104	31	1	4.50	4.50	\N	2024-02-05 23:57:00+00	2024-02-05 23:57:00+00
234	105	11	1	82.90	82.90	\N	2023-10-03 19:26:00+00	2023-10-03 19:26:00+00
235	105	18	2	26.90	53.80	\N	2023-10-03 19:26:00+00	2023-10-03 19:26:00+00
236	106	23	2	16.90	33.80	\N	2024-01-09 22:00:00+00	2024-01-09 22:00:00+00
237	106	25	1	5.00	5.00	\N	2024-01-09 22:00:00+00	2024-01-09 22:00:00+00
238	107	21	1	7.50	7.50	\N	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
239	107	7	1	41.90	41.90	\N	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
240	107	6	2	44.90	89.80	\N	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
241	107	30	1	4.50	4.50	\N	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
242	108	6	1	44.90	44.90	\N	2024-01-07 12:56:00+00	2024-01-07 12:56:00+00
243	108	13	1	149.90	149.90	\N	2024-01-07 12:56:00+00	2024-01-07 12:56:00+00
244	108	17	1	24.90	24.90	\N	2024-01-07 12:56:00+00	2024-01-07 12:56:00+00
245	109	6	2	44.90	89.80	\N	2024-01-26 12:04:00+00	2024-01-26 12:04:00+00
246	109	15	1	22.90	22.90	\N	2024-01-26 12:04:00+00	2024-01-26 12:04:00+00
247	110	7	1	41.90	41.90	\N	2023-12-25 20:18:00+00	2023-12-25 20:18:00+00
248	110	8	1	34.90	34.90	\N	2023-12-25 20:18:00+00	2023-12-25 20:18:00+00
249	111	25	1	5.00	5.00	\N	2023-11-13 13:16:00+00	2023-11-13 13:16:00+00
250	111	28	1	24.90	24.90	\N	2023-11-13 13:16:00+00	2023-11-13 13:16:00+00
251	111	23	1	16.90	16.90	\N	2023-11-13 13:16:00+00	2023-11-13 13:16:00+00
252	111	8	2	34.90	69.80	\N	2023-11-13 13:16:00+00	2023-11-13 13:16:00+00
253	112	12	1	62.90	62.90	\N	2024-01-20 11:05:00+00	2024-01-20 11:05:00+00
254	112	20	1	7.50	7.50	\N	2024-01-20 11:05:00+00	2024-01-20 11:05:00+00
255	113	28	1	24.90	24.90	\N	2024-01-01 13:35:00+00	2024-01-01 13:35:00+00
256	113	16	1	29.90	29.90	\N	2024-01-01 13:35:00+00	2024-01-01 13:35:00+00
257	113	17	1	24.90	24.90	\N	2024-01-01 13:35:00+00	2024-01-01 13:35:00+00
258	113	19	1	28.90	28.90	\N	2024-01-01 13:35:00+00	2024-01-01 13:35:00+00
259	114	19	1	28.90	28.90	\N	2023-12-25 11:06:00+00	2023-12-25 11:06:00+00
260	114	8	1	34.90	34.90	\N	2023-12-25 11:06:00+00	2023-12-25 11:06:00+00
261	115	16	1	29.90	29.90	\N	2023-11-25 12:44:00+00	2023-11-25 12:44:00+00
262	116	1	1	24.90	24.90	\N	2024-01-24 18:51:00+00	2024-01-24 18:51:00+00
263	117	23	1	16.90	16.90	\N	2023-10-11 20:11:00+00	2023-10-11 20:11:00+00
264	117	16	1	29.90	29.90	\N	2023-10-11 20:11:00+00	2023-10-11 20:11:00+00
265	117	5	1	39.90	39.90	\N	2023-10-11 20:11:00+00	2023-10-11 20:11:00+00
266	118	14	1	18.90	18.90	\N	2023-11-11 21:35:00+00	2023-11-11 21:35:00+00
267	119	19	1	28.90	28.90	\N	2023-11-11 20:52:00+00	2023-11-11 20:52:00+00
268	120	20	1	7.50	7.50	\N	2023-12-10 22:18:00+00	2023-12-10 22:18:00+00
269	120	26	1	23.90	23.90	\N	2023-12-10 22:18:00+00	2023-12-10 22:18:00+00
270	121	25	1	5.00	5.00	\N	2023-12-10 13:55:00+00	2023-12-10 13:55:00+00
271	121	21	2	7.50	15.00	\N	2023-12-10 13:55:00+00	2023-12-10 13:55:00+00
272	122	10	1	46.90	46.90	\N	2024-02-07 22:00:00+00	2024-02-07 22:00:00+00
273	123	7	1	41.90	41.90	\N	2024-03-04 12:56:00+00	2024-03-04 12:56:00+00
274	124	17	1	24.90	24.90	\N	2024-01-29 21:56:00+00	2024-01-29 21:56:00+00
275	124	17	1	24.90	24.90	\N	2024-01-29 21:56:00+00	2024-01-29 21:56:00+00
276	124	31	1	4.50	4.50	\N	2024-01-29 21:56:00+00	2024-01-29 21:56:00+00
277	125	23	1	16.90	16.90	\N	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00
278	125	9	1	37.90	37.90	\N	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00
279	125	13	1	149.90	149.90	\N	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00
280	126	19	1	28.90	28.90	\N	2023-10-03 22:55:00+00	2023-10-03 22:55:00+00
281	127	21	1	7.50	7.50	\N	2023-10-02 13:24:00+00	2023-10-02 13:24:00+00
282	127	23	1	16.90	16.90	\N	2023-10-02 13:24:00+00	2023-10-02 13:24:00+00
283	127	6	1	44.90	44.90	\N	2023-10-02 13:24:00+00	2023-10-02 13:24:00+00
284	128	20	1	7.50	7.50	\N	2024-02-01 22:49:00+00	2024-02-01 22:49:00+00
285	129	15	1	22.90	22.90	\N	2023-10-21 11:37:00+00	2023-10-21 11:37:00+00
286	130	5	1	39.90	39.90	\N	2023-11-01 12:09:00+00	2023-11-01 12:09:00+00
287	131	29	2	4.50	9.00	\N	2023-10-15 23:37:00+00	2023-10-15 23:37:00+00
288	131	24	1	9.90	9.90	\N	2023-10-15 23:37:00+00	2023-10-15 23:37:00+00
289	131	1	1	24.90	24.90	\N	2023-10-15 23:37:00+00	2023-10-15 23:37:00+00
290	132	17	1	24.90	24.90	\N	2023-10-04 11:21:00+00	2023-10-04 11:21:00+00
291	133	7	1	41.90	41.90	\N	2023-12-09 23:03:00+00	2023-12-09 23:03:00+00
292	133	9	1	37.90	37.90	\N	2023-12-09 23:03:00+00	2023-12-09 23:03:00+00
293	134	25	1	5.00	5.00	\N	2024-01-22 22:44:00+00	2024-01-22 22:44:00+00
294	135	18	2	26.90	53.80	\N	2023-11-02 20:36:00+00	2023-11-02 20:36:00+00
295	135	8	1	34.90	34.90	\N	2023-11-02 20:36:00+00	2023-11-02 20:36:00+00
296	136	14	1	18.90	18.90	\N	2023-12-18 22:25:00+00	2023-12-18 22:25:00+00
297	136	9	1	37.90	37.90	\N	2023-12-18 22:25:00+00	2023-12-18 22:25:00+00
298	137	22	2	7.00	14.00	\N	2023-10-12 21:07:00+00	2023-10-12 21:07:00+00
299	137	8	1	34.90	34.90	\N	2023-10-12 21:07:00+00	2023-10-12 21:07:00+00
300	138	15	1	22.90	22.90	\N	2023-12-23 19:40:00+00	2023-12-23 19:40:00+00
301	138	29	1	4.50	4.50	\N	2023-12-23 19:40:00+00	2023-12-23 19:40:00+00
302	138	8	1	34.90	34.90	\N	2023-12-23 19:40:00+00	2023-12-23 19:40:00+00
303	139	17	2	24.90	49.80	\N	2023-10-06 22:03:00+00	2023-10-06 22:03:00+00
304	139	14	1	18.90	18.90	\N	2023-10-06 22:03:00+00	2023-10-06 22:03:00+00
305	140	31	1	4.50	4.50	\N	2024-02-25 21:01:00+00	2024-02-25 21:01:00+00
306	140	29	1	4.50	4.50	\N	2024-02-25 21:01:00+00	2024-02-25 21:01:00+00
307	141	9	1	37.90	37.90	\N	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
308	141	9	1	37.90	37.90	\N	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
309	141	30	1	4.50	4.50	\N	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
310	141	9	2	37.90	75.80	\N	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
311	142	13	1	149.90	149.90	\N	2024-02-19 11:25:00+00	2024-02-19 11:25:00+00
312	142	26	1	23.90	23.90	\N	2024-02-19 11:25:00+00	2024-02-19 11:25:00+00
313	143	12	1	62.90	62.90	\N	2023-11-12 12:31:00+00	2023-11-12 12:31:00+00
314	143	1	1	24.90	24.90	\N	2023-11-12 12:31:00+00	2023-11-12 12:31:00+00
315	143	4	1	42.90	42.90	\N	2023-11-12 12:31:00+00	2023-11-12 12:31:00+00
316	144	3	2	36.90	73.80	\N	2023-12-19 21:14:00+00	2023-12-19 21:14:00+00
317	144	6	1	44.90	44.90	\N	2023-12-19 21:14:00+00	2023-12-19 21:14:00+00
318	144	30	1	4.50	4.50	\N	2023-12-19 21:14:00+00	2023-12-19 21:14:00+00
319	144	23	2	16.90	33.80	\N	2023-12-19 21:14:00+00	2023-12-19 21:14:00+00
320	145	29	1	4.50	4.50	\N	2024-03-08 13:04:00+00	2024-03-08 13:04:00+00
321	146	19	1	28.90	28.90	\N	2023-12-21 19:29:00+00	2023-12-21 19:29:00+00
322	146	12	1	62.90	62.90	\N	2023-12-21 19:29:00+00	2023-12-21 19:29:00+00
323	147	27	1	21.90	21.90	\N	2023-11-21 20:09:00+00	2023-11-21 20:09:00+00
324	147	11	1	82.90	82.90	\N	2023-11-21 20:09:00+00	2023-11-21 20:09:00+00
325	148	2	2	32.90	65.80	\N	2024-02-23 13:26:00+00	2024-02-23 13:26:00+00
326	148	19	1	28.90	28.90	\N	2024-02-23 13:26:00+00	2024-02-23 13:26:00+00
327	148	23	1	16.90	16.90	\N	2024-02-23 13:26:00+00	2024-02-23 13:26:00+00
328	149	3	1	36.90	36.90	\N	2024-02-21 23:06:00+00	2024-02-21 23:06:00+00
329	149	1	1	24.90	24.90	\N	2024-02-21 23:06:00+00	2024-02-21 23:06:00+00
330	149	29	1	4.50	4.50	\N	2024-02-21 23:06:00+00	2024-02-21 23:06:00+00
331	149	12	1	62.90	62.90	\N	2024-02-21 23:06:00+00	2024-02-21 23:06:00+00
332	150	2	2	32.90	65.80	\N	2023-11-06 22:26:00+00	2023-11-06 22:26:00+00
333	150	28	1	24.90	24.90	\N	2023-11-06 22:26:00+00	2023-11-06 22:26:00+00
334	151	9	1	37.90	37.90	\N	2023-10-03 13:41:00+00	2023-10-03 13:41:00+00
335	151	20	1	7.50	7.50	\N	2023-10-03 13:41:00+00	2023-10-03 13:41:00+00
336	152	31	1	4.50	4.50	\N	2023-10-09 23:50:00+00	2023-10-09 23:50:00+00
337	152	28	1	24.90	24.90	\N	2023-10-09 23:50:00+00	2023-10-09 23:50:00+00
338	153	24	2	9.90	19.80	\N	2024-02-29 13:41:00+00	2024-02-29 13:41:00+00
339	153	16	2	29.90	59.80	\N	2024-02-29 13:41:00+00	2024-02-29 13:41:00+00
340	153	14	1	18.90	18.90	\N	2024-02-29 13:41:00+00	2024-02-29 13:41:00+00
341	153	4	1	42.90	42.90	\N	2024-02-29 13:41:00+00	2024-02-29 13:41:00+00
342	154	9	1	37.90	37.90	\N	2023-11-30 12:40:00+00	2023-11-30 12:40:00+00
343	155	22	2	7.00	14.00	\N	2024-01-26 18:23:00+00	2024-01-26 18:23:00+00
344	155	6	1	44.90	44.90	\N	2024-01-26 18:23:00+00	2024-01-26 18:23:00+00
345	155	30	2	4.50	9.00	\N	2024-01-26 18:23:00+00	2024-01-26 18:23:00+00
346	156	27	1	21.90	21.90	\N	2024-02-16 21:56:00+00	2024-02-16 21:56:00+00
347	156	24	1	9.90	9.90	\N	2024-02-16 21:56:00+00	2024-02-16 21:56:00+00
348	157	2	1	32.90	32.90	\N	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
349	157	30	2	4.50	9.00	\N	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
350	157	11	1	82.90	82.90	\N	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
351	157	3	1	36.90	36.90	\N	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
352	158	7	1	41.90	41.90	\N	2024-01-21 19:49:00+00	2024-01-21 19:49:00+00
353	158	17	1	24.90	24.90	\N	2024-01-21 19:49:00+00	2024-01-21 19:49:00+00
354	158	13	1	149.90	149.90	\N	2024-01-21 19:49:00+00	2024-01-21 19:49:00+00
355	159	9	1	37.90	37.90	\N	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
356	159	15	1	22.90	22.90	\N	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
357	159	1	1	24.90	24.90	\N	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
358	160	13	1	149.90	149.90	\N	2023-12-08 12:42:00+00	2023-12-08 12:42:00+00
359	161	22	1	7.00	7.00	\N	2023-10-26 12:37:00+00	2023-10-26 12:37:00+00
360	161	15	1	22.90	22.90	\N	2023-10-26 12:37:00+00	2023-10-26 12:37:00+00
361	161	16	1	29.90	29.90	\N	2023-10-26 12:37:00+00	2023-10-26 12:37:00+00
362	162	21	1	7.50	7.50	\N	2024-01-22 21:13:00+00	2024-01-22 21:13:00+00
363	162	26	2	23.90	47.80	\N	2024-01-22 21:13:00+00	2024-01-22 21:13:00+00
364	163	23	1	16.90	16.90	\N	2023-10-27 22:03:00+00	2023-10-27 22:03:00+00
365	164	10	1	46.90	46.90	\N	2023-10-01 20:18:00+00	2023-10-01 20:18:00+00
366	164	10	1	46.90	46.90	\N	2023-10-01 20:18:00+00	2023-10-01 20:18:00+00
367	164	26	1	23.90	23.90	\N	2023-10-01 20:18:00+00	2023-10-01 20:18:00+00
368	165	5	1	39.90	39.90	\N	2024-02-02 22:57:00+00	2024-02-02 22:57:00+00
369	165	3	2	36.90	73.80	\N	2024-02-02 22:57:00+00	2024-02-02 22:57:00+00
370	166	3	2	36.90	73.80	\N	2024-02-12 21:51:00+00	2024-02-12 21:51:00+00
371	167	30	1	4.50	4.50	\N	2023-11-10 21:26:00+00	2023-11-10 21:26:00+00
372	168	11	1	82.90	82.90	\N	2023-10-12 11:28:00+00	2023-10-12 11:28:00+00
373	168	19	1	28.90	28.90	\N	2023-10-12 11:28:00+00	2023-10-12 11:28:00+00
374	168	7	2	41.90	83.80	\N	2023-10-12 11:28:00+00	2023-10-12 11:28:00+00
375	169	31	2	4.50	9.00	\N	2024-01-22 21:53:00+00	2024-01-22 21:53:00+00
376	169	1	1	24.90	24.90	\N	2024-01-22 21:53:00+00	2024-01-22 21:53:00+00
377	169	18	1	26.90	26.90	\N	2024-01-22 21:53:00+00	2024-01-22 21:53:00+00
378	170	9	1	37.90	37.90	\N	2023-12-08 13:23:00+00	2023-12-08 13:23:00+00
379	170	2	1	32.90	32.90	\N	2023-12-08 13:23:00+00	2023-12-08 13:23:00+00
380	171	9	2	37.90	75.80	\N	2023-10-18 19:41:00+00	2023-10-18 19:41:00+00
381	172	25	1	5.00	5.00	\N	2024-01-17 18:27:00+00	2024-01-17 18:27:00+00
382	172	7	1	41.90	41.90	\N	2024-01-17 18:27:00+00	2024-01-17 18:27:00+00
383	173	26	1	23.90	23.90	\N	2024-01-06 12:25:00+00	2024-01-06 12:25:00+00
384	173	3	1	36.90	36.90	\N	2024-01-06 12:25:00+00	2024-01-06 12:25:00+00
385	174	26	1	23.90	23.90	\N	2024-01-07 18:17:00+00	2024-01-07 18:17:00+00
386	174	12	1	62.90	62.90	\N	2024-01-07 18:17:00+00	2024-01-07 18:17:00+00
387	175	9	1	37.90	37.90	\N	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
388	175	9	2	37.90	75.80	\N	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
389	175	31	1	4.50	4.50	\N	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
390	175	7	1	41.90	41.90	\N	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
391	176	28	2	24.90	49.80	\N	2024-02-23 21:01:00+00	2024-02-23 21:01:00+00
392	177	22	1	7.00	7.00	\N	2023-11-01 12:47:00+00	2023-11-01 12:47:00+00
393	178	14	1	18.90	18.90	\N	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
394	178	9	2	37.90	75.80	\N	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
395	178	9	1	37.90	37.90	\N	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
396	179	5	2	39.90	79.80	\N	2023-11-20 21:45:00+00	2023-11-20 21:45:00+00
397	180	26	1	23.90	23.90	\N	2023-11-21 22:36:00+00	2023-11-21 22:36:00+00
398	181	8	1	34.90	34.90	\N	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
399	181	17	1	24.90	24.90	\N	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
400	181	1	1	24.90	24.90	\N	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
401	182	26	1	23.90	23.90	\N	2023-12-19 22:34:00+00	2023-12-19 22:34:00+00
402	183	30	1	4.50	4.50	\N	2024-02-05 13:55:00+00	2024-02-05 13:55:00+00
403	184	20	1	7.50	7.50	\N	2023-11-24 18:08:00+00	2023-11-24 18:08:00+00
404	184	18	1	26.90	26.90	\N	2023-11-24 18:08:00+00	2023-11-24 18:08:00+00
405	185	20	1	7.50	7.50	\N	2023-12-12 23:01:00+00	2023-12-12 23:01:00+00
406	185	28	1	24.90	24.90	\N	2023-12-12 23:01:00+00	2023-12-12 23:01:00+00
407	186	22	1	7.00	7.00	\N	2023-11-28 11:45:00+00	2023-11-28 11:45:00+00
408	186	24	1	9.90	9.90	\N	2023-11-28 11:45:00+00	2023-11-28 11:45:00+00
409	187	20	1	7.50	7.50	\N	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00
410	187	5	1	39.90	39.90	\N	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00
411	187	27	2	21.90	43.80	\N	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00
412	187	19	1	28.90	28.90	\N	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00
413	188	24	2	9.90	19.80	\N	2023-11-26 18:18:00+00	2023-11-26 18:18:00+00
414	189	27	2	21.90	43.80	\N	2024-01-08 23:48:00+00	2024-01-08 23:48:00+00
415	189	26	1	23.90	23.90	\N	2024-01-08 23:48:00+00	2024-01-08 23:48:00+00
416	190	9	1	37.90	37.90	\N	2024-03-01 20:21:00+00	2024-03-01 20:21:00+00
417	191	12	1	62.90	62.90	\N	2023-11-22 18:53:00+00	2023-11-22 18:53:00+00
418	191	9	2	37.90	75.80	\N	2023-11-22 18:53:00+00	2023-11-22 18:53:00+00
419	192	8	1	34.90	34.90	\N	2023-12-29 19:07:00+00	2023-12-29 19:07:00+00
420	192	31	1	4.50	4.50	\N	2023-12-29 19:07:00+00	2023-12-29 19:07:00+00
421	193	12	1	62.90	62.90	\N	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00
422	193	21	1	7.50	7.50	\N	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00
423	193	4	1	42.90	42.90	\N	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00
424	193	8	1	34.90	34.90	\N	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00
425	194	12	1	62.90	62.90	\N	2023-11-11 23:38:00+00	2023-11-11 23:38:00+00
426	194	17	1	24.90	24.90	\N	2023-11-11 23:38:00+00	2023-11-11 23:38:00+00
427	195	27	1	21.90	21.90	\N	2023-12-25 12:03:00+00	2023-12-25 12:03:00+00
428	195	31	2	4.50	9.00	\N	2023-12-25 12:03:00+00	2023-12-25 12:03:00+00
429	196	3	1	36.90	36.90	\N	2024-01-03 12:59:00+00	2024-01-03 12:59:00+00
430	196	17	1	24.90	24.90	\N	2024-01-03 12:59:00+00	2024-01-03 12:59:00+00
431	197	3	1	36.90	36.90	\N	2023-12-02 19:31:00+00	2023-12-02 19:31:00+00
432	197	5	1	39.90	39.90	\N	2023-12-02 19:31:00+00	2023-12-02 19:31:00+00
433	197	30	1	4.50	4.50	\N	2023-12-02 19:31:00+00	2023-12-02 19:31:00+00
434	198	5	1	39.90	39.90	\N	2024-02-18 13:24:00+00	2024-02-18 13:24:00+00
435	199	3	1	36.90	36.90	\N	2024-01-24 13:08:00+00	2024-01-24 13:08:00+00
436	200	28	1	24.90	24.90	\N	2024-02-27 13:03:00+00	2024-02-27 13:03:00+00
437	200	21	1	7.50	7.50	\N	2024-02-27 13:03:00+00	2024-02-27 13:03:00+00
438	201	12	1	62.90	62.90	\N	2023-12-01 19:27:00+00	2023-12-01 19:27:00+00
439	202	16	1	29.90	29.90	\N	2023-11-20 23:44:00+00	2023-11-20 23:44:00+00
440	203	10	1	46.90	46.90	\N	2023-10-29 18:54:00+00	2023-10-29 18:54:00+00
441	203	4	2	42.90	85.80	\N	2023-10-29 18:54:00+00	2023-10-29 18:54:00+00
442	204	12	1	62.90	62.90	\N	2024-02-21 22:26:00+00	2024-02-21 22:26:00+00
443	204	4	1	42.90	42.90	\N	2024-02-21 22:26:00+00	2024-02-21 22:26:00+00
444	205	14	1	18.90	18.90	\N	2024-02-17 11:01:00+00	2024-02-17 11:01:00+00
445	205	22	2	7.00	14.00	\N	2024-02-17 11:01:00+00	2024-02-17 11:01:00+00
446	205	28	1	24.90	24.90	\N	2024-02-17 11:01:00+00	2024-02-17 11:01:00+00
447	206	15	1	22.90	22.90	\N	2023-11-23 12:58:00+00	2023-11-23 12:58:00+00
448	206	17	1	24.90	24.90	\N	2023-11-23 12:58:00+00	2023-11-23 12:58:00+00
449	206	13	1	149.90	149.90	\N	2023-11-23 12:58:00+00	2023-11-23 12:58:00+00
450	206	28	1	24.90	24.90	\N	2023-11-23 12:58:00+00	2023-11-23 12:58:00+00
451	207	8	1	34.90	34.90	\N	2023-10-07 12:39:00+00	2023-10-07 12:39:00+00
452	207	18	2	26.90	53.80	\N	2023-10-07 12:39:00+00	2023-10-07 12:39:00+00
453	208	3	1	36.90	36.90	\N	2023-12-21 13:26:00+00	2023-12-21 13:26:00+00
454	209	10	1	46.90	46.90	\N	2023-10-16 11:49:00+00	2023-10-16 11:49:00+00
455	209	12	1	62.90	62.90	\N	2023-10-16 11:49:00+00	2023-10-16 11:49:00+00
456	210	26	1	23.90	23.90	\N	2023-11-30 20:24:00+00	2023-11-30 20:24:00+00
457	211	28	2	24.90	49.80	\N	2024-02-11 19:29:00+00	2024-02-11 19:29:00+00
458	211	26	1	23.90	23.90	\N	2024-02-11 19:29:00+00	2024-02-11 19:29:00+00
459	212	7	2	41.90	83.80	\N	2023-10-10 18:00:00+00	2023-10-10 18:00:00+00
460	212	1	1	24.90	24.90	\N	2023-10-10 18:00:00+00	2023-10-10 18:00:00+00
461	213	29	1	4.50	4.50	\N	2023-11-04 11:48:00+00	2023-11-04 11:48:00+00
462	213	8	1	34.90	34.90	\N	2023-11-04 11:48:00+00	2023-11-04 11:48:00+00
463	214	28	1	24.90	24.90	\N	2023-10-20 19:53:00+00	2023-10-20 19:53:00+00
464	214	18	1	26.90	26.90	\N	2023-10-20 19:53:00+00	2023-10-20 19:53:00+00
465	215	25	1	5.00	5.00	\N	2023-11-16 11:36:00+00	2023-11-16 11:36:00+00
466	215	17	1	24.90	24.90	\N	2023-11-16 11:36:00+00	2023-11-16 11:36:00+00
467	216	22	1	7.00	7.00	\N	2023-10-27 22:38:00+00	2023-10-27 22:38:00+00
468	216	17	1	24.90	24.90	\N	2023-10-27 22:38:00+00	2023-10-27 22:38:00+00
469	216	18	1	26.90	26.90	\N	2023-10-27 22:38:00+00	2023-10-27 22:38:00+00
470	217	27	2	21.90	43.80	\N	2023-10-19 12:53:00+00	2023-10-19 12:53:00+00
471	217	27	1	21.90	21.90	\N	2023-10-19 12:53:00+00	2023-10-19 12:53:00+00
472	218	23	1	16.90	16.90	\N	2023-10-27 21:34:00+00	2023-10-27 21:34:00+00
473	218	12	1	62.90	62.90	\N	2023-10-27 21:34:00+00	2023-10-27 21:34:00+00
474	219	13	1	149.90	149.90	\N	2024-01-06 18:15:00+00	2024-01-06 18:15:00+00
475	220	15	1	22.90	22.90	\N	2024-03-09 19:15:00+00	2024-03-09 19:15:00+00
476	220	13	1	149.90	149.90	\N	2024-03-09 19:15:00+00	2024-03-09 19:15:00+00
477	221	3	2	36.90	73.80	\N	2023-10-05 18:45:00+00	2023-10-05 18:45:00+00
478	221	4	1	42.90	42.90	\N	2023-10-05 18:45:00+00	2023-10-05 18:45:00+00
479	222	20	1	7.50	7.50	\N	2023-11-06 19:15:00+00	2023-11-06 19:15:00+00
480	222	9	2	37.90	75.80	\N	2023-11-06 19:15:00+00	2023-11-06 19:15:00+00
481	223	27	1	21.90	21.90	\N	2023-10-25 13:40:00+00	2023-10-25 13:40:00+00
482	223	21	1	7.50	7.50	\N	2023-10-25 13:40:00+00	2023-10-25 13:40:00+00
483	223	15	1	22.90	22.90	\N	2023-10-25 13:40:00+00	2023-10-25 13:40:00+00
484	224	2	1	32.90	32.90	\N	2023-10-13 13:44:00+00	2023-10-13 13:44:00+00
485	225	25	2	5.00	10.00	\N	2023-12-04 18:58:00+00	2023-12-04 18:58:00+00
486	225	2	1	32.90	32.90	\N	2023-12-04 18:58:00+00	2023-12-04 18:58:00+00
487	226	14	1	18.90	18.90	\N	2024-03-06 12:36:00+00	2024-03-06 12:36:00+00
488	226	23	1	16.90	16.90	\N	2024-03-06 12:36:00+00	2024-03-06 12:36:00+00
489	226	16	1	29.90	29.90	\N	2024-03-06 12:36:00+00	2024-03-06 12:36:00+00
490	227	24	1	9.90	9.90	\N	2024-01-12 12:46:00+00	2024-01-12 12:46:00+00
491	227	1	2	24.90	49.80	\N	2024-01-12 12:46:00+00	2024-01-12 12:46:00+00
492	228	29	1	4.50	4.50	\N	2024-01-05 19:17:00+00	2024-01-05 19:17:00+00
493	228	12	1	62.90	62.90	\N	2024-01-05 19:17:00+00	2024-01-05 19:17:00+00
494	229	31	1	4.50	4.50	\N	2023-12-07 20:08:00+00	2023-12-07 20:08:00+00
495	229	11	1	82.90	82.90	\N	2023-12-07 20:08:00+00	2023-12-07 20:08:00+00
496	230	16	1	29.90	29.90	\N	2023-12-12 13:19:00+00	2023-12-12 13:19:00+00
497	230	20	1	7.50	7.50	\N	2023-12-12 13:19:00+00	2023-12-12 13:19:00+00
498	231	25	1	5.00	5.00	\N	2023-10-15 22:44:00+00	2023-10-15 22:44:00+00
499	231	19	1	28.90	28.90	\N	2023-10-15 22:44:00+00	2023-10-15 22:44:00+00
500	232	6	1	44.90	44.90	\N	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
501	232	21	1	7.50	7.50	\N	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
502	232	4	2	42.90	85.80	\N	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
503	232	10	1	46.90	46.90	\N	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
504	233	16	1	29.90	29.90	\N	2023-12-05 22:33:00+00	2023-12-05 22:33:00+00
505	233	6	1	44.90	44.90	\N	2023-12-05 22:33:00+00	2023-12-05 22:33:00+00
506	233	27	1	21.90	21.90	\N	2023-12-05 22:33:00+00	2023-12-05 22:33:00+00
507	234	4	1	42.90	42.90	\N	2023-12-21 22:16:00+00	2023-12-21 22:16:00+00
508	234	19	1	28.90	28.90	\N	2023-12-21 22:16:00+00	2023-12-21 22:16:00+00
509	234	23	1	16.90	16.90	\N	2023-12-21 22:16:00+00	2023-12-21 22:16:00+00
510	234	21	2	7.50	15.00	\N	2023-12-21 22:16:00+00	2023-12-21 22:16:00+00
511	235	14	1	18.90	18.90	\N	2024-01-30 11:20:00+00	2024-01-30 11:20:00+00
512	235	1	2	24.90	49.80	\N	2024-01-30 11:20:00+00	2024-01-30 11:20:00+00
513	236	10	1	46.90	46.90	\N	2023-11-30 21:21:00+00	2023-11-30 21:21:00+00
514	236	5	2	39.90	79.80	\N	2023-11-30 21:21:00+00	2023-11-30 21:21:00+00
515	237	2	1	32.90	32.90	\N	2023-11-09 22:57:00+00	2023-11-09 22:57:00+00
516	238	4	1	42.90	42.90	\N	2023-10-26 22:41:00+00	2023-10-26 22:41:00+00
517	238	8	1	34.90	34.90	\N	2023-10-26 22:41:00+00	2023-10-26 22:41:00+00
518	239	24	1	9.90	9.90	\N	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
519	239	8	2	34.90	69.80	\N	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
520	239	30	1	4.50	4.50	\N	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
521	239	8	1	34.90	34.90	\N	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
522	240	19	2	28.90	57.80	\N	2023-12-29 21:10:00+00	2023-12-29 21:10:00+00
523	240	22	1	7.00	7.00	\N	2023-12-29 21:10:00+00	2023-12-29 21:10:00+00
524	241	24	2	9.90	19.80	\N	2023-12-22 18:32:00+00	2023-12-22 18:32:00+00
525	242	16	1	29.90	29.90	\N	2023-11-03 11:21:00+00	2023-11-03 11:21:00+00
526	242	16	1	29.90	29.90	\N	2023-11-03 11:21:00+00	2023-11-03 11:21:00+00
527	243	5	1	39.90	39.90	\N	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00
528	243	15	1	22.90	22.90	\N	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00
529	243	12	1	62.90	62.90	\N	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00
530	243	1	1	24.90	24.90	\N	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00
531	244	6	1	44.90	44.90	\N	2024-01-02 11:14:00+00	2024-01-02 11:14:00+00
532	244	21	2	7.50	15.00	\N	2024-01-02 11:14:00+00	2024-01-02 11:14:00+00
533	245	28	2	24.90	49.80	\N	2023-12-21 12:38:00+00	2023-12-21 12:38:00+00
534	245	24	1	9.90	9.90	\N	2023-12-21 12:38:00+00	2023-12-21 12:38:00+00
535	245	14	1	18.90	18.90	\N	2023-12-21 12:38:00+00	2023-12-21 12:38:00+00
536	245	27	1	21.90	21.90	\N	2023-12-21 12:38:00+00	2023-12-21 12:38:00+00
537	246	4	2	42.90	85.80	\N	2024-01-14 19:11:00+00	2024-01-14 19:11:00+00
538	247	1	1	24.90	24.90	\N	2024-03-09 11:10:00+00	2024-03-09 11:10:00+00
539	247	31	2	4.50	9.00	\N	2024-03-09 11:10:00+00	2024-03-09 11:10:00+00
540	248	3	1	36.90	36.90	\N	2024-02-08 22:51:00+00	2024-02-08 22:51:00+00
541	248	28	1	24.90	24.90	\N	2024-02-08 22:51:00+00	2024-02-08 22:51:00+00
542	248	11	1	82.90	82.90	\N	2024-02-08 22:51:00+00	2024-02-08 22:51:00+00
543	248	19	1	28.90	28.90	\N	2024-02-08 22:51:00+00	2024-02-08 22:51:00+00
544	249	9	1	37.90	37.90	\N	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00
545	249	24	1	9.90	9.90	\N	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00
546	249	17	1	24.90	24.90	\N	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00
547	250	6	1	44.90	44.90	\N	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
548	250	9	1	37.90	37.90	\N	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
549	250	3	2	36.90	73.80	\N	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
550	250	5	1	39.90	39.90	\N	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
551	251	24	1	9.90	9.90	\N	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00
552	251	26	1	23.90	23.90	\N	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00
553	251	13	1	149.90	149.90	\N	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00
554	251	7	1	41.90	41.90	\N	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00
555	252	23	1	16.90	16.90	\N	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
556	252	4	1	42.90	42.90	\N	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
557	252	21	1	7.50	7.50	\N	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
558	252	5	1	39.90	39.90	\N	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
559	253	6	1	44.90	44.90	\N	2023-11-25 11:47:00+00	2023-11-25 11:47:00+00
560	253	30	1	4.50	4.50	\N	2023-11-25 11:47:00+00	2023-11-25 11:47:00+00
561	253	12	1	62.90	62.90	\N	2023-11-25 11:47:00+00	2023-11-25 11:47:00+00
562	254	14	1	18.90	18.90	\N	2023-10-26 12:35:00+00	2023-10-26 12:35:00+00
563	255	4	1	42.90	42.90	\N	2024-02-27 11:12:00+00	2024-02-27 11:12:00+00
564	255	13	1	149.90	149.90	\N	2024-02-27 11:12:00+00	2024-02-27 11:12:00+00
565	256	16	1	29.90	29.90	\N	2024-02-23 23:01:00+00	2024-02-23 23:01:00+00
566	256	15	1	22.90	22.90	\N	2024-02-23 23:01:00+00	2024-02-23 23:01:00+00
567	257	17	1	24.90	24.90	\N	2024-01-31 19:34:00+00	2024-01-31 19:34:00+00
568	258	21	2	7.50	15.00	\N	2023-12-19 23:21:00+00	2023-12-19 23:21:00+00
569	258	7	1	41.90	41.90	\N	2023-12-19 23:21:00+00	2023-12-19 23:21:00+00
570	259	3	1	36.90	36.90	\N	2023-12-09 22:38:00+00	2023-12-09 22:38:00+00
571	259	6	1	44.90	44.90	\N	2023-12-09 22:38:00+00	2023-12-09 22:38:00+00
572	259	10	1	46.90	46.90	\N	2023-12-09 22:38:00+00	2023-12-09 22:38:00+00
573	260	28	1	24.90	24.90	\N	2023-10-10 22:19:00+00	2023-10-10 22:19:00+00
574	260	8	1	34.90	34.90	\N	2023-10-10 22:19:00+00	2023-10-10 22:19:00+00
575	261	21	1	7.50	7.50	\N	2024-02-18 21:36:00+00	2024-02-18 21:36:00+00
576	262	3	1	36.90	36.90	\N	2023-10-25 20:50:00+00	2023-10-25 20:50:00+00
577	262	7	1	41.90	41.90	\N	2023-10-25 20:50:00+00	2023-10-25 20:50:00+00
578	263	30	1	4.50	4.50	\N	2024-01-17 13:42:00+00	2024-01-17 13:42:00+00
579	263	29	1	4.50	4.50	\N	2024-01-17 13:42:00+00	2024-01-17 13:42:00+00
580	263	18	1	26.90	26.90	\N	2024-01-17 13:42:00+00	2024-01-17 13:42:00+00
581	264	31	1	4.50	4.50	\N	2024-02-08 18:17:00+00	2024-02-08 18:17:00+00
582	264	1	2	24.90	49.80	\N	2024-02-08 18:17:00+00	2024-02-08 18:17:00+00
583	265	18	1	26.90	26.90	\N	2023-11-26 18:15:00+00	2023-11-26 18:15:00+00
584	265	1	2	24.90	49.80	\N	2023-11-26 18:15:00+00	2023-11-26 18:15:00+00
585	265	25	2	5.00	10.00	\N	2023-11-26 18:15:00+00	2023-11-26 18:15:00+00
586	266	20	1	7.50	7.50	\N	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
587	266	26	1	23.90	23.90	\N	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
588	267	29	1	4.50	4.50	\N	2023-11-14 18:27:00+00	2023-11-14 18:27:00+00
589	267	4	1	42.90	42.90	\N	2023-11-14 18:27:00+00	2023-11-14 18:27:00+00
590	268	10	1	46.90	46.90	\N	2024-02-08 18:37:00+00	2024-02-08 18:37:00+00
591	269	27	2	21.90	43.80	\N	2023-10-09 12:49:00+00	2023-10-09 12:49:00+00
592	270	30	1	4.50	4.50	\N	2024-01-15 21:50:00+00	2024-01-15 21:50:00+00
593	270	10	1	46.90	46.90	\N	2024-01-15 21:50:00+00	2024-01-15 21:50:00+00
594	270	22	1	7.00	7.00	\N	2024-01-15 21:50:00+00	2024-01-15 21:50:00+00
595	271	27	1	21.90	21.90	\N	2023-12-09 19:38:00+00	2023-12-09 19:38:00+00
596	272	26	1	23.90	23.90	\N	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
597	272	1	1	24.90	24.90	\N	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
598	272	23	1	16.90	16.90	\N	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
599	272	7	1	41.90	41.90	\N	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
600	273	29	2	4.50	9.00	\N	2024-02-06 13:09:00+00	2024-02-06 13:09:00+00
601	274	1	1	24.90	24.90	\N	2023-12-08 22:37:00+00	2023-12-08 22:37:00+00
602	274	19	1	28.90	28.90	\N	2023-12-08 22:37:00+00	2023-12-08 22:37:00+00
603	275	23	2	16.90	33.80	\N	2024-01-06 23:59:00+00	2024-01-06 23:59:00+00
604	275	30	2	4.50	9.00	\N	2024-01-06 23:59:00+00	2024-01-06 23:59:00+00
605	276	2	1	32.90	32.90	\N	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
606	276	1	1	24.90	24.90	\N	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
607	276	6	2	44.90	89.80	\N	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
608	277	27	1	21.90	21.90	\N	2023-12-19 23:50:00+00	2023-12-19 23:50:00+00
609	278	31	1	4.50	4.50	\N	2023-12-11 23:24:00+00	2023-12-11 23:24:00+00
610	279	16	1	29.90	29.90	\N	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00
611	279	2	2	32.90	65.80	\N	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00
612	279	13	1	149.90	149.90	\N	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00
613	279	5	2	39.90	79.80	\N	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00
614	280	14	1	18.90	18.90	\N	2023-12-25 19:48:00+00	2023-12-25 19:48:00+00
615	281	21	1	7.50	7.50	\N	2024-02-12 23:38:00+00	2024-02-12 23:38:00+00
616	281	30	1	4.50	4.50	\N	2024-02-12 23:38:00+00	2024-02-12 23:38:00+00
617	282	14	1	18.90	18.90	\N	2024-01-14 23:15:00+00	2024-01-14 23:15:00+00
618	282	26	1	23.90	23.90	\N	2024-01-14 23:15:00+00	2024-01-14 23:15:00+00
619	283	25	1	5.00	5.00	\N	2024-01-13 18:02:00+00	2024-01-13 18:02:00+00
620	283	21	2	7.50	15.00	\N	2024-01-13 18:02:00+00	2024-01-13 18:02:00+00
621	284	2	1	32.90	32.90	\N	2023-10-21 12:50:00+00	2023-10-21 12:50:00+00
622	284	14	1	18.90	18.90	\N	2023-10-21 12:50:00+00	2023-10-21 12:50:00+00
623	285	18	1	26.90	26.90	\N	2024-02-23 23:50:00+00	2024-02-23 23:50:00+00
624	285	2	1	32.90	32.90	\N	2024-02-23 23:50:00+00	2024-02-23 23:50:00+00
625	285	15	1	22.90	22.90	\N	2024-02-23 23:50:00+00	2024-02-23 23:50:00+00
626	285	31	2	4.50	9.00	\N	2024-02-23 23:50:00+00	2024-02-23 23:50:00+00
627	286	13	1	149.90	149.90	\N	2023-10-27 22:58:00+00	2023-10-27 22:58:00+00
628	286	3	1	36.90	36.90	\N	2023-10-27 22:58:00+00	2023-10-27 22:58:00+00
629	287	21	1	7.50	7.50	\N	2024-02-01 21:44:00+00	2024-02-01 21:44:00+00
630	287	29	1	4.50	4.50	\N	2024-02-01 21:44:00+00	2024-02-01 21:44:00+00
631	288	15	1	22.90	22.90	\N	2023-11-19 12:57:00+00	2023-11-19 12:57:00+00
632	288	18	1	26.90	26.90	\N	2023-11-19 12:57:00+00	2023-11-19 12:57:00+00
633	288	6	1	44.90	44.90	\N	2023-11-19 12:57:00+00	2023-11-19 12:57:00+00
634	288	16	2	29.90	59.80	\N	2023-11-19 12:57:00+00	2023-11-19 12:57:00+00
635	289	14	1	18.90	18.90	\N	2023-12-04 21:02:00+00	2023-12-04 21:02:00+00
636	289	2	1	32.90	32.90	\N	2023-12-04 21:02:00+00	2023-12-04 21:02:00+00
637	289	1	1	24.90	24.90	\N	2023-12-04 21:02:00+00	2023-12-04 21:02:00+00
638	290	3	1	36.90	36.90	\N	2024-02-01 11:46:00+00	2024-02-01 11:46:00+00
639	290	20	1	7.50	7.50	\N	2024-02-01 11:46:00+00	2024-02-01 11:46:00+00
640	290	4	1	42.90	42.90	\N	2024-02-01 11:46:00+00	2024-02-01 11:46:00+00
641	291	15	1	22.90	22.90	\N	2024-02-04 23:26:00+00	2024-02-04 23:26:00+00
642	291	3	1	36.90	36.90	\N	2024-02-04 23:26:00+00	2024-02-04 23:26:00+00
643	292	17	1	24.90	24.90	\N	2024-02-07 19:55:00+00	2024-02-07 19:55:00+00
644	292	11	1	82.90	82.90	\N	2024-02-07 19:55:00+00	2024-02-07 19:55:00+00
645	293	24	2	9.90	19.80	\N	2024-01-19 12:06:00+00	2024-01-19 12:06:00+00
646	293	1	2	24.90	49.80	\N	2024-01-19 12:06:00+00	2024-01-19 12:06:00+00
647	293	13	1	149.90	149.90	\N	2024-01-19 12:06:00+00	2024-01-19 12:06:00+00
648	294	26	1	23.90	23.90	\N	2024-01-28 20:55:00+00	2024-01-28 20:55:00+00
649	294	22	1	7.00	7.00	\N	2024-01-28 20:55:00+00	2024-01-28 20:55:00+00
650	295	1	2	24.90	49.80	\N	2023-12-28 11:41:00+00	2023-12-28 11:41:00+00
651	295	28	1	24.90	24.90	\N	2023-12-28 11:41:00+00	2023-12-28 11:41:00+00
652	296	16	1	29.90	29.90	\N	2023-11-29 13:20:00+00	2023-11-29 13:20:00+00
653	296	30	1	4.50	4.50	\N	2023-11-29 13:20:00+00	2023-11-29 13:20:00+00
654	297	17	2	24.90	49.80	\N	2024-02-19 20:39:00+00	2024-02-19 20:39:00+00
655	297	15	1	22.90	22.90	\N	2024-02-19 20:39:00+00	2024-02-19 20:39:00+00
656	297	23	1	16.90	16.90	\N	2024-02-19 20:39:00+00	2024-02-19 20:39:00+00
657	298	29	1	4.50	4.50	\N	2024-03-02 12:31:00+00	2024-03-02 12:31:00+00
658	298	23	2	16.90	33.80	\N	2024-03-02 12:31:00+00	2024-03-02 12:31:00+00
659	299	7	2	41.90	83.80	\N	2024-02-21 11:30:00+00	2024-02-21 11:30:00+00
660	300	18	1	26.90	26.90	\N	2024-03-02 18:21:00+00	2024-03-02 18:21:00+00
661	300	8	2	34.90	69.80	\N	2024-03-02 18:21:00+00	2024-03-02 18:21:00+00
662	301	4	1	42.90	42.90	\N	2023-11-13 12:40:00+00	2023-11-13 12:40:00+00
663	301	26	1	23.90	23.90	\N	2023-11-13 12:40:00+00	2023-11-13 12:40:00+00
664	301	27	1	21.90	21.90	\N	2023-11-13 12:40:00+00	2023-11-13 12:40:00+00
665	302	15	1	22.90	22.90	\N	2023-10-05 20:22:00+00	2023-10-05 20:22:00+00
666	302	18	1	26.90	26.90	\N	2023-10-05 20:22:00+00	2023-10-05 20:22:00+00
667	303	4	1	42.90	42.90	\N	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
668	303	18	1	26.90	26.90	\N	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
669	303	5	2	39.90	79.80	\N	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
670	303	9	1	37.90	37.90	\N	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
671	304	30	2	4.50	9.00	\N	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00
672	304	21	1	7.50	7.50	\N	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00
673	304	3	1	36.90	36.90	\N	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00
674	304	7	1	41.90	41.90	\N	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00
675	305	7	1	41.90	41.90	\N	2023-11-01 12:11:00+00	2023-11-01 12:11:00+00
676	305	6	1	44.90	44.90	\N	2023-11-01 12:11:00+00	2023-11-01 12:11:00+00
677	306	15	1	22.90	22.90	\N	2024-02-23 19:03:00+00	2024-02-23 19:03:00+00
678	306	6	2	44.90	89.80	\N	2024-02-23 19:03:00+00	2024-02-23 19:03:00+00
679	307	11	1	82.90	82.90	\N	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00
680	307	4	1	42.90	42.90	\N	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00
681	307	7	1	41.90	41.90	\N	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00
682	308	29	1	4.50	4.50	\N	2024-02-03 12:18:00+00	2024-02-03 12:18:00+00
683	309	19	1	28.90	28.90	\N	2024-02-25 11:52:00+00	2024-02-25 11:52:00+00
684	309	10	1	46.90	46.90	\N	2024-02-25 11:52:00+00	2024-02-25 11:52:00+00
685	310	13	1	149.90	149.90	\N	2023-11-16 19:40:00+00	2023-11-16 19:40:00+00
686	310	9	1	37.90	37.90	\N	2023-11-16 19:40:00+00	2023-11-16 19:40:00+00
687	310	22	2	7.00	14.00	\N	2023-11-16 19:40:00+00	2023-11-16 19:40:00+00
688	311	25	1	5.00	5.00	\N	2023-11-01 22:16:00+00	2023-11-01 22:16:00+00
689	311	21	1	7.50	7.50	\N	2023-11-01 22:16:00+00	2023-11-01 22:16:00+00
690	312	11	1	82.90	82.90	\N	2024-02-19 11:13:00+00	2024-02-19 11:13:00+00
691	312	14	1	18.90	18.90	\N	2024-02-19 11:13:00+00	2024-02-19 11:13:00+00
692	312	11	1	82.90	82.90	\N	2024-02-19 11:13:00+00	2024-02-19 11:13:00+00
693	313	6	1	44.90	44.90	\N	2023-11-26 13:12:00+00	2023-11-26 13:12:00+00
694	313	23	1	16.90	16.90	\N	2023-11-26 13:12:00+00	2023-11-26 13:12:00+00
695	314	8	1	34.90	34.90	\N	2023-11-04 13:35:00+00	2023-11-04 13:35:00+00
696	314	10	1	46.90	46.90	\N	2023-11-04 13:35:00+00	2023-11-04 13:35:00+00
697	315	3	1	36.90	36.90	\N	2023-11-14 20:14:00+00	2023-11-14 20:14:00+00
698	315	3	1	36.90	36.90	\N	2023-11-14 20:14:00+00	2023-11-14 20:14:00+00
699	315	7	1	41.90	41.90	\N	2023-11-14 20:14:00+00	2023-11-14 20:14:00+00
700	316	29	1	4.50	4.50	\N	2023-10-30 22:01:00+00	2023-10-30 22:01:00+00
701	316	6	1	44.90	44.90	\N	2023-10-30 22:01:00+00	2023-10-30 22:01:00+00
702	317	2	1	32.90	32.90	\N	2024-03-06 21:14:00+00	2024-03-06 21:14:00+00
703	317	10	1	46.90	46.90	\N	2024-03-06 21:14:00+00	2024-03-06 21:14:00+00
704	318	19	1	28.90	28.90	\N	2024-02-05 11:16:00+00	2024-02-05 11:16:00+00
705	318	26	1	23.90	23.90	\N	2024-02-05 11:16:00+00	2024-02-05 11:16:00+00
706	318	30	1	4.50	4.50	\N	2024-02-05 11:16:00+00	2024-02-05 11:16:00+00
707	319	13	1	149.90	149.90	\N	2023-11-02 22:55:00+00	2023-11-02 22:55:00+00
708	319	15	1	22.90	22.90	\N	2023-11-02 22:55:00+00	2023-11-02 22:55:00+00
709	320	31	1	4.50	4.50	\N	2024-01-06 18:05:00+00	2024-01-06 18:05:00+00
710	320	23	1	16.90	16.90	\N	2024-01-06 18:05:00+00	2024-01-06 18:05:00+00
711	320	11	1	82.90	82.90	\N	2024-01-06 18:05:00+00	2024-01-06 18:05:00+00
712	320	29	1	4.50	4.50	\N	2024-01-06 18:05:00+00	2024-01-06 18:05:00+00
713	321	5	1	39.90	39.90	\N	2023-10-23 22:19:00+00	2023-10-23 22:19:00+00
714	321	14	2	18.90	37.80	\N	2023-10-23 22:19:00+00	2023-10-23 22:19:00+00
715	321	4	2	42.90	85.80	\N	2023-10-23 22:19:00+00	2023-10-23 22:19:00+00
716	322	29	1	4.50	4.50	\N	2023-10-03 23:22:00+00	2023-10-03 23:22:00+00
717	322	13	1	149.90	149.90	\N	2023-10-03 23:22:00+00	2023-10-03 23:22:00+00
718	323	15	2	22.90	45.80	\N	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00
719	323	14	1	18.90	18.90	\N	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00
720	323	4	1	42.90	42.90	\N	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00
721	323	26	1	23.90	23.90	\N	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00
722	324	25	2	5.00	10.00	\N	2024-02-01 11:35:00+00	2024-02-01 11:35:00+00
723	325	23	1	16.90	16.90	\N	2024-02-20 18:31:00+00	2024-02-20 18:31:00+00
724	325	24	1	9.90	9.90	\N	2024-02-20 18:31:00+00	2024-02-20 18:31:00+00
725	326	23	1	16.90	16.90	\N	2023-10-02 19:51:00+00	2023-10-02 19:51:00+00
726	327	8	1	34.90	34.90	\N	2024-03-08 19:27:00+00	2024-03-08 19:27:00+00
727	328	17	2	24.90	49.80	\N	2024-01-25 18:41:00+00	2024-01-25 18:41:00+00
728	328	31	1	4.50	4.50	\N	2024-01-25 18:41:00+00	2024-01-25 18:41:00+00
729	328	6	1	44.90	44.90	\N	2024-01-25 18:41:00+00	2024-01-25 18:41:00+00
730	328	10	1	46.90	46.90	\N	2024-01-25 18:41:00+00	2024-01-25 18:41:00+00
731	329	21	2	7.50	15.00	\N	2023-11-14 21:04:00+00	2023-11-14 21:04:00+00
732	329	8	2	34.90	69.80	\N	2023-11-14 21:04:00+00	2023-11-14 21:04:00+00
733	330	8	2	34.90	69.80	\N	2023-12-19 23:47:00+00	2023-12-19 23:47:00+00
734	330	13	1	149.90	149.90	\N	2023-12-19 23:47:00+00	2023-12-19 23:47:00+00
735	331	13	1	149.90	149.90	\N	2024-02-20 11:38:00+00	2024-02-20 11:38:00+00
736	332	16	1	29.90	29.90	\N	2023-12-23 22:55:00+00	2023-12-23 22:55:00+00
737	333	7	1	41.90	41.90	\N	2023-12-31 21:13:00+00	2023-12-31 21:13:00+00
738	333	1	1	24.90	24.90	\N	2023-12-31 21:13:00+00	2023-12-31 21:13:00+00
739	334	14	1	18.90	18.90	\N	2023-12-14 11:05:00+00	2023-12-14 11:05:00+00
740	334	21	1	7.50	7.50	\N	2023-12-14 11:05:00+00	2023-12-14 11:05:00+00
741	334	1	1	24.90	24.90	\N	2023-12-14 11:05:00+00	2023-12-14 11:05:00+00
742	335	22	1	7.00	7.00	\N	2024-02-07 20:24:00+00	2024-02-07 20:24:00+00
743	335	12	1	62.90	62.90	\N	2024-02-07 20:24:00+00	2024-02-07 20:24:00+00
744	336	25	1	5.00	5.00	\N	2024-02-06 18:20:00+00	2024-02-06 18:20:00+00
745	337	25	1	5.00	5.00	\N	2023-10-08 19:23:00+00	2023-10-08 19:23:00+00
746	337	18	1	26.90	26.90	\N	2023-10-08 19:23:00+00	2023-10-08 19:23:00+00
747	338	24	1	9.90	9.90	\N	2023-10-27 18:23:00+00	2023-10-27 18:23:00+00
748	338	10	1	46.90	46.90	\N	2023-10-27 18:23:00+00	2023-10-27 18:23:00+00
749	339	24	1	9.90	9.90	\N	2024-01-17 22:35:00+00	2024-01-17 22:35:00+00
750	340	7	1	41.90	41.90	\N	2024-01-17 20:37:00+00	2024-01-17 20:37:00+00
751	340	23	1	16.90	16.90	\N	2024-01-17 20:37:00+00	2024-01-17 20:37:00+00
752	341	22	1	7.00	7.00	\N	2023-11-12 18:35:00+00	2023-11-12 18:35:00+00
753	341	5	2	39.90	79.80	\N	2023-11-12 18:35:00+00	2023-11-12 18:35:00+00
754	342	14	2	18.90	37.80	\N	2024-02-11 19:33:00+00	2024-02-11 19:33:00+00
755	343	16	1	29.90	29.90	\N	2023-10-05 20:42:00+00	2023-10-05 20:42:00+00
756	343	17	1	24.90	24.90	\N	2023-10-05 20:42:00+00	2023-10-05 20:42:00+00
757	344	19	1	28.90	28.90	\N	2024-01-09 11:16:00+00	2024-01-09 11:16:00+00
758	345	15	2	22.90	45.80	\N	2023-10-16 11:56:00+00	2023-10-16 11:56:00+00
759	345	4	1	42.90	42.90	\N	2023-10-16 11:56:00+00	2023-10-16 11:56:00+00
760	346	19	2	28.90	57.80	\N	2024-01-28 18:01:00+00	2024-01-28 18:01:00+00
761	346	20	1	7.50	7.50	\N	2024-01-28 18:01:00+00	2024-01-28 18:01:00+00
762	347	7	2	41.90	83.80	\N	2024-03-02 11:58:00+00	2024-03-02 11:58:00+00
763	347	15	2	22.90	45.80	\N	2024-03-02 11:58:00+00	2024-03-02 11:58:00+00
764	347	25	1	5.00	5.00	\N	2024-03-02 11:58:00+00	2024-03-02 11:58:00+00
765	348	17	2	24.90	49.80	\N	2024-01-19 23:39:00+00	2024-01-19 23:39:00+00
766	348	30	1	4.50	4.50	\N	2024-01-19 23:39:00+00	2024-01-19 23:39:00+00
767	349	15	1	22.90	22.90	\N	2024-01-06 21:05:00+00	2024-01-06 21:05:00+00
768	350	27	1	21.90	21.90	\N	2023-10-21 21:50:00+00	2023-10-21 21:50:00+00
769	350	17	1	24.90	24.90	\N	2023-10-21 21:50:00+00	2023-10-21 21:50:00+00
770	350	7	1	41.90	41.90	\N	2023-10-21 21:50:00+00	2023-10-21 21:50:00+00
771	351	5	1	39.90	39.90	\N	2023-10-30 13:42:00+00	2023-10-30 13:42:00+00
772	351	17	2	24.90	49.80	\N	2023-10-30 13:42:00+00	2023-10-30 13:42:00+00
773	351	27	1	21.90	21.90	\N	2023-10-30 13:42:00+00	2023-10-30 13:42:00+00
774	352	5	1	39.90	39.90	\N	2023-11-06 13:30:00+00	2023-11-06 13:30:00+00
775	353	14	1	18.90	18.90	\N	2023-12-17 19:50:00+00	2023-12-17 19:50:00+00
776	353	20	2	7.50	15.00	\N	2023-12-17 19:50:00+00	2023-12-17 19:50:00+00
777	354	16	1	29.90	29.90	\N	2024-01-10 22:55:00+00	2024-01-10 22:55:00+00
778	354	1	1	24.90	24.90	\N	2024-01-10 22:55:00+00	2024-01-10 22:55:00+00
779	355	15	1	22.90	22.90	\N	2023-12-21 18:02:00+00	2023-12-21 18:02:00+00
780	355	3	1	36.90	36.90	\N	2023-12-21 18:02:00+00	2023-12-21 18:02:00+00
781	356	13	1	149.90	149.90	\N	2023-10-11 23:26:00+00	2023-10-11 23:26:00+00
782	356	31	1	4.50	4.50	\N	2023-10-11 23:26:00+00	2023-10-11 23:26:00+00
783	357	12	1	62.90	62.90	\N	2023-11-28 19:19:00+00	2023-11-28 19:19:00+00
784	357	13	1	149.90	149.90	\N	2023-11-28 19:19:00+00	2023-11-28 19:19:00+00
785	357	4	2	42.90	85.80	\N	2023-11-28 19:19:00+00	2023-11-28 19:19:00+00
786	358	6	1	44.90	44.90	\N	2024-03-02 11:28:00+00	2024-03-02 11:28:00+00
787	358	6	2	44.90	89.80	\N	2024-03-02 11:28:00+00	2024-03-02 11:28:00+00
788	358	10	1	46.90	46.90	\N	2024-03-02 11:28:00+00	2024-03-02 11:28:00+00
789	359	27	1	21.90	21.90	\N	2024-02-06 21:51:00+00	2024-02-06 21:51:00+00
790	360	26	1	23.90	23.90	\N	2023-11-30 18:09:00+00	2023-11-30 18:09:00+00
791	361	17	1	24.90	24.90	\N	2023-12-28 19:52:00+00	2023-12-28 19:52:00+00
792	361	16	1	29.90	29.90	\N	2023-12-28 19:52:00+00	2023-12-28 19:52:00+00
793	362	16	1	29.90	29.90	\N	2024-01-15 19:31:00+00	2024-01-15 19:31:00+00
794	362	17	1	24.90	24.90	\N	2024-01-15 19:31:00+00	2024-01-15 19:31:00+00
795	363	8	1	34.90	34.90	\N	2023-10-02 11:43:00+00	2023-10-02 11:43:00+00
796	363	22	1	7.00	7.00	\N	2023-10-02 11:43:00+00	2023-10-02 11:43:00+00
797	364	9	1	37.90	37.90	\N	2023-11-06 21:27:00+00	2023-11-06 21:27:00+00
798	364	14	2	18.90	37.80	\N	2023-11-06 21:27:00+00	2023-11-06 21:27:00+00
799	365	11	1	82.90	82.90	\N	2024-01-04 19:39:00+00	2024-01-04 19:39:00+00
800	365	28	1	24.90	24.90	\N	2024-01-04 19:39:00+00	2024-01-04 19:39:00+00
801	366	22	1	7.00	7.00	\N	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00
802	366	9	1	37.90	37.90	\N	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00
803	366	3	1	36.90	36.90	\N	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00
804	367	28	1	24.90	24.90	\N	2024-01-08 13:10:00+00	2024-01-08 13:10:00+00
805	367	3	1	36.90	36.90	\N	2024-01-08 13:10:00+00	2024-01-08 13:10:00+00
806	367	30	2	4.50	9.00	\N	2024-01-08 13:10:00+00	2024-01-08 13:10:00+00
807	367	15	1	22.90	22.90	\N	2024-01-08 13:10:00+00	2024-01-08 13:10:00+00
808	368	19	1	28.90	28.90	\N	2023-11-18 12:37:00+00	2023-11-18 12:37:00+00
809	368	2	2	32.90	65.80	\N	2023-11-18 12:37:00+00	2023-11-18 12:37:00+00
810	368	25	1	5.00	5.00	\N	2023-11-18 12:37:00+00	2023-11-18 12:37:00+00
811	368	10	1	46.90	46.90	\N	2023-11-18 12:37:00+00	2023-11-18 12:37:00+00
812	369	17	1	24.90	24.90	\N	2023-10-27 23:26:00+00	2023-10-27 23:26:00+00
813	370	2	2	32.90	65.80	\N	2024-03-07 20:51:00+00	2024-03-07 20:51:00+00
814	370	24	1	9.90	9.90	\N	2024-03-07 20:51:00+00	2024-03-07 20:51:00+00
815	371	6	2	44.90	89.80	\N	2023-11-10 21:33:00+00	2023-11-10 21:33:00+00
816	371	20	1	7.50	7.50	\N	2023-11-10 21:33:00+00	2023-11-10 21:33:00+00
817	371	27	1	21.90	21.90	\N	2023-11-10 21:33:00+00	2023-11-10 21:33:00+00
818	372	31	1	4.50	4.50	\N	2023-10-27 18:15:00+00	2023-10-27 18:15:00+00
819	372	15	1	22.90	22.90	\N	2023-10-27 18:15:00+00	2023-10-27 18:15:00+00
820	373	4	2	42.90	85.80	\N	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00
821	373	11	1	82.90	82.90	\N	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00
822	373	10	1	46.90	46.90	\N	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00
823	373	26	1	23.90	23.90	\N	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00
824	374	3	1	36.90	36.90	\N	2023-12-18 23:53:00+00	2023-12-18 23:53:00+00
825	374	22	1	7.00	7.00	\N	2023-12-18 23:53:00+00	2023-12-18 23:53:00+00
826	375	15	1	22.90	22.90	\N	2024-03-07 20:11:00+00	2024-03-07 20:11:00+00
827	376	21	1	7.50	7.50	\N	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
828	376	12	1	62.90	62.90	\N	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
829	376	7	1	41.90	41.90	\N	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
830	376	16	2	29.90	59.80	\N	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
831	377	7	1	41.90	41.90	\N	2023-10-04 11:20:00+00	2023-10-04 11:20:00+00
832	377	29	1	4.50	4.50	\N	2023-10-04 11:20:00+00	2023-10-04 11:20:00+00
833	378	8	2	34.90	69.80	\N	2024-02-05 13:31:00+00	2024-02-05 13:31:00+00
834	378	27	1	21.90	21.90	\N	2024-02-05 13:31:00+00	2024-02-05 13:31:00+00
835	379	17	1	24.90	24.90	\N	2023-12-22 22:26:00+00	2023-12-22 22:26:00+00
836	379	12	1	62.90	62.90	\N	2023-12-22 22:26:00+00	2023-12-22 22:26:00+00
837	380	26	1	23.90	23.90	\N	2024-03-02 21:04:00+00	2024-03-02 21:04:00+00
838	380	15	1	22.90	22.90	\N	2024-03-02 21:04:00+00	2024-03-02 21:04:00+00
839	380	3	1	36.90	36.90	\N	2024-03-02 21:04:00+00	2024-03-02 21:04:00+00
840	381	31	2	4.50	9.00	\N	2024-02-22 19:32:00+00	2024-02-22 19:32:00+00
841	381	19	1	28.90	28.90	\N	2024-02-22 19:32:00+00	2024-02-22 19:32:00+00
842	381	31	1	4.50	4.50	\N	2024-02-22 19:32:00+00	2024-02-22 19:32:00+00
843	382	29	1	4.50	4.50	\N	2023-12-06 23:17:00+00	2023-12-06 23:17:00+00
844	382	16	1	29.90	29.90	\N	2023-12-06 23:17:00+00	2023-12-06 23:17:00+00
845	383	29	1	4.50	4.50	\N	2024-01-22 21:18:00+00	2024-01-22 21:18:00+00
846	383	14	1	18.90	18.90	\N	2024-01-22 21:18:00+00	2024-01-22 21:18:00+00
847	383	14	2	18.90	37.80	\N	2024-01-22 21:18:00+00	2024-01-22 21:18:00+00
848	384	9	1	37.90	37.90	\N	2023-10-23 20:49:00+00	2023-10-23 20:49:00+00
849	384	12	1	62.90	62.90	\N	2023-10-23 20:49:00+00	2023-10-23 20:49:00+00
850	385	16	2	29.90	59.80	\N	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
851	385	7	1	41.90	41.90	\N	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
852	385	7	1	41.90	41.90	\N	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
853	386	3	1	36.90	36.90	\N	2023-12-24 19:05:00+00	2023-12-24 19:05:00+00
854	386	4	1	42.90	42.90	\N	2023-12-24 19:05:00+00	2023-12-24 19:05:00+00
855	387	11	1	82.90	82.90	\N	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
856	387	17	1	24.90	24.90	\N	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
857	387	6	1	44.90	44.90	\N	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
858	387	26	1	23.90	23.90	\N	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
859	388	26	1	23.90	23.90	\N	2023-11-26 23:47:00+00	2023-11-26 23:47:00+00
860	388	18	1	26.90	26.90	\N	2023-11-26 23:47:00+00	2023-11-26 23:47:00+00
861	389	24	1	9.90	9.90	\N	2024-01-21 23:12:00+00	2024-01-21 23:12:00+00
862	389	17	1	24.90	24.90	\N	2024-01-21 23:12:00+00	2024-01-21 23:12:00+00
863	390	13	1	149.90	149.90	\N	2023-12-26 20:28:00+00	2023-12-26 20:28:00+00
864	391	1	2	24.90	49.80	\N	2023-11-10 23:21:00+00	2023-11-10 23:21:00+00
865	392	20	1	7.50	7.50	\N	2023-11-07 21:00:00+00	2023-11-07 21:00:00+00
866	393	26	1	23.90	23.90	\N	2024-03-04 13:08:00+00	2024-03-04 13:08:00+00
867	393	31	1	4.50	4.50	\N	2024-03-04 13:08:00+00	2024-03-04 13:08:00+00
868	394	1	1	24.90	24.90	\N	2023-12-14 22:41:00+00	2023-12-14 22:41:00+00
869	394	10	1	46.90	46.90	\N	2023-12-14 22:41:00+00	2023-12-14 22:41:00+00
870	395	6	1	44.90	44.90	\N	2024-01-13 11:08:00+00	2024-01-13 11:08:00+00
871	395	2	1	32.90	32.90	\N	2024-01-13 11:08:00+00	2024-01-13 11:08:00+00
872	396	25	1	5.00	5.00	\N	2023-10-27 11:36:00+00	2023-10-27 11:36:00+00
873	397	8	1	34.90	34.90	\N	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
874	397	30	1	4.50	4.50	\N	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
875	397	5	1	39.90	39.90	\N	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
876	398	30	2	4.50	9.00	\N	2024-01-25 19:03:00+00	2024-01-25 19:03:00+00
877	398	5	1	39.90	39.90	\N	2024-01-25 19:03:00+00	2024-01-25 19:03:00+00
878	399	7	1	41.90	41.90	\N	2024-02-17 23:12:00+00	2024-02-17 23:12:00+00
879	399	27	1	21.90	21.90	\N	2024-02-17 23:12:00+00	2024-02-17 23:12:00+00
880	400	27	2	21.90	43.80	\N	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00
881	400	9	2	37.90	75.80	\N	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00
882	400	6	1	44.90	44.90	\N	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00
883	401	4	1	42.90	42.90	\N	2023-10-14 22:57:00+00	2023-10-14 22:57:00+00
884	401	21	1	7.50	7.50	\N	2023-10-14 22:57:00+00	2023-10-14 22:57:00+00
885	401	19	2	28.90	57.80	\N	2023-10-14 22:57:00+00	2023-10-14 22:57:00+00
886	402	3	1	36.90	36.90	\N	2023-10-15 11:28:00+00	2023-10-15 11:28:00+00
887	403	5	1	39.90	39.90	\N	2024-02-12 22:57:00+00	2024-02-12 22:57:00+00
888	403	13	1	149.90	149.90	\N	2024-02-12 22:57:00+00	2024-02-12 22:57:00+00
889	403	23	1	16.90	16.90	\N	2024-02-12 22:57:00+00	2024-02-12 22:57:00+00
890	404	12	1	62.90	62.90	\N	2024-02-14 13:40:00+00	2024-02-14 13:40:00+00
891	405	24	2	9.90	19.80	\N	2023-12-11 12:01:00+00	2023-12-11 12:01:00+00
892	406	3	1	36.90	36.90	\N	2024-02-21 23:20:00+00	2024-02-21 23:20:00+00
893	406	21	1	7.50	7.50	\N	2024-02-21 23:20:00+00	2024-02-21 23:20:00+00
894	407	24	2	9.90	19.80	\N	2023-10-13 21:07:00+00	2023-10-13 21:07:00+00
895	407	29	1	4.50	4.50	\N	2023-10-13 21:07:00+00	2023-10-13 21:07:00+00
896	408	10	1	46.90	46.90	\N	2023-11-10 21:02:00+00	2023-11-10 21:02:00+00
897	408	25	1	5.00	5.00	\N	2023-11-10 21:02:00+00	2023-11-10 21:02:00+00
898	409	13	1	149.90	149.90	\N	2023-10-10 23:38:00+00	2023-10-10 23:38:00+00
899	409	11	1	82.90	82.90	\N	2023-10-10 23:38:00+00	2023-10-10 23:38:00+00
900	410	6	1	44.90	44.90	\N	2024-02-11 21:56:00+00	2024-02-11 21:56:00+00
901	410	14	2	18.90	37.80	\N	2024-02-11 21:56:00+00	2024-02-11 21:56:00+00
902	411	24	1	9.90	9.90	\N	2023-10-07 13:21:00+00	2023-10-07 13:21:00+00
903	411	16	1	29.90	29.90	\N	2023-10-07 13:21:00+00	2023-10-07 13:21:00+00
904	412	2	1	32.90	32.90	\N	2023-12-12 21:19:00+00	2023-12-12 21:19:00+00
905	412	8	2	34.90	69.80	\N	2023-12-12 21:19:00+00	2023-12-12 21:19:00+00
906	413	24	1	9.90	9.90	\N	2023-11-08 21:54:00+00	2023-11-08 21:54:00+00
907	413	4	1	42.90	42.90	\N	2023-11-08 21:54:00+00	2023-11-08 21:54:00+00
908	413	22	1	7.00	7.00	\N	2023-11-08 21:54:00+00	2023-11-08 21:54:00+00
909	413	14	1	18.90	18.90	\N	2023-11-08 21:54:00+00	2023-11-08 21:54:00+00
910	414	30	1	4.50	4.50	\N	2024-03-05 19:12:00+00	2024-03-05 19:12:00+00
911	415	15	1	22.90	22.90	\N	2023-10-19 11:58:00+00	2023-10-19 11:58:00+00
912	415	30	1	4.50	4.50	\N	2023-10-19 11:58:00+00	2023-10-19 11:58:00+00
913	416	19	1	28.90	28.90	\N	2023-11-19 20:59:00+00	2023-11-19 20:59:00+00
914	416	25	1	5.00	5.00	\N	2023-11-19 20:59:00+00	2023-11-19 20:59:00+00
915	417	27	1	21.90	21.90	\N	2023-12-14 18:23:00+00	2023-12-14 18:23:00+00
916	417	30	1	4.50	4.50	\N	2023-12-14 18:23:00+00	2023-12-14 18:23:00+00
917	418	18	1	26.90	26.90	\N	2024-01-23 23:00:00+00	2024-01-23 23:00:00+00
918	418	10	1	46.90	46.90	\N	2024-01-23 23:00:00+00	2024-01-23 23:00:00+00
919	418	21	1	7.50	7.50	\N	2024-01-23 23:00:00+00	2024-01-23 23:00:00+00
920	419	31	1	4.50	4.50	\N	2024-01-17 18:09:00+00	2024-01-17 18:09:00+00
921	419	2	1	32.90	32.90	\N	2024-01-17 18:09:00+00	2024-01-17 18:09:00+00
922	420	4	1	42.90	42.90	\N	2023-12-19 19:56:00+00	2023-12-19 19:56:00+00
923	420	2	1	32.90	32.90	\N	2023-12-19 19:56:00+00	2023-12-19 19:56:00+00
924	421	28	1	24.90	24.90	\N	2023-11-06 12:54:00+00	2023-11-06 12:54:00+00
925	421	14	1	18.90	18.90	\N	2023-11-06 12:54:00+00	2023-11-06 12:54:00+00
926	422	5	2	39.90	79.80	\N	2023-11-09 19:19:00+00	2023-11-09 19:19:00+00
927	422	14	1	18.90	18.90	\N	2023-11-09 19:19:00+00	2023-11-09 19:19:00+00
928	422	1	1	24.90	24.90	\N	2023-11-09 19:19:00+00	2023-11-09 19:19:00+00
929	423	22	1	7.00	7.00	\N	2023-12-05 23:23:00+00	2023-12-05 23:23:00+00
930	423	15	1	22.90	22.90	\N	2023-12-05 23:23:00+00	2023-12-05 23:23:00+00
931	424	17	1	24.90	24.90	\N	2023-11-29 12:33:00+00	2023-11-29 12:33:00+00
932	425	23	1	16.90	16.90	\N	2023-11-19 22:52:00+00	2023-11-19 22:52:00+00
933	425	30	2	4.50	9.00	\N	2023-11-19 22:52:00+00	2023-11-19 22:52:00+00
934	426	27	1	21.90	21.90	\N	2023-10-28 20:38:00+00	2023-10-28 20:38:00+00
935	427	15	1	22.90	22.90	\N	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00
936	427	13	1	149.90	149.90	\N	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00
937	427	2	2	32.90	65.80	\N	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00
938	427	27	1	21.90	21.90	\N	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00
939	428	15	1	22.90	22.90	\N	2024-01-26 21:49:00+00	2024-01-26 21:49:00+00
940	428	28	1	24.90	24.90	\N	2024-01-26 21:49:00+00	2024-01-26 21:49:00+00
941	429	15	1	22.90	22.90	\N	2024-01-06 23:03:00+00	2024-01-06 23:03:00+00
942	429	4	1	42.90	42.90	\N	2024-01-06 23:03:00+00	2024-01-06 23:03:00+00
943	430	3	2	36.90	73.80	\N	2023-12-23 18:29:00+00	2023-12-23 18:29:00+00
944	430	15	1	22.90	22.90	\N	2023-12-23 18:29:00+00	2023-12-23 18:29:00+00
945	431	17	1	24.90	24.90	\N	2023-11-03 12:08:00+00	2023-11-03 12:08:00+00
946	431	15	1	22.90	22.90	\N	2023-11-03 12:08:00+00	2023-11-03 12:08:00+00
947	431	31	1	4.50	4.50	\N	2023-11-03 12:08:00+00	2023-11-03 12:08:00+00
948	432	11	1	82.90	82.90	\N	2023-11-03 20:26:00+00	2023-11-03 20:26:00+00
949	432	30	2	4.50	9.00	\N	2023-11-03 20:26:00+00	2023-11-03 20:26:00+00
950	432	25	2	5.00	10.00	\N	2023-11-03 20:26:00+00	2023-11-03 20:26:00+00
951	433	12	1	62.90	62.90	\N	2024-01-11 18:16:00+00	2024-01-11 18:16:00+00
952	434	24	1	9.90	9.90	\N	2024-01-03 18:11:00+00	2024-01-03 18:11:00+00
953	435	9	1	37.90	37.90	\N	2023-11-09 23:11:00+00	2023-11-09 23:11:00+00
954	435	14	1	18.90	18.90	\N	2023-11-09 23:11:00+00	2023-11-09 23:11:00+00
955	436	23	1	16.90	16.90	\N	2024-01-27 19:05:00+00	2024-01-27 19:05:00+00
956	436	19	1	28.90	28.90	\N	2024-01-27 19:05:00+00	2024-01-27 19:05:00+00
957	437	29	1	4.50	4.50	\N	2024-03-09 13:52:00+00	2024-03-09 13:52:00+00
958	438	6	2	44.90	89.80	\N	2024-03-04 18:08:00+00	2024-03-04 18:08:00+00
959	438	9	1	37.90	37.90	\N	2024-03-04 18:08:00+00	2024-03-04 18:08:00+00
960	438	16	1	29.90	29.90	\N	2024-03-04 18:08:00+00	2024-03-04 18:08:00+00
961	439	12	1	62.90	62.90	\N	2023-10-31 23:45:00+00	2023-10-31 23:45:00+00
962	440	17	1	24.90	24.90	\N	2023-12-28 11:46:00+00	2023-12-28 11:46:00+00
963	440	26	2	23.90	47.80	\N	2023-12-28 11:46:00+00	2023-12-28 11:46:00+00
964	440	29	1	4.50	4.50	\N	2023-12-28 11:46:00+00	2023-12-28 11:46:00+00
965	440	22	1	7.00	7.00	\N	2023-12-28 11:46:00+00	2023-12-28 11:46:00+00
966	441	9	1	37.90	37.90	\N	2023-12-31 11:05:00+00	2023-12-31 11:05:00+00
967	442	22	1	7.00	7.00	\N	2023-11-23 20:40:00+00	2023-11-23 20:40:00+00
968	442	25	1	5.00	5.00	\N	2023-11-23 20:40:00+00	2023-11-23 20:40:00+00
969	443	31	2	4.50	9.00	\N	2024-01-21 13:33:00+00	2024-01-21 13:33:00+00
970	444	8	1	34.90	34.90	\N	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
971	444	3	1	36.90	36.90	\N	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
972	444	21	2	7.50	15.00	\N	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
973	444	20	1	7.50	7.50	\N	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
974	445	10	1	46.90	46.90	\N	2024-01-06 23:05:00+00	2024-01-06 23:05:00+00
975	445	11	1	82.90	82.90	\N	2024-01-06 23:05:00+00	2024-01-06 23:05:00+00
976	446	20	1	7.50	7.50	\N	2024-02-25 18:10:00+00	2024-02-25 18:10:00+00
977	447	30	1	4.50	4.50	\N	2023-12-29 20:38:00+00	2023-12-29 20:38:00+00
978	447	14	1	18.90	18.90	\N	2023-12-29 20:38:00+00	2023-12-29 20:38:00+00
979	448	1	1	24.90	24.90	\N	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00
980	448	11	1	82.90	82.90	\N	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00
981	448	17	1	24.90	24.90	\N	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00
982	448	8	1	34.90	34.90	\N	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00
983	449	29	1	4.50	4.50	\N	2023-12-15 19:05:00+00	2023-12-15 19:05:00+00
984	449	31	1	4.50	4.50	\N	2023-12-15 19:05:00+00	2023-12-15 19:05:00+00
985	450	11	1	82.90	82.90	\N	2023-11-30 20:21:00+00	2023-11-30 20:21:00+00
986	451	12	1	62.90	62.90	\N	2024-01-12 22:34:00+00	2024-01-12 22:34:00+00
987	452	27	1	21.90	21.90	\N	2024-02-01 22:27:00+00	2024-02-01 22:27:00+00
988	453	12	1	62.90	62.90	\N	2024-03-07 12:57:00+00	2024-03-07 12:57:00+00
989	453	19	1	28.90	28.90	\N	2024-03-07 12:57:00+00	2024-03-07 12:57:00+00
990	454	4	1	42.90	42.90	\N	2024-03-06 21:50:00+00	2024-03-06 21:50:00+00
991	454	13	1	149.90	149.90	\N	2024-03-06 21:50:00+00	2024-03-06 21:50:00+00
992	455	26	1	23.90	23.90	\N	2023-11-09 13:01:00+00	2023-11-09 13:01:00+00
993	455	28	1	24.90	24.90	\N	2023-11-09 13:01:00+00	2023-11-09 13:01:00+00
994	456	23	2	16.90	33.80	\N	2024-01-04 22:38:00+00	2024-01-04 22:38:00+00
995	457	19	1	28.90	28.90	\N	2024-02-17 22:51:00+00	2024-02-17 22:51:00+00
996	457	6	1	44.90	44.90	\N	2024-02-17 22:51:00+00	2024-02-17 22:51:00+00
997	458	25	1	5.00	5.00	\N	2024-02-26 11:49:00+00	2024-02-26 11:49:00+00
998	458	4	1	42.90	42.90	\N	2024-02-26 11:49:00+00	2024-02-26 11:49:00+00
999	459	3	2	36.90	73.80	\N	2023-11-30 23:13:00+00	2023-11-30 23:13:00+00
1000	459	28	1	24.90	24.90	\N	2023-11-30 23:13:00+00	2023-11-30 23:13:00+00
1001	459	28	2	24.90	49.80	\N	2023-11-30 23:13:00+00	2023-11-30 23:13:00+00
1002	460	5	1	39.90	39.90	\N	2024-02-04 12:27:00+00	2024-02-04 12:27:00+00
1003	460	12	1	62.90	62.90	\N	2024-02-04 12:27:00+00	2024-02-04 12:27:00+00
1004	461	19	1	28.90	28.90	\N	2023-10-25 21:29:00+00	2023-10-25 21:29:00+00
1005	461	19	2	28.90	57.80	\N	2023-10-25 21:29:00+00	2023-10-25 21:29:00+00
1006	462	13	1	149.90	149.90	\N	2024-01-29 11:45:00+00	2024-01-29 11:45:00+00
1007	463	3	1	36.90	36.90	\N	2024-02-12 23:43:00+00	2024-02-12 23:43:00+00
1008	463	6	1	44.90	44.90	\N	2024-02-12 23:43:00+00	2024-02-12 23:43:00+00
1009	464	5	2	39.90	79.80	\N	2023-12-11 20:48:00+00	2023-12-11 20:48:00+00
1010	464	15	1	22.90	22.90	\N	2023-12-11 20:48:00+00	2023-12-11 20:48:00+00
1011	464	22	1	7.00	7.00	\N	2023-12-11 20:48:00+00	2023-12-11 20:48:00+00
1012	465	6	1	44.90	44.90	\N	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00
1013	465	5	1	39.90	39.90	\N	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00
1014	466	17	1	24.90	24.90	\N	2023-10-25 18:54:00+00	2023-10-25 18:54:00+00
1015	467	15	1	22.90	22.90	\N	2024-02-17 18:10:00+00	2024-02-17 18:10:00+00
1016	467	7	1	41.90	41.90	\N	2024-02-17 18:10:00+00	2024-02-17 18:10:00+00
1017	467	23	1	16.90	16.90	\N	2024-02-17 18:10:00+00	2024-02-17 18:10:00+00
1018	468	5	1	39.90	39.90	\N	2024-01-21 19:10:00+00	2024-01-21 19:10:00+00
1019	469	9	1	37.90	37.90	\N	2024-01-01 18:54:00+00	2024-01-01 18:54:00+00
1020	469	14	1	18.90	18.90	\N	2024-01-01 18:54:00+00	2024-01-01 18:54:00+00
1021	469	19	1	28.90	28.90	\N	2024-01-01 18:54:00+00	2024-01-01 18:54:00+00
1022	469	7	1	41.90	41.90	\N	2024-01-01 18:54:00+00	2024-01-01 18:54:00+00
1023	470	27	1	21.90	21.90	\N	2024-01-19 13:40:00+00	2024-01-19 13:40:00+00
1024	470	29	1	4.50	4.50	\N	2024-01-19 13:40:00+00	2024-01-19 13:40:00+00
1025	471	19	1	28.90	28.90	\N	2023-10-30 12:38:00+00	2023-10-30 12:38:00+00
1026	471	4	2	42.90	85.80	\N	2023-10-30 12:38:00+00	2023-10-30 12:38:00+00
1027	472	23	1	16.90	16.90	\N	2024-01-06 23:22:00+00	2024-01-06 23:22:00+00
1028	473	4	2	42.90	85.80	\N	2024-03-06 11:23:00+00	2024-03-06 11:23:00+00
1029	473	11	1	82.90	82.90	\N	2024-03-06 11:23:00+00	2024-03-06 11:23:00+00
1030	474	8	1	34.90	34.90	\N	2024-01-13 20:33:00+00	2024-01-13 20:33:00+00
1031	474	21	2	7.50	15.00	\N	2024-01-13 20:33:00+00	2024-01-13 20:33:00+00
1032	474	31	2	4.50	9.00	\N	2024-01-13 20:33:00+00	2024-01-13 20:33:00+00
1033	475	9	1	37.90	37.90	\N	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
1034	475	5	1	39.90	39.90	\N	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
1035	475	10	1	46.90	46.90	\N	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
1036	475	5	1	39.90	39.90	\N	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
1037	476	17	1	24.90	24.90	\N	2023-10-24 19:27:00+00	2023-10-24 19:27:00+00
1038	476	23	1	16.90	16.90	\N	2023-10-24 19:27:00+00	2023-10-24 19:27:00+00
1039	476	2	1	32.90	32.90	\N	2023-10-24 19:27:00+00	2023-10-24 19:27:00+00
1040	477	12	1	62.90	62.90	\N	2023-12-13 22:51:00+00	2023-12-13 22:51:00+00
1041	477	5	1	39.90	39.90	\N	2023-12-13 22:51:00+00	2023-12-13 22:51:00+00
1042	478	25	1	5.00	5.00	\N	2024-01-04 23:36:00+00	2024-01-04 23:36:00+00
1043	478	30	1	4.50	4.50	\N	2024-01-04 23:36:00+00	2024-01-04 23:36:00+00
1044	479	22	1	7.00	7.00	\N	2023-12-11 12:27:00+00	2023-12-11 12:27:00+00
1045	479	4	1	42.90	42.90	\N	2023-12-11 12:27:00+00	2023-12-11 12:27:00+00
1046	480	11	1	82.90	82.90	\N	2023-11-29 21:41:00+00	2023-11-29 21:41:00+00
1047	480	27	1	21.90	21.90	\N	2023-11-29 21:41:00+00	2023-11-29 21:41:00+00
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.migrations (id, migration, batch) FROM stdin;
1	2026_11_01_000001_create_categorias_table	1
2	2026_11_01_000002_create_clientes_table	1
3	2026_11_01_000003_create_cupons_table	1
4	2026_11_01_000004_create_enderecos_table	1
5	2026_11_01_000005_create_ingredientes_table	1
6	2026_11_01_000006_create_produtos_table	1
7	2026_11_01_000007_create_pedidos_table	1
8	2026_11_01_000008_create_itens_pedido_table	1
9	2026_11_01_000009_create_item_adicionais_table	1
10	2026_11_01_000010_create_pagamentos_table	1
11	2026_11_01_000011_create_avaliacoes_table	1
12	2026_11_01_000012_create_objetos_banco	2
13	2026_11_02_000001_create_grupos_entrega_table	3
14	2026_11_02_000002_create_bairros_entrega_table	3
15	2026_11_02_000003_ajustar_regras_entrega_pagamento	3
\.


--
-- Data for Name: pagamentos; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.pagamentos (id, pedido_id, metodo_pagamento, status_pagamento, valor, data_pagamento, created_at, updated_at) FROM stdin;
1	1	CARTAO_DEBITO	APROVADO	78.30	2023-12-30 18:08:00+00	2023-12-30 18:08:00+00	2023-12-30 18:08:00+00
2	2	DINHEIRO	APROVADO	70.30	2023-12-10 18:47:00+00	2023-12-10 18:47:00+00	2023-12-10 18:47:00+00
3	3	CARTAO_CREDITO	APROVADO	161.30	2023-10-14 23:51:00+00	2023-10-14 23:51:00+00	2023-10-14 23:51:00+00
4	4	PIX	APROVADO	20.50	2024-02-20 20:31:00+00	2024-02-20 20:31:00+00	2024-02-20 20:31:00+00
5	5	PIX	APROVADO	32.40	2023-11-04 19:46:00+00	2023-11-04 19:46:00+00	2023-11-04 19:46:00+00
6	6	CARTAO_CREDITO	APROVADO	62.80	2024-02-07 22:11:00+00	2024-02-07 22:11:00+00	2024-02-07 22:11:00+00
7	7	PIX	APROVADO	117.29	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00
8	8	CARTAO_DEBITO	RECUSADO	180.80	2024-02-07 11:57:00+00	2024-02-07 11:57:00+00	2024-02-07 11:57:00+00
9	9	VALE_REFEICAO	APROVADO	208.80	2023-11-21 18:03:00+00	2023-11-21 18:03:00+00	2023-11-21 18:03:00+00
10	10	CARTAO_CREDITO	APROVADO	79.80	2023-12-13 20:55:00+00	2023-12-13 20:55:00+00	2023-12-13 20:55:00+00
11	11	CARTAO_DEBITO	APROVADO	61.80	2023-10-09 11:06:00+00	2023-10-09 11:06:00+00	2023-10-09 11:06:00+00
12	12	CARTAO_CREDITO	APROVADO	101.30	2023-12-30 12:31:00+00	2023-12-30 12:31:00+00	2023-12-30 12:31:00+00
13	13	PIX	APROVADO	210.10	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
14	14	CARTAO_CREDITO	APROVADO	68.90	2023-11-24 11:04:00+00	2023-11-24 11:04:00+00	2023-11-24 11:04:00+00
15	15	DINHEIRO	APROVADO	55.90	2023-10-19 12:49:00+00	2023-10-19 12:49:00+00	2023-10-19 12:49:00+00
16	16	CARTAO_DEBITO	APROVADO	110.80	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00
17	17	DINHEIRO	APROVADO	47.90	2023-11-08 11:51:00+00	2023-11-08 11:51:00+00	2023-11-08 11:51:00+00
18	18	PIX	APROVADO	40.40	2023-12-02 13:05:00+00	2023-12-02 13:05:00+00	2023-12-02 13:05:00+00
19	19	CARTAO_CREDITO	APROVADO	322.40	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
20	20	CARTAO_CREDITO	APROVADO	102.70	2023-11-24 20:12:00+00	2023-11-24 20:12:00+00	2023-11-24 20:12:00+00
21	21	CARTAO_CREDITO	APROVADO	37.90	2023-11-20 18:27:00+00	2023-11-20 18:27:00+00	2023-11-20 18:27:00+00
22	22	PIX	APROVADO	106.80	2023-12-19 11:37:00+00	2023-12-19 11:37:00+00	2023-12-19 11:37:00+00
23	23	CARTAO_CREDITO	APROVADO	138.70	2023-10-21 12:05:00+00	2023-10-21 12:05:00+00	2023-10-21 12:05:00+00
24	24	PIX	APROVADO	93.30	2024-02-28 20:44:00+00	2024-02-28 20:44:00+00	2024-02-28 20:44:00+00
25	25	CARTAO_CREDITO	APROVADO	86.80	2023-12-26 19:40:00+00	2023-12-26 19:40:00+00	2023-12-26 19:40:00+00
26	26	PIX	APROVADO	64.30	2023-10-28 19:17:00+00	2023-10-28 19:17:00+00	2023-10-28 19:17:00+00
27	27	CARTAO_CREDITO	APROVADO	34.90	2023-11-06 23:02:00+00	2023-11-06 23:02:00+00	2023-11-06 23:02:00+00
28	28	CARTAO_DEBITO	APROVADO	117.70	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00
29	29	CARTAO_CREDITO	ESTORNADO	17.50	2023-12-08 20:59:00+00	2023-12-08 20:59:00+00	2023-12-08 20:59:00+00
30	30	CARTAO_CREDITO	APROVADO	228.50	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
31	31	PIX	APROVADO	68.20	2023-10-20 12:36:00+00	2023-10-20 12:36:00+00	2023-10-20 12:36:00+00
32	32	PIX	APROVADO	189.20	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00
33	33	PIX	APROVADO	18.50	2023-12-26 18:16:00+00	2023-12-26 18:16:00+00	2023-12-26 18:16:00+00
34	34	PIX	APROVADO	41.30	2023-10-26 13:58:00+00	2023-10-26 13:58:00+00	2023-10-26 13:58:00+00
35	35	DINHEIRO	APROVADO	82.30	2023-12-30 20:32:00+00	2023-12-30 20:32:00+00	2023-12-30 20:32:00+00
36	36	PIX	APROVADO	42.40	2024-01-22 11:37:00+00	2024-01-22 11:37:00+00	2024-01-22 11:37:00+00
37	37	PIX	APROVADO	67.80	2023-10-07 13:23:00+00	2023-10-07 13:23:00+00	2023-10-07 13:23:00+00
38	38	DINHEIRO	APROVADO	24.90	2023-12-09 21:47:00+00	2023-12-09 21:47:00+00	2023-12-09 21:47:00+00
39	39	PIX	APROVADO	235.70	2023-11-27 23:55:00+00	2023-11-27 23:55:00+00	2023-11-27 23:55:00+00
40	40	PIX	APROVADO	130.70	2024-02-16 18:54:00+00	2024-02-16 18:54:00+00	2024-02-16 18:54:00+00
41	41	CARTAO_CREDITO	APROVADO	157.50	2024-02-22 23:00:00+00	2024-02-22 23:00:00+00	2024-02-22 23:00:00+00
42	42	CARTAO_DEBITO	APROVADO	52.90	2023-12-26 11:57:00+00	2023-12-26 11:57:00+00	2023-12-26 11:57:00+00
43	43	VALE_REFEICAO	APROVADO	44.90	2024-03-01 18:45:00+00	2024-03-01 18:45:00+00	2024-03-01 18:45:00+00
44	44	VALE_REFEICAO	APROVADO	149.20	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
45	45	VALE_REFEICAO	APROVADO	63.30	2023-10-10 19:29:00+00	2023-10-10 19:29:00+00	2023-10-10 19:29:00+00
46	46	CARTAO_CREDITO	APROVADO	75.30	2024-01-19 12:04:00+00	2024-01-19 12:04:00+00	2024-01-19 12:04:00+00
47	47	PIX	RECUSADO	100.20	2023-10-26 13:55:00+00	2023-10-26 13:55:00+00	2023-10-26 13:55:00+00
48	48	PIX	RECUSADO	56.90	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
49	49	CARTAO_CREDITO	APROVADO	39.90	2023-11-08 11:13:00+00	2023-11-08 11:13:00+00	2023-11-08 11:13:00+00
50	50	CARTAO_DEBITO	APROVADO	94.30	2023-11-01 22:13:00+00	2023-11-01 22:13:00+00	2023-11-01 22:13:00+00
51	51	DINHEIRO	APROVADO	79.70	2023-12-02 23:20:00+00	2023-12-02 23:20:00+00	2023-12-02 23:20:00+00
52	52	CARTAO_DEBITO	APROVADO	86.30	2024-01-13 18:35:00+00	2024-01-13 18:35:00+00	2024-01-13 18:35:00+00
53	53	CARTAO_CREDITO	APROVADO	42.90	2023-10-13 12:33:00+00	2023-10-13 12:33:00+00	2023-10-13 12:33:00+00
54	54	DINHEIRO	APROVADO	83.30	2023-10-02 21:25:00+00	2023-10-02 21:25:00+00	2023-10-02 21:25:00+00
55	55	CARTAO_CREDITO	APROVADO	78.30	2023-11-01 12:16:00+00	2023-11-01 12:16:00+00	2023-11-01 12:16:00+00
56	56	PIX	APROVADO	100.70	2023-10-26 23:43:00+00	2023-10-26 23:43:00+00	2023-10-26 23:43:00+00
57	57	PIX	RECUSADO	93.20	2023-10-28 19:54:00+00	2023-10-28 19:54:00+00	2023-10-28 19:54:00+00
58	58	PIX	APROVADO	19.00	2024-03-07 22:15:00+00	2024-03-07 22:15:00+00	2024-03-07 22:15:00+00
59	59	PIX	ESTORNADO	67.30	2024-01-21 18:55:00+00	2024-01-21 18:55:00+00	2024-01-21 18:55:00+00
60	60	CARTAO_CREDITO	RECUSADO	21.40	2023-12-21 12:56:00+00	2023-12-21 12:56:00+00	2023-12-21 12:56:00+00
61	61	PIX	APROVADO	205.30	2023-10-30 22:08:00+00	2023-10-30 22:08:00+00	2023-10-30 22:08:00+00
62	62	CARTAO_CREDITO	APROVADO	151.30	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00
63	63	CARTAO_CREDITO	APROVADO	125.70	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
64	64	VALE_REFEICAO	APROVADO	94.30	2023-12-05 23:17:00+00	2023-12-05 23:17:00+00	2023-12-05 23:17:00+00
65	65	CARTAO_CREDITO	APROVADO	171.20	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00
66	66	CARTAO_CREDITO	APROVADO	126.70	2024-02-26 22:11:00+00	2024-02-26 22:11:00+00	2024-02-26 22:11:00+00
67	67	CARTAO_CREDITO	APROVADO	16.00	2024-01-03 11:17:00+00	2024-01-03 11:17:00+00	2024-01-03 11:17:00+00
68	68	CARTAO_CREDITO	APROVADO	98.40	2023-12-13 18:49:00+00	2023-12-13 18:49:00+00	2023-12-13 18:49:00+00
69	69	VALE_REFEICAO	APROVADO	168.10	2023-12-24 13:28:00+00	2023-12-24 13:28:00+00	2023-12-24 13:28:00+00
70	70	CARTAO_DEBITO	APROVADO	186.30	2024-01-22 22:09:00+00	2024-01-22 22:09:00+00	2024-01-22 22:09:00+00
71	71	VALE_REFEICAO	APROVADO	13.00	2024-01-14 20:20:00+00	2024-01-14 20:20:00+00	2024-01-14 20:20:00+00
72	72	CARTAO_CREDITO	APROVADO	58.80	2023-10-21 11:23:00+00	2023-10-21 11:23:00+00	2023-10-21 11:23:00+00
73	73	CARTAO_CREDITO	RECUSADO	19.00	2024-01-15 12:53:00+00	2024-01-15 12:53:00+00	2024-01-15 12:53:00+00
74	74	PIX	APROVADO	123.10	2024-01-08 13:43:00+00	2024-01-08 13:43:00+00	2024-01-08 13:43:00+00
75	75	DINHEIRO	APROVADO	109.30	2023-10-05 13:33:00+00	2023-10-05 13:33:00+00	2023-10-05 13:33:00+00
76	76	PIX	APROVADO	106.70	2024-01-18 23:58:00+00	2024-01-18 23:58:00+00	2024-01-18 23:58:00+00
77	77	DINHEIRO	APROVADO	75.40	2024-02-16 18:02:00+00	2024-02-16 18:02:00+00	2024-02-16 18:02:00+00
78	78	CARTAO_CREDITO	APROVADO	184.80	2024-01-03 12:51:00+00	2024-01-03 12:51:00+00	2024-01-03 12:51:00+00
79	79	VALE_REFEICAO	APROVADO	77.80	2023-10-25 13:27:00+00	2023-10-25 13:27:00+00	2023-10-25 13:27:00+00
80	80	PIX	APROVADO	79.70	2023-11-04 21:39:00+00	2023-11-04 21:39:00+00	2023-11-04 21:39:00+00
81	81	CARTAO_CREDITO	APROVADO	65.92	2024-03-07 21:43:00+00	2024-03-07 21:43:00+00	2024-03-07 21:43:00+00
82	82	DINHEIRO	APROVADO	73.20	2023-10-20 12:56:00+00	2023-10-20 12:56:00+00	2023-10-20 12:56:00+00
83	83	CARTAO_DEBITO	APROVADO	188.90	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00
84	84	PIX	APROVADO	149.60	2024-02-06 23:18:00+00	2024-02-06 23:18:00+00	2024-02-06 23:18:00+00
85	85	CARTAO_CREDITO	APROVADO	167.44	2023-10-13 21:52:00+00	2023-10-13 21:52:00+00	2023-10-13 21:52:00+00
86	86	PIX	APROVADO	41.40	2024-02-15 23:38:00+00	2024-02-15 23:38:00+00	2024-02-15 23:38:00+00
87	87	DINHEIRO	APROVADO	192.10	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00
88	88	CARTAO_CREDITO	APROVADO	63.80	2024-02-14 18:10:00+00	2024-02-14 18:10:00+00	2024-02-14 18:10:00+00
89	89	PIX	APROVADO	91.40	2024-02-05 13:34:00+00	2024-02-05 13:34:00+00	2024-02-05 13:34:00+00
90	90	PIX	APROVADO	164.50	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
91	91	PIX	APROVADO	185.80	2023-12-21 19:38:00+00	2023-12-21 19:38:00+00	2023-12-21 19:38:00+00
92	92	CARTAO_DEBITO	APROVADO	189.58	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00
93	93	CARTAO_CREDITO	APROVADO	124.20	2023-11-03 19:17:00+00	2023-11-03 19:17:00+00	2023-11-03 19:17:00+00
94	94	PIX	RECUSADO	40.90	2024-02-17 12:34:00+00	2024-02-17 12:34:00+00	2024-02-17 12:34:00+00
95	95	PIX	APROVADO	92.90	2023-11-08 22:08:00+00	2023-11-08 22:08:00+00	2023-11-08 22:08:00+00
96	96	CARTAO_CREDITO	APROVADO	52.40	2024-03-07 11:10:00+00	2024-03-07 11:10:00+00	2024-03-07 11:10:00+00
97	97	CARTAO_CREDITO	APROVADO	71.30	2023-12-07 13:26:00+00	2023-12-07 13:26:00+00	2023-12-07 13:26:00+00
98	98	CARTAO_CREDITO	APROVADO	59.30	2024-01-04 11:37:00+00	2024-01-04 11:37:00+00	2024-01-04 11:37:00+00
99	99	CARTAO_CREDITO	APROVADO	128.60	2023-10-05 13:02:00+00	2023-10-05 13:02:00+00	2023-10-05 13:02:00+00
100	100	CARTAO_CREDITO	APROVADO	218.74	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
101	101	VALE_REFEICAO	APROVADO	103.80	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00
102	102	PIX	APROVADO	151.10	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
103	103	VALE_REFEICAO	APROVADO	36.90	2024-02-13 13:30:00+00	2024-02-13 13:30:00+00	2024-02-13 13:30:00+00
104	104	CARTAO_CREDITO	APROVADO	13.00	2024-02-05 23:57:00+00	2024-02-05 23:57:00+00	2024-02-05 23:57:00+00
105	105	DINHEIRO	RECUSADO	133.20	2023-10-03 19:26:00+00	2023-10-03 19:26:00+00	2023-10-03 19:26:00+00
106	106	PIX	RECUSADO	45.80	2024-01-09 22:00:00+00	2024-01-09 22:00:00+00	2024-01-09 22:00:00+00
107	107	VALE_REFEICAO	APROVADO	140.20	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
108	108	PIX	APROVADO	231.20	2024-01-07 12:56:00+00	2024-01-07 12:56:00+00	2024-01-07 12:56:00+00
109	109	CARTAO_CREDITO	APROVADO	124.20	2024-01-26 12:04:00+00	2024-01-26 12:04:00+00	2024-01-26 12:04:00+00
110	110	CARTAO_CREDITO	APROVADO	88.30	2023-12-25 20:18:00+00	2023-12-25 20:18:00+00	2023-12-25 20:18:00+00
111	111	DINHEIRO	APROVADO	115.10	2023-11-13 13:16:00+00	2023-11-13 13:16:00+00	2023-11-13 13:16:00+00
112	112	CARTAO_DEBITO	APROVADO	76.40	2024-01-20 11:05:00+00	2024-01-20 11:05:00+00	2024-01-20 11:05:00+00
113	113	PIX	APROVADO	108.60	2024-01-01 13:35:00+00	2024-01-01 13:35:00+00	2024-01-01 13:35:00+00
114	114	CARTAO_CREDITO	ESTORNADO	90.30	2023-12-25 11:06:00+00	2023-12-25 11:06:00+00	2023-12-25 11:06:00+00
115	115	PIX	APROVADO	43.90	2023-11-25 12:44:00+00	2023-11-25 12:44:00+00	2023-11-25 12:44:00+00
116	116	CARTAO_CREDITO	APROVADO	35.40	2024-01-24 18:51:00+00	2024-01-24 18:51:00+00	2024-01-24 18:51:00+00
117	117	CARTAO_DEBITO	APROVADO	98.70	2023-10-11 20:11:00+00	2023-10-11 20:11:00+00	2023-10-11 20:11:00+00
118	118	DINHEIRO	APROVADO	27.40	2023-11-11 21:35:00+00	2023-11-11 21:35:00+00	2023-11-11 21:35:00+00
119	119	VALE_REFEICAO	APROVADO	38.90	2023-11-11 20:52:00+00	2023-11-11 20:52:00+00	2023-11-11 20:52:00+00
120	120	DINHEIRO	APROVADO	38.90	2023-12-10 22:18:00+00	2023-12-10 22:18:00+00	2023-12-10 22:18:00+00
121	121	DINHEIRO	APROVADO	32.00	2023-12-10 13:55:00+00	2023-12-10 13:55:00+00	2023-12-10 13:55:00+00
122	122	PIX	APROVADO	52.90	2024-02-07 22:00:00+00	2024-02-07 22:00:00+00	2024-02-07 22:00:00+00
123	123	DINHEIRO	RECUSADO	55.90	2024-03-04 12:56:00+00	2024-03-04 12:56:00+00	2024-03-04 12:56:00+00
124	124	CARTAO_CREDITO	APROVADO	60.30	2024-01-29 21:56:00+00	2024-01-29 21:56:00+00	2024-01-29 21:56:00+00
125	125	CARTAO_CREDITO	APROVADO	223.70	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00
126	126	CARTAO_CREDITO	APROVADO	36.90	2023-10-03 22:55:00+00	2023-10-03 22:55:00+00	2023-10-03 22:55:00+00
127	127	VALE_REFEICAO	APROVADO	79.30	2023-10-02 13:24:00+00	2023-10-02 13:24:00+00	2023-10-02 13:24:00+00
128	128	PIX	APROVADO	19.50	2024-02-01 22:49:00+00	2024-02-01 22:49:00+00	2024-02-01 22:49:00+00
129	129	CARTAO_CREDITO	RECUSADO	34.40	2023-10-21 11:37:00+00	2023-10-21 11:37:00+00	2023-10-21 11:37:00+00
130	130	PIX	APROVADO	56.90	2023-11-01 12:09:00+00	2023-11-01 12:09:00+00	2023-11-01 12:09:00+00
131	131	CARTAO_CREDITO	RECUSADO	52.80	2023-10-15 23:37:00+00	2023-10-15 23:37:00+00	2023-10-15 23:37:00+00
132	132	CARTAO_CREDITO	APROVADO	37.90	2023-10-04 11:21:00+00	2023-10-04 11:21:00+00	2023-10-04 11:21:00+00
133	133	VALE_REFEICAO	APROVADO	99.30	2023-12-09 23:03:00+00	2023-12-09 23:03:00+00	2023-12-09 23:03:00+00
134	134	CARTAO_DEBITO	APROVADO	15.50	2024-01-22 22:44:00+00	2024-01-22 22:44:00+00	2024-01-22 22:44:00+00
135	135	CARTAO_CREDITO	APROVADO	107.70	2023-11-02 20:36:00+00	2023-11-02 20:36:00+00	2023-11-02 20:36:00+00
136	136	VALE_REFEICAO	APROVADO	64.30	2023-12-18 22:25:00+00	2023-12-18 22:25:00+00	2023-12-18 22:25:00+00
137	137	DINHEIRO	APROVADO	61.40	2023-10-12 21:07:00+00	2023-10-12 21:07:00+00	2023-10-12 21:07:00+00
138	138	PIX	RECUSADO	70.30	2023-12-23 19:40:00+00	2023-12-23 19:40:00+00	2023-12-23 19:40:00+00
139	139	CARTAO_DEBITO	APROVADO	78.70	2023-10-06 22:03:00+00	2023-10-06 22:03:00+00	2023-10-06 22:03:00+00
140	140	CARTAO_DEBITO	APROVADO	17.00	2024-02-25 21:01:00+00	2024-02-25 21:01:00+00	2024-02-25 21:01:00+00
141	141	CARTAO_CREDITO	APROVADO	178.60	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
142	142	CARTAO_CREDITO	APROVADO	179.80	2024-02-19 11:25:00+00	2024-02-19 11:25:00+00	2024-02-19 11:25:00+00
143	143	PIX	APROVADO	131.70	2023-11-12 12:31:00+00	2023-11-12 12:31:00+00	2023-11-12 12:31:00+00
144	144	CARTAO_CREDITO	APROVADO	167.00	2023-12-19 21:14:00+00	2023-12-19 21:14:00+00	2023-12-19 21:14:00+00
145	145	CARTAO_CREDITO	ESTORNADO	17.50	2024-03-08 13:04:00+00	2024-03-08 13:04:00+00	2024-03-08 13:04:00+00
146	146	CARTAO_CREDITO	APROVADO	89.80	2023-12-21 19:29:00+00	2023-12-21 19:29:00+00	2023-12-21 19:29:00+00
147	147	CARTAO_CREDITO	APROVADO	112.30	2023-11-21 20:09:00+00	2023-11-21 20:09:00+00	2023-11-21 20:09:00+00
148	148	PIX	APROVADO	125.60	2024-02-23 13:26:00+00	2024-02-23 13:26:00+00	2024-02-23 13:26:00+00
149	149	CARTAO_CREDITO	ESTORNADO	142.20	2024-02-21 23:06:00+00	2024-02-21 23:06:00+00	2024-02-21 23:06:00+00
150	150	CARTAO_DEBITO	APROVADO	101.20	2023-11-06 22:26:00+00	2023-11-06 22:26:00+00	2023-11-06 22:26:00+00
151	151	CARTAO_CREDITO	APROVADO	58.40	2023-10-03 13:41:00+00	2023-10-03 13:41:00+00	2023-10-03 13:41:00+00
152	152	PIX	APROVADO	37.90	2023-10-09 23:50:00+00	2023-10-09 23:50:00+00	2023-10-09 23:50:00+00
153	153	PIX	APROVADO	149.40	2024-02-29 13:41:00+00	2024-02-29 13:41:00+00	2024-02-29 13:41:00+00
154	154	PIX	APROVADO	57.40	2023-11-30 12:40:00+00	2023-11-30 12:40:00+00	2023-11-30 12:40:00+00
155	155	PIX	APROVADO	75.90	2024-01-26 18:23:00+00	2024-01-26 18:23:00+00	2024-01-26 18:23:00+00
156	156	VALE_REFEICAO	APROVADO	39.80	2024-02-16 21:56:00+00	2024-02-16 21:56:00+00	2024-02-16 21:56:00+00
157	157	PIX	APROVADO	183.20	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
158	158	CARTAO_CREDITO	APROVADO	225.70	2024-01-21 19:49:00+00	2024-01-21 19:49:00+00	2024-01-21 19:49:00+00
159	159	PIX	RECUSADO	117.20	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
160	160	CARTAO_DEBITO	APROVADO	133.42	2023-12-08 12:42:00+00	2023-12-08 12:42:00+00	2023-12-08 12:42:00+00
161	161	PIX	APROVADO	71.80	2023-10-26 12:37:00+00	2023-10-26 12:37:00+00	2023-10-26 12:37:00+00
162	162	CARTAO_CREDITO	APROVADO	65.80	2024-01-22 21:13:00+00	2024-01-22 21:13:00+00	2024-01-22 21:13:00+00
163	163	DINHEIRO	APROVADO	26.90	2023-10-27 22:03:00+00	2023-10-27 22:03:00+00	2023-10-27 22:03:00+00
164	164	CARTAO_CREDITO	APROVADO	127.70	2023-10-01 20:18:00+00	2023-10-01 20:18:00+00	2023-10-01 20:18:00+00
165	165	VALE_REFEICAO	APROVADO	129.70	2024-02-02 22:57:00+00	2024-02-02 22:57:00+00	2024-02-02 22:57:00+00
166	166	DINHEIRO	APROVADO	86.30	2024-02-12 21:51:00+00	2024-02-12 21:51:00+00	2024-02-12 21:51:00+00
167	167	PIX	APROVADO	17.50	2023-11-10 21:26:00+00	2023-11-10 21:26:00+00	2023-11-10 21:26:00+00
168	168	PIX	APROVADO	182.13	2023-10-12 11:28:00+00	2023-10-12 11:28:00+00	2023-10-12 11:28:00+00
169	169	CARTAO_CREDITO	RECUSADO	70.30	2024-01-22 21:53:00+00	2024-01-22 21:53:00+00	2024-01-22 21:53:00+00
170	170	CARTAO_CREDITO	APROVADO	79.30	2023-12-08 13:23:00+00	2023-12-08 13:23:00+00	2023-12-08 13:23:00+00
171	171	PIX	APROVADO	88.80	2023-10-18 19:41:00+00	2023-10-18 19:41:00+00	2023-10-18 19:41:00+00
172	172	DINHEIRO	ESTORNADO	54.40	2024-01-17 18:27:00+00	2024-01-17 18:27:00+00	2024-01-17 18:27:00+00
173	173	CARTAO_DEBITO	APROVADO	76.80	2024-01-06 12:25:00+00	2024-01-06 12:25:00+00	2024-01-06 12:25:00+00
174	174	PIX	ESTORNADO	99.80	2024-01-07 18:17:00+00	2024-01-07 18:17:00+00	2024-01-07 18:17:00+00
175	175	VALE_REFEICAO	APROVADO	195.10	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
176	176	CARTAO_DEBITO	APROVADO	56.80	2024-02-23 21:01:00+00	2024-02-23 21:01:00+00	2024-02-23 21:01:00+00
177	177	DINHEIRO	APROVADO	18.00	2023-11-01 12:47:00+00	2023-11-01 12:47:00+00	2023-11-01 12:47:00+00
178	178	CARTAO_DEBITO	APROVADO	157.10	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
179	179	PIX	APROVADO	109.80	2023-11-20 21:45:00+00	2023-11-20 21:45:00+00	2023-11-20 21:45:00+00
180	180	DINHEIRO	APROVADO	29.90	2023-11-21 22:36:00+00	2023-11-21 22:36:00+00	2023-11-21 22:36:00+00
181	181	CARTAO_DEBITO	APROVADO	108.70	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
182	182	PIX	APROVADO	29.90	2023-12-19 22:34:00+00	2023-12-19 22:34:00+00	2023-12-19 22:34:00+00
183	183	CARTAO_CREDITO	APROVADO	18.50	2024-02-05 13:55:00+00	2024-02-05 13:55:00+00	2024-02-05 13:55:00+00
184	184	CARTAO_DEBITO	APROVADO	43.40	2023-11-24 18:08:00+00	2023-11-24 18:08:00+00	2023-11-24 18:08:00+00
185	185	DINHEIRO	APROVADO	42.90	2023-12-12 23:01:00+00	2023-12-12 23:01:00+00	2023-12-12 23:01:00+00
186	186	PIX	APROVADO	24.90	2023-11-28 11:45:00+00	2023-11-28 11:45:00+00	2023-11-28 11:45:00+00
187	187	CARTAO_CREDITO	APROVADO	112.34	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00
188	188	CARTAO_CREDITO	ESTORNADO	28.30	2023-11-26 18:18:00+00	2023-11-26 18:18:00+00	2023-11-26 18:18:00+00
189	189	CARTAO_CREDITO	APROVADO	76.70	2024-01-08 23:48:00+00	2024-01-08 23:48:00+00	2024-01-08 23:48:00+00
190	190	DINHEIRO	APROVADO	49.90	2024-03-01 20:21:00+00	2024-03-01 20:21:00+00	2024-03-01 20:21:00+00
191	191	PIX	APROVADO	144.70	2023-11-22 18:53:00+00	2023-11-22 18:53:00+00	2023-11-22 18:53:00+00
192	192	CARTAO_CREDITO	APROVADO	49.40	2023-12-29 19:07:00+00	2023-12-29 19:07:00+00	2023-12-29 19:07:00+00
193	193	CARTAO_CREDITO	APROVADO	163.70	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00
194	194	CARTAO_DEBITO	APROVADO	97.80	2023-11-11 23:38:00+00	2023-11-11 23:38:00+00	2023-11-11 23:38:00+00
195	195	CARTAO_DEBITO	APROVADO	43.90	2023-12-25 12:03:00+00	2023-12-25 12:03:00+00	2023-12-25 12:03:00+00
196	196	CARTAO_CREDITO	APROVADO	70.80	2024-01-03 12:59:00+00	2024-01-03 12:59:00+00	2024-01-03 12:59:00+00
197	197	DINHEIRO	APROVADO	89.80	2023-12-02 19:31:00+00	2023-12-02 19:31:00+00	2023-12-02 19:31:00+00
198	198	CARTAO_DEBITO	APROVADO	60.90	2024-02-18 13:24:00+00	2024-02-18 13:24:00+00	2024-02-18 13:24:00+00
199	199	CARTAO_DEBITO	APROVADO	52.40	2024-01-24 13:08:00+00	2024-01-24 13:08:00+00	2024-01-24 13:08:00+00
200	200	PIX	APROVADO	38.40	2024-02-27 13:03:00+00	2024-02-27 13:03:00+00	2024-02-27 13:03:00+00
201	201	VALE_REFEICAO	APROVADO	66.90	2023-12-01 19:27:00+00	2023-12-01 19:27:00+00	2023-12-01 19:27:00+00
202	202	PIX	APROVADO	41.40	2023-11-20 23:44:00+00	2023-11-20 23:44:00+00	2023-11-20 23:44:00+00
203	203	DINHEIRO	APROVADO	157.70	2023-10-29 18:54:00+00	2023-10-29 18:54:00+00	2023-10-29 18:54:00+00
204	204	PIX	APROVADO	120.30	2024-02-21 22:26:00+00	2024-02-21 22:26:00+00	2024-02-21 22:26:00+00
205	205	PIX	APROVADO	69.30	2024-02-17 11:01:00+00	2024-02-17 11:01:00+00	2024-02-17 11:01:00+00
206	206	VALE_REFEICAO	APROVADO	235.60	2023-11-23 12:58:00+00	2023-11-23 12:58:00+00	2023-11-23 12:58:00+00
207	207	DINHEIRO	APROVADO	92.20	2023-10-07 12:39:00+00	2023-10-07 12:39:00+00	2023-10-07 12:39:00+00
208	208	DINHEIRO	APROVADO	45.16	2023-12-21 13:26:00+00	2023-12-21 13:26:00+00	2023-12-21 13:26:00+00
209	209	CARTAO_CREDITO	APROVADO	110.30	2023-10-16 11:49:00+00	2023-10-16 11:49:00+00	2023-10-16 11:49:00+00
210	210	CARTAO_CREDITO	APROVADO	33.90	2023-11-30 20:24:00+00	2023-11-30 20:24:00+00	2023-11-30 20:24:00+00
211	211	CARTAO_DEBITO	APROVADO	85.20	2024-02-11 19:29:00+00	2024-02-11 19:29:00+00	2024-02-11 19:29:00+00
212	212	VALE_REFEICAO	APROVADO	120.70	2023-10-10 18:00:00+00	2023-10-10 18:00:00+00	2023-10-10 18:00:00+00
213	213	PIX	APROVADO	52.40	2023-11-04 11:48:00+00	2023-11-04 11:48:00+00	2023-11-04 11:48:00+00
214	214	PIX	ESTORNADO	61.80	2023-10-20 19:53:00+00	2023-10-20 19:53:00+00	2023-10-20 19:53:00+00
215	215	PIX	APROVADO	39.90	2023-11-16 11:36:00+00	2023-11-16 11:36:00+00	2023-11-16 11:36:00+00
216	216	CARTAO_DEBITO	APROVADO	70.80	2023-10-27 22:38:00+00	2023-10-27 22:38:00+00	2023-10-27 22:38:00+00
217	217	DINHEIRO	APROVADO	75.70	2023-10-19 12:53:00+00	2023-10-19 12:53:00+00	2023-10-19 12:53:00+00
218	218	PIX	APROVADO	89.80	2023-10-27 21:34:00+00	2023-10-27 21:34:00+00	2023-10-27 21:34:00+00
219	219	CARTAO_CREDITO	APROVADO	141.91	2024-01-06 18:15:00+00	2024-01-06 18:15:00+00	2024-01-06 18:15:00+00
220	220	VALE_REFEICAO	APROVADO	183.30	2024-03-09 19:15:00+00	2024-03-09 19:15:00+00	2024-03-09 19:15:00+00
221	221	VALE_REFEICAO	APROVADO	135.20	2023-10-05 18:45:00+00	2023-10-05 18:45:00+00	2023-10-05 18:45:00+00
222	222	DINHEIRO	APROVADO	81.80	2023-11-06 19:15:00+00	2023-11-06 19:15:00+00	2023-11-06 19:15:00+00
223	223	PIX	APROVADO	62.30	2023-10-25 13:40:00+00	2023-10-25 13:40:00+00	2023-10-25 13:40:00+00
224	224	PIX	APROVADO	42.40	2023-10-13 13:44:00+00	2023-10-13 13:44:00+00	2023-10-13 13:44:00+00
225	225	PIX	APROVADO	63.90	2023-12-04 18:58:00+00	2023-12-04 18:58:00+00	2023-12-04 18:58:00+00
226	226	PIX	APROVADO	76.20	2024-03-06 12:36:00+00	2024-03-06 12:36:00+00	2024-03-06 12:36:00+00
227	227	PIX	RECUSADO	73.20	2024-01-12 12:46:00+00	2024-01-12 12:46:00+00	2024-01-12 12:46:00+00
228	228	CARTAO_DEBITO	APROVADO	76.40	2024-01-05 19:17:00+00	2024-01-05 19:17:00+00	2024-01-05 19:17:00+00
229	229	VALE_REFEICAO	APROVADO	97.40	2023-12-07 20:08:00+00	2023-12-07 20:08:00+00	2023-12-07 20:08:00+00
230	230	CARTAO_DEBITO	APROVADO	47.40	2023-12-12 13:19:00+00	2023-12-12 13:19:00+00	2023-12-12 13:19:00+00
231	231	CARTAO_CREDITO	APROVADO	42.90	2023-10-15 22:44:00+00	2023-10-15 22:44:00+00	2023-10-15 22:44:00+00
232	232	CARTAO_CREDITO	RECUSADO	190.10	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
233	233	DINHEIRO	APROVADO	105.70	2023-12-05 22:33:00+00	2023-12-05 22:33:00+00	2023-12-05 22:33:00+00
234	234	CARTAO_CREDITO	APROVADO	114.70	2023-12-21 22:16:00+00	2023-12-21 22:16:00+00	2023-12-21 22:16:00+00
235	235	CARTAO_CREDITO	APROVADO	92.20	2024-01-30 11:20:00+00	2024-01-30 11:20:00+00	2024-01-30 11:20:00+00
236	236	CARTAO_CREDITO	APROVADO	154.20	2023-11-30 21:21:00+00	2023-11-30 21:21:00+00	2023-11-30 21:21:00+00
237	237	VALE_REFEICAO	APROVADO	37.11	2023-11-09 22:57:00+00	2023-11-09 22:57:00+00	2023-11-09 22:57:00+00
238	238	CARTAO_CREDITO	ESTORNADO	78.80	2023-10-26 22:41:00+00	2023-10-26 22:41:00+00	2023-10-26 22:41:00+00
239	239	VALE_REFEICAO	APROVADO	152.10	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
240	240	DINHEIRO	APROVADO	68.32	2023-12-29 21:10:00+00	2023-12-29 21:10:00+00	2023-12-29 21:10:00+00
241	241	CARTAO_DEBITO	APROVADO	30.30	2023-12-22 18:32:00+00	2023-12-22 18:32:00+00	2023-12-22 18:32:00+00
242	242	CARTAO_CREDITO	APROVADO	70.30	2023-11-03 11:21:00+00	2023-11-03 11:21:00+00	2023-11-03 11:21:00+00
243	243	CARTAO_CREDITO	APROVADO	164.10	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00
244	244	VALE_REFEICAO	APROVADO	65.90	2024-01-02 11:14:00+00	2024-01-02 11:14:00+00	2024-01-02 11:14:00+00
245	245	PIX	APROVADO	110.50	2023-12-21 12:38:00+00	2023-12-21 12:38:00+00	2023-12-21 12:38:00+00
246	246	CARTAO_CREDITO	APROVADO	97.80	2024-01-14 19:11:00+00	2024-01-14 19:11:00+00	2024-01-14 19:11:00+00
247	247	PIX	APROVADO	45.40	2024-03-09 11:10:00+00	2024-03-09 11:10:00+00	2024-03-09 11:10:00+00
248	248	CARTAO_DEBITO	APROVADO	158.60	2024-02-08 22:51:00+00	2024-02-08 22:51:00+00	2024-02-08 22:51:00+00
249	249	CARTAO_DEBITO	APROVADO	95.20	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00
250	250	VALE_REFEICAO	ESTORNADO	229.00	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
251	251	CARTAO_CREDITO	APROVADO	236.10	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00
252	252	PIX	APROVADO	121.70	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
253	253	DINHEIRO	APROVADO	98.34	2023-11-25 11:47:00+00	2023-11-25 11:47:00+00	2023-11-25 11:47:00+00
254	254	CARTAO_CREDITO	APROVADO	29.40	2023-10-26 12:35:00+00	2023-10-26 12:35:00+00	2023-10-26 12:35:00+00
255	255	PIX	APROVADO	205.30	2024-02-27 11:12:00+00	2024-02-27 11:12:00+00	2024-02-27 11:12:00+00
256	256	CARTAO_CREDITO	ESTORNADO	63.80	2024-02-23 23:01:00+00	2024-02-23 23:01:00+00	2024-02-23 23:01:00+00
257	257	PIX	APROVADO	37.90	2024-01-31 19:34:00+00	2024-01-31 19:34:00+00	2024-01-31 19:34:00+00
258	258	PIX	APROVADO	73.90	2023-12-19 23:21:00+00	2023-12-19 23:21:00+00	2023-12-19 23:21:00+00
259	259	VALE_REFEICAO	APROVADO	130.70	2023-12-09 22:38:00+00	2023-12-09 22:38:00+00	2023-12-09 22:38:00+00
260	260	CARTAO_CREDITO	APROVADO	71.30	2023-10-10 22:19:00+00	2023-10-10 22:19:00+00	2023-10-10 22:19:00+00
261	261	DINHEIRO	APROVADO	13.50	2024-02-18 21:36:00+00	2024-02-18 21:36:00+00	2024-02-18 21:36:00+00
262	262	CARTAO_CREDITO	APROVADO	92.30	2023-10-25 20:50:00+00	2023-10-25 20:50:00+00	2023-10-25 20:50:00+00
263	263	CARTAO_DEBITO	APROVADO	47.40	2024-01-17 13:42:00+00	2024-01-17 13:42:00+00	2024-01-17 13:42:00+00
264	264	VALE_REFEICAO	APROVADO	72.30	2024-02-08 18:17:00+00	2024-02-08 18:17:00+00	2024-02-08 18:17:00+00
265	265	PIX	APROVADO	96.70	2023-11-26 18:15:00+00	2023-11-26 18:15:00+00	2023-11-26 18:15:00+00
266	266	PIX	APROVADO	39.40	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
267	267	DINHEIRO	APROVADO	56.40	2023-11-14 18:27:00+00	2023-11-14 18:27:00+00	2023-11-14 18:27:00+00
268	268	CARTAO_DEBITO	RECUSADO	58.90	2024-02-08 18:37:00+00	2024-02-08 18:37:00+00	2024-02-08 18:37:00+00
269	269	CARTAO_CREDITO	APROVADO	49.80	2023-10-09 12:49:00+00	2023-10-09 12:49:00+00	2023-10-09 12:49:00+00
270	270	PIX	RECUSADO	66.90	2024-01-15 21:50:00+00	2024-01-15 21:50:00+00	2024-01-15 21:50:00+00
271	271	DINHEIRO	APROVADO	35.90	2023-12-09 19:38:00+00	2023-12-09 19:38:00+00	2023-12-09 19:38:00+00
272	272	CARTAO_DEBITO	APROVADO	139.60	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
273	273	PIX	APROVADO	19.00	2024-02-06 13:09:00+00	2024-02-06 13:09:00+00	2024-02-06 13:09:00+00
274	274	CARTAO_CREDITO	APROVADO	64.80	2023-12-08 22:37:00+00	2023-12-08 22:37:00+00	2023-12-08 22:37:00+00
275	275	DINHEIRO	APROVADO	52.80	2024-01-06 23:59:00+00	2024-01-06 23:59:00+00	2024-01-06 23:59:00+00
276	276	CARTAO_DEBITO	APROVADO	171.10	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
277	277	PIX	APROVADO	31.90	2023-12-19 23:50:00+00	2023-12-19 23:50:00+00	2023-12-19 23:50:00+00
278	278	VALE_REFEICAO	APROVADO	15.50	2023-12-11 23:24:00+00	2023-12-11 23:24:00+00	2023-12-11 23:24:00+00
279	279	CARTAO_DEBITO	APROVADO	338.40	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00
280	280	VALE_REFEICAO	APROVADO	24.90	2023-12-25 19:48:00+00	2023-12-25 19:48:00+00	2023-12-25 19:48:00+00
281	281	PIX	APROVADO	20.50	2024-02-12 23:38:00+00	2024-02-12 23:38:00+00	2024-02-12 23:38:00+00
282	282	CARTAO_DEBITO	APROVADO	50.80	2024-01-14 23:15:00+00	2024-01-14 23:15:00+00	2024-01-14 23:15:00+00
283	283	CARTAO_CREDITO	APROVADO	28.50	2024-01-13 18:02:00+00	2024-01-13 18:02:00+00	2024-01-13 18:02:00+00
284	284	CARTAO_CREDITO	APROVADO	69.80	2023-10-21 12:50:00+00	2023-10-21 12:50:00+00	2023-10-21 12:50:00+00
285	285	PIX	APROVADO	100.20	2024-02-23 23:50:00+00	2024-02-23 23:50:00+00	2024-02-23 23:50:00+00
286	286	PIX	APROVADO	200.80	2023-10-27 22:58:00+00	2023-10-27 22:58:00+00	2023-10-27 22:58:00+00
287	287	CARTAO_CREDITO	APROVADO	20.50	2024-02-01 21:44:00+00	2024-02-01 21:44:00+00	2024-02-01 21:44:00+00
288	288	CARTAO_DEBITO	APROVADO	154.50	2023-11-19 12:57:00+00	2023-11-19 12:57:00+00	2023-11-19 12:57:00+00
289	289	CARTAO_DEBITO	APROVADO	84.20	2023-12-04 21:02:00+00	2023-12-04 21:02:00+00	2023-12-04 21:02:00+00
290	290	PIX	APROVADO	104.30	2024-02-01 11:46:00+00	2024-02-01 11:46:00+00	2024-02-01 11:46:00+00
291	291	CARTAO_CREDITO	APROVADO	79.80	2024-02-04 23:26:00+00	2024-02-04 23:26:00+00	2024-02-04 23:26:00+00
292	292	CARTAO_CREDITO	APROVADO	120.80	2024-02-07 19:55:00+00	2024-02-07 19:55:00+00	2024-02-07 19:55:00+00
293	293	CARTAO_CREDITO	APROVADO	234.00	2024-01-19 12:06:00+00	2024-01-19 12:06:00+00	2024-01-19 12:06:00+00
294	294	DINHEIRO	APROVADO	37.90	2024-01-28 20:55:00+00	2024-01-28 20:55:00+00	2024-01-28 20:55:00+00
295	295	DINHEIRO	APROVADO	87.70	2023-12-28 11:41:00+00	2023-12-28 11:41:00+00	2023-12-28 11:41:00+00
296	296	CARTAO_CREDITO	RECUSADO	41.40	2023-11-29 13:20:00+00	2023-11-29 13:20:00+00	2023-11-29 13:20:00+00
297	297	CARTAO_CREDITO	RECUSADO	102.60	2024-02-19 20:39:00+00	2024-02-19 20:39:00+00	2024-02-19 20:39:00+00
298	298	VALE_REFEICAO	APROVADO	52.30	2024-03-02 12:31:00+00	2024-03-02 12:31:00+00	2024-03-02 12:31:00+00
299	299	DINHEIRO	APROVADO	105.30	2024-02-21 11:30:00+00	2024-02-21 11:30:00+00	2024-02-21 11:30:00+00
300	300	DINHEIRO	APROVADO	111.20	2024-03-02 18:21:00+00	2024-03-02 18:21:00+00	2024-03-02 18:21:00+00
301	301	CARTAO_CREDITO	APROVADO	97.20	2023-11-13 12:40:00+00	2023-11-13 12:40:00+00	2023-11-13 12:40:00+00
302	302	CARTAO_CREDITO	APROVADO	61.30	2023-10-05 20:22:00+00	2023-10-05 20:22:00+00	2023-10-05 20:22:00+00
303	303	CARTAO_CREDITO	APROVADO	183.50	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
304	304	PIX	APROVADO	111.30	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00
305	305	CARTAO_CREDITO	APROVADO	96.30	2023-11-01 12:11:00+00	2023-11-01 12:11:00+00	2023-11-01 12:11:00+00
306	306	PIX	APROVADO	117.20	2024-02-23 19:03:00+00	2024-02-23 19:03:00+00	2024-02-23 19:03:00+00
307	307	DINHEIRO	APROVADO	185.70	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00
308	308	DINHEIRO	APROVADO	15.50	2024-02-03 12:18:00+00	2024-02-03 12:18:00+00	2024-02-03 12:18:00+00
309	309	CARTAO_CREDITO	RECUSADO	86.80	2024-02-25 11:52:00+00	2024-02-25 11:52:00+00	2024-02-25 11:52:00+00
310	310	DINHEIRO	APROVADO	209.30	2023-11-16 19:40:00+00	2023-11-16 19:40:00+00	2023-11-16 19:40:00+00
311	311	CARTAO_CREDITO	APROVADO	21.00	2023-11-01 22:16:00+00	2023-11-01 22:16:00+00	2023-11-01 22:16:00+00
312	312	CARTAO_CREDITO	APROVADO	177.73	2024-02-19 11:13:00+00	2024-02-19 11:13:00+00	2024-02-19 11:13:00+00
313	313	CARTAO_CREDITO	APROVADO	70.30	2023-11-26 13:12:00+00	2023-11-26 13:12:00+00	2023-11-26 13:12:00+00
314	314	PIX	RECUSADO	75.80	2023-11-04 13:35:00+00	2023-11-04 13:35:00+00	2023-11-04 13:35:00+00
315	315	PIX	APROVADO	129.70	2023-11-14 20:14:00+00	2023-11-14 20:14:00+00	2023-11-14 20:14:00+00
316	316	PIX	ESTORNADO	63.40	2023-10-30 22:01:00+00	2023-10-30 22:01:00+00	2023-10-30 22:01:00+00
317	317	VALE_REFEICAO	APROVADO	97.80	2024-03-06 21:14:00+00	2024-03-06 21:14:00+00	2024-03-06 21:14:00+00
318	318	PIX	APROVADO	70.30	2024-02-05 11:16:00+00	2024-02-05 11:16:00+00	2024-02-05 11:16:00+00
319	319	CARTAO_CREDITO	APROVADO	186.80	2023-11-02 22:55:00+00	2023-11-02 22:55:00+00	2023-11-02 22:55:00+00
320	320	VALE_REFEICAO	APROVADO	122.80	2024-01-06 18:05:00+00	2024-01-06 18:05:00+00	2024-01-06 18:05:00+00
321	321	CARTAO_CREDITO	APROVADO	168.50	2023-10-23 22:19:00+00	2023-10-23 22:19:00+00	2023-10-23 22:19:00+00
322	322	DINHEIRO	APROVADO	162.90	2023-10-03 23:22:00+00	2023-10-03 23:22:00+00	2023-10-03 23:22:00+00
323	323	CARTAO_DEBITO	APROVADO	145.00	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00
324	324	DINHEIRO	ESTORNADO	23.00	2024-02-01 11:35:00+00	2024-02-01 11:35:00+00	2024-02-01 11:35:00+00
325	325	PIX	APROVADO	37.80	2024-02-20 18:31:00+00	2024-02-20 18:31:00+00	2024-02-20 18:31:00+00
326	326	DINHEIRO	APROVADO	28.40	2023-10-02 19:51:00+00	2023-10-02 19:51:00+00	2023-10-02 19:51:00+00
327	327	PIX	ESTORNADO	44.90	2024-03-08 19:27:00+00	2024-03-08 19:27:00+00	2024-03-08 19:27:00+00
328	328	CARTAO_CREDITO	APROVADO	122.58	2024-01-25 18:41:00+00	2024-01-25 18:41:00+00	2024-01-25 18:41:00+00
329	329	VALE_REFEICAO	APROVADO	106.30	2023-11-14 21:04:00+00	2023-11-14 21:04:00+00	2023-11-14 21:04:00+00
330	330	PIX	APROVADO	205.20	2023-12-19 23:47:00+00	2023-12-19 23:47:00+00	2023-12-19 23:47:00+00
331	331	CARTAO_CREDITO	APROVADO	156.90	2024-02-20 11:38:00+00	2024-02-20 11:38:00+00	2024-02-20 11:38:00+00
332	332	VALE_REFEICAO	APROVADO	41.90	2023-12-23 22:55:00+00	2023-12-23 22:55:00+00	2023-12-23 22:55:00+00
333	333	CARTAO_CREDITO	APROVADO	75.43	2023-12-31 21:13:00+00	2023-12-31 21:13:00+00	2023-12-31 21:13:00+00
334	334	DINHEIRO	APROVADO	58.80	2023-12-14 11:05:00+00	2023-12-14 11:05:00+00	2023-12-14 11:05:00+00
335	335	CARTAO_CREDITO	APROVADO	78.90	2024-02-07 20:24:00+00	2024-02-07 20:24:00+00	2024-02-07 20:24:00+00
336	336	CARTAO_CREDITO	APROVADO	16.50	2024-02-06 18:20:00+00	2024-02-06 18:20:00+00	2024-02-06 18:20:00+00
337	337	VALE_REFEICAO	APROVADO	37.90	2023-10-08 19:23:00+00	2023-10-08 19:23:00+00	2023-10-08 19:23:00+00
338	338	PIX	ESTORNADO	57.80	2023-10-27 18:23:00+00	2023-10-27 18:23:00+00	2023-10-27 18:23:00+00
339	339	CARTAO_CREDITO	APROVADO	17.40	2024-01-17 22:35:00+00	2024-01-17 22:35:00+00	2024-01-17 22:35:00+00
340	340	CARTAO_CREDITO	APROVADO	71.80	2024-01-17 20:37:00+00	2024-01-17 20:37:00+00	2024-01-17 20:37:00+00
341	341	DINHEIRO	APROVADO	104.80	2023-11-12 18:35:00+00	2023-11-12 18:35:00+00	2023-11-12 18:35:00+00
342	342	PIX	APROVADO	49.30	2024-02-11 19:33:00+00	2024-02-11 19:33:00+00	2024-02-11 19:33:00+00
343	343	PIX	APROVADO	65.30	2023-10-05 20:42:00+00	2023-10-05 20:42:00+00	2023-10-05 20:42:00+00
344	344	CARTAO_CREDITO	APROVADO	40.40	2024-01-09 11:16:00+00	2024-01-09 11:16:00+00	2024-01-09 11:16:00+00
345	345	CARTAO_CREDITO	RECUSADO	97.70	2023-10-16 11:56:00+00	2023-10-16 11:56:00+00	2023-10-16 11:56:00+00
346	346	DINHEIRO	APROVADO	77.30	2024-01-28 18:01:00+00	2024-01-28 18:01:00+00	2024-01-28 18:01:00+00
347	347	PIX	APROVADO	158.60	2024-03-02 11:58:00+00	2024-03-02 11:58:00+00	2024-03-02 11:58:00+00
348	348	CARTAO_CREDITO	APROVADO	68.30	2024-01-19 23:39:00+00	2024-01-19 23:39:00+00	2024-01-19 23:39:00+00
349	349	PIX	APROVADO	29.90	2024-01-06 21:05:00+00	2024-01-06 21:05:00+00	2024-01-06 21:05:00+00
350	350	VALE_REFEICAO	APROVADO	97.20	2023-10-21 21:50:00+00	2023-10-21 21:50:00+00	2023-10-21 21:50:00+00
351	351	PIX	ESTORNADO	117.60	2023-10-30 13:42:00+00	2023-10-30 13:42:00+00	2023-10-30 13:42:00+00
352	352	PIX	APROVADO	50.40	2023-11-06 13:30:00+00	2023-11-06 13:30:00+00	2023-11-06 13:30:00+00
353	353	PIX	APROVADO	44.40	2023-12-17 19:50:00+00	2023-12-17 19:50:00+00	2023-12-17 19:50:00+00
354	354	PIX	APROVADO	70.80	2024-01-10 22:55:00+00	2024-01-10 22:55:00+00	2024-01-10 22:55:00+00
355	355	PIX	APROVADO	66.80	2023-12-21 18:02:00+00	2023-12-21 18:02:00+00	2023-12-21 18:02:00+00
356	356	CARTAO_CREDITO	APROVADO	165.90	2023-10-11 23:26:00+00	2023-10-11 23:26:00+00	2023-10-11 23:26:00+00
357	357	DINHEIRO	APROVADO	304.60	2023-11-28 19:19:00+00	2023-11-28 19:19:00+00	2023-11-28 19:19:00+00
358	358	PIX	RECUSADO	205.60	2024-03-02 11:28:00+00	2024-03-02 11:28:00+00	2024-03-02 11:28:00+00
359	359	CARTAO_CREDITO	APROVADO	29.40	2024-02-06 21:51:00+00	2024-02-06 21:51:00+00	2024-02-06 21:51:00+00
360	360	PIX	APROVADO	33.90	2023-11-30 18:09:00+00	2023-11-30 18:09:00+00	2023-11-30 18:09:00+00
361	361	PIX	ESTORNADO	61.80	2023-12-28 19:52:00+00	2023-12-28 19:52:00+00	2023-12-28 19:52:00+00
362	362	DINHEIRO	ESTORNADO	64.80	2024-01-15 19:31:00+00	2024-01-15 19:31:00+00	2024-01-15 19:31:00+00
363	363	DINHEIRO	ESTORNADO	51.40	2023-10-02 11:43:00+00	2023-10-02 11:43:00+00	2023-10-02 11:43:00+00
364	364	CARTAO_CREDITO	APROVADO	90.20	2023-11-06 21:27:00+00	2023-11-06 21:27:00+00	2023-11-06 21:27:00+00
365	365	PIX	APROVADO	118.30	2024-01-04 19:39:00+00	2024-01-04 19:39:00+00	2024-01-04 19:39:00+00
366	366	PIX	APROVADO	97.30	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00
367	367	PIX	APROVADO	104.20	2024-01-08 13:10:00+00	2024-01-08 13:10:00+00	2024-01-08 13:10:00+00
368	368	PIX	APROVADO	158.10	2023-11-18 12:37:00+00	2023-11-18 12:37:00+00	2023-11-18 12:37:00+00
369	369	CARTAO_CREDITO	APROVADO	34.90	2023-10-27 23:26:00+00	2023-10-27 23:26:00+00	2023-10-27 23:26:00+00
370	370	CARTAO_CREDITO	APROVADO	87.20	2024-03-07 20:51:00+00	2024-03-07 20:51:00+00	2024-03-07 20:51:00+00
371	371	DINHEIRO	APROVADO	125.20	2023-11-10 21:33:00+00	2023-11-10 21:33:00+00	2023-11-10 21:33:00+00
372	372	PIX	APROVADO	37.90	2023-10-27 18:15:00+00	2023-10-27 18:15:00+00	2023-10-27 18:15:00+00
373	373	PIX	APROVADO	257.50	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00
374	374	CARTAO_CREDITO	APROVADO	56.69	2023-12-18 23:53:00+00	2023-12-18 23:53:00+00	2023-12-18 23:53:00+00
375	375	PIX	APROVADO	31.40	2024-03-07 20:11:00+00	2024-03-07 20:11:00+00	2024-03-07 20:11:00+00
376	376	CARTAO_CREDITO	APROVADO	196.10	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
377	377	CARTAO_DEBITO	APROVADO	54.40	2023-10-04 11:20:00+00	2023-10-04 11:20:00+00	2023-10-04 11:20:00+00
378	378	PIX	APROVADO	100.20	2024-02-05 13:31:00+00	2024-02-05 13:31:00+00	2024-02-05 13:31:00+00
379	379	CARTAO_CREDITO	APROVADO	93.80	2023-12-22 22:26:00+00	2023-12-22 22:26:00+00	2023-12-22 22:26:00+00
380	380	DINHEIRO	APROVADO	91.20	2024-03-02 21:04:00+00	2024-03-02 21:04:00+00	2024-03-02 21:04:00+00
381	381	PIX	APROVADO	50.40	2024-02-22 19:32:00+00	2024-02-22 19:32:00+00	2024-02-22 19:32:00+00
382	382	PIX	APROVADO	43.40	2023-12-06 23:17:00+00	2023-12-06 23:17:00+00	2023-12-06 23:17:00+00
383	383	CARTAO_DEBITO	APROVADO	74.20	2024-01-22 21:18:00+00	2024-01-22 21:18:00+00	2024-01-22 21:18:00+00
384	384	CARTAO_CREDITO	APROVADO	109.30	2023-10-23 20:49:00+00	2023-10-23 20:49:00+00	2023-10-23 20:49:00+00
385	385	PIX	APROVADO	147.10	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
386	386	PIX	APROVADO	94.30	2023-12-24 19:05:00+00	2023-12-24 19:05:00+00	2023-12-24 19:05:00+00
387	387	PIX	APROVADO	202.60	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
388	388	CARTAO_DEBITO	RECUSADO	64.80	2023-11-26 23:47:00+00	2023-11-26 23:47:00+00	2023-11-26 23:47:00+00
389	389	CARTAO_CREDITO	APROVADO	44.80	2024-01-21 23:12:00+00	2024-01-21 23:12:00+00	2024-01-21 23:12:00+00
390	390	PIX	RECUSADO	156.90	2023-12-26 20:28:00+00	2023-12-26 20:28:00+00	2023-12-26 20:28:00+00
391	391	PIX	APROVADO	72.30	2023-11-10 23:21:00+00	2023-11-10 23:21:00+00	2023-11-10 23:21:00+00
392	392	VALE_REFEICAO	APROVADO	17.50	2023-11-07 21:00:00+00	2023-11-07 21:00:00+00	2023-11-07 21:00:00+00
393	393	CARTAO_CREDITO	APROVADO	34.40	2024-03-04 13:08:00+00	2024-03-04 13:08:00+00	2024-03-04 13:08:00+00
394	394	CARTAO_CREDITO	APROVADO	95.80	2023-12-14 22:41:00+00	2023-12-14 22:41:00+00	2023-12-14 22:41:00+00
395	395	CARTAO_CREDITO	APROVADO	102.30	2024-01-13 11:08:00+00	2024-01-13 11:08:00+00	2024-01-13 11:08:00+00
396	396	CARTAO_CREDITO	APROVADO	12.00	2023-10-27 11:36:00+00	2023-10-27 11:36:00+00	2023-10-27 11:36:00+00
397	397	CARTAO_CREDITO	APROVADO	111.30	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
398	398	DINHEIRO	APROVADO	58.90	2024-01-25 19:03:00+00	2024-01-25 19:03:00+00	2024-01-25 19:03:00+00
399	399	CARTAO_CREDITO	APROVADO	75.80	2024-02-17 23:12:00+00	2024-02-17 23:12:00+00	2024-02-17 23:12:00+00
400	400	CARTAO_CREDITO	APROVADO	156.40	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00
401	401	CARTAO_CREDITO	APROVADO	114.53	2023-10-14 22:57:00+00	2023-10-14 22:57:00+00	2023-10-14 22:57:00+00
402	402	PIX	APROVADO	50.90	2023-10-15 11:28:00+00	2023-10-15 11:28:00+00	2023-10-15 11:28:00+00
403	403	CARTAO_CREDITO	ESTORNADO	220.70	2024-02-12 22:57:00+00	2024-02-12 22:57:00+00	2024-02-12 22:57:00+00
404	404	CARTAO_DEBITO	APROVADO	73.90	2024-02-14 13:40:00+00	2024-02-14 13:40:00+00	2024-02-14 13:40:00+00
405	405	DINHEIRO	APROVADO	32.80	2023-12-11 12:01:00+00	2023-12-11 12:01:00+00	2023-12-11 12:01:00+00
406	406	CARTAO_CREDITO	APROVADO	54.40	2024-02-21 23:20:00+00	2024-02-21 23:20:00+00	2024-02-21 23:20:00+00
407	407	VALE_REFEICAO	APROVADO	30.30	2023-10-13 21:07:00+00	2023-10-13 21:07:00+00	2023-10-13 21:07:00+00
408	408	PIX	ESTORNADO	60.90	2023-11-10 21:02:00+00	2023-11-10 21:02:00+00	2023-11-10 21:02:00+00
409	409	PIX	APROVADO	213.80	2023-10-10 23:38:00+00	2023-10-10 23:38:00+00	2023-10-10 23:38:00+00
410	410	PIX	APROVADO	95.70	2024-02-11 21:56:00+00	2024-02-11 21:56:00+00	2024-02-11 21:56:00+00
411	411	CARTAO_DEBITO	APROVADO	52.80	2023-10-07 13:21:00+00	2023-10-07 13:21:00+00	2023-10-07 13:21:00+00
412	412	VALE_REFEICAO	APROVADO	121.70	2023-12-12 21:19:00+00	2023-12-12 21:19:00+00	2023-12-12 21:19:00+00
413	413	CARTAO_CREDITO	APROVADO	80.20	2023-11-08 21:54:00+00	2023-11-08 21:54:00+00	2023-11-08 21:54:00+00
414	414	PIX	APROVADO	17.50	2024-03-05 19:12:00+00	2024-03-05 19:12:00+00	2024-03-05 19:12:00+00
415	415	CARTAO_CREDITO	APROVADO	37.40	2023-10-19 11:58:00+00	2023-10-19 11:58:00+00	2023-10-19 11:58:00+00
416	416	CARTAO_CREDITO	APROVADO	40.90	2023-11-19 20:59:00+00	2023-11-19 20:59:00+00	2023-11-19 20:59:00+00
417	417	PIX	APROVADO	36.40	2023-12-14 18:23:00+00	2023-12-14 18:23:00+00	2023-12-14 18:23:00+00
418	418	CARTAO_CREDITO	APROVADO	95.30	2024-01-23 23:00:00+00	2024-01-23 23:00:00+00	2024-01-23 23:00:00+00
419	419	PIX	APROVADO	46.44	2024-01-17 18:09:00+00	2024-01-17 18:09:00+00	2024-01-17 18:09:00+00
420	420	CARTAO_CREDITO	APROVADO	94.80	2023-12-19 19:56:00+00	2023-12-19 19:56:00+00	2023-12-19 19:56:00+00
421	421	DINHEIRO	APROVADO	56.80	2023-11-06 12:54:00+00	2023-11-06 12:54:00+00	2023-11-06 12:54:00+00
422	422	CARTAO_DEBITO	ESTORNADO	140.10	2023-11-09 19:19:00+00	2023-11-09 19:19:00+00	2023-11-09 19:19:00+00
423	423	PIX	APROVADO	35.90	2023-12-05 23:23:00+00	2023-12-05 23:23:00+00	2023-12-05 23:23:00+00
424	424	PIX	APROVADO	36.40	2023-11-29 12:33:00+00	2023-11-29 12:33:00+00	2023-11-29 12:33:00+00
425	425	VALE_REFEICAO	APROVADO	38.90	2023-11-19 22:52:00+00	2023-11-19 22:52:00+00	2023-11-19 22:52:00+00
426	426	PIX	APROVADO	31.90	2023-10-28 20:38:00+00	2023-10-28 20:38:00+00	2023-10-28 20:38:00+00
427	427	CARTAO_CREDITO	APROVADO	274.50	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00
428	428	CARTAO_CREDITO	APROVADO	56.30	2024-01-26 21:49:00+00	2024-01-26 21:49:00+00	2024-01-26 21:49:00+00
429	429	PIX	RECUSADO	77.30	2024-01-06 23:03:00+00	2024-01-06 23:03:00+00	2024-01-06 23:03:00+00
430	430	CARTAO_CREDITO	ESTORNADO	122.20	2023-12-23 18:29:00+00	2023-12-23 18:29:00+00	2023-12-23 18:29:00+00
431	431	PIX	APROVADO	59.30	2023-11-03 12:08:00+00	2023-11-03 12:08:00+00	2023-11-03 12:08:00+00
432	432	CARTAO_CREDITO	APROVADO	113.40	2023-11-03 20:26:00+00	2023-11-03 20:26:00+00	2023-11-03 20:26:00+00
433	433	CARTAO_CREDITO	APROVADO	74.40	2024-01-11 18:16:00+00	2024-01-11 18:16:00+00	2024-01-11 18:16:00+00
434	434	PIX	APROVADO	22.90	2024-01-03 18:11:00+00	2024-01-03 18:11:00+00	2024-01-03 18:11:00+00
435	435	DINHEIRO	APROVADO	71.80	2023-11-09 23:11:00+00	2023-11-09 23:11:00+00	2023-11-09 23:11:00+00
436	436	CARTAO_DEBITO	APROVADO	59.80	2024-01-27 19:05:00+00	2024-01-27 19:05:00+00	2024-01-27 19:05:00+00
437	437	DINHEIRO	APROVADO	10.50	2024-03-09 13:52:00+00	2024-03-09 13:52:00+00	2024-03-09 13:52:00+00
438	438	PIX	APROVADO	142.46	2024-03-04 18:08:00+00	2024-03-04 18:08:00+00	2024-03-04 18:08:00+00
439	439	PIX	APROVADO	69.90	2023-10-31 23:45:00+00	2023-10-31 23:45:00+00	2023-10-31 23:45:00+00
440	440	PIX	APROVADO	96.20	2023-12-28 11:46:00+00	2023-12-28 11:46:00+00	2023-12-28 11:46:00+00
441	441	CARTAO_CREDITO	APROVADO	43.90	2023-12-31 11:05:00+00	2023-12-31 11:05:00+00	2023-12-31 11:05:00+00
442	442	PIX	APROVADO	23.50	2023-11-23 20:40:00+00	2023-11-23 20:40:00+00	2023-11-23 20:40:00+00
443	443	CARTAO_CREDITO	APROVADO	17.50	2024-01-21 13:33:00+00	2024-01-21 13:33:00+00	2024-01-21 13:33:00+00
444	444	VALE_REFEICAO	APROVADO	122.02	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
445	445	DINHEIRO	APROVADO	139.80	2024-01-06 23:05:00+00	2024-01-06 23:05:00+00	2024-01-06 23:05:00+00
446	446	PIX	APROVADO	19.50	2024-02-25 18:10:00+00	2024-02-25 18:10:00+00	2024-02-25 18:10:00+00
447	447	CARTAO_DEBITO	APROVADO	29.40	2023-12-29 20:38:00+00	2023-12-29 20:38:00+00	2023-12-29 20:38:00+00
448	448	PIX	APROVADO	183.60	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00
449	449	DINHEIRO	APROVADO	15.00	2023-12-15 19:05:00+00	2023-12-15 19:05:00+00	2023-12-15 19:05:00+00
450	450	CARTAO_CREDITO	APROVADO	93.40	2023-11-30 20:21:00+00	2023-11-30 20:21:00+00	2023-11-30 20:21:00+00
451	451	PIX	APROVADO	71.40	2024-01-12 22:34:00+00	2024-01-12 22:34:00+00	2024-01-12 22:34:00+00
452	452	PIX	APROVADO	31.90	2024-02-01 22:27:00+00	2024-02-01 22:27:00+00	2024-02-01 22:27:00+00
453	453	DINHEIRO	APROVADO	103.80	2024-03-07 12:57:00+00	2024-03-07 12:57:00+00	2024-03-07 12:57:00+00
454	454	CARTAO_CREDITO	APROVADO	201.30	2024-03-06 21:50:00+00	2024-03-06 21:50:00+00	2024-03-06 21:50:00+00
455	455	PIX	APROVADO	59.30	2023-11-09 13:01:00+00	2023-11-09 13:01:00+00	2023-11-09 13:01:00+00
456	456	CARTAO_CREDITO	APROVADO	45.30	2024-01-04 22:38:00+00	2024-01-04 22:38:00+00	2024-01-04 22:38:00+00
457	457	CARTAO_DEBITO	APROVADO	95.80	2024-02-17 22:51:00+00	2024-02-17 22:51:00+00	2024-02-17 22:51:00+00
458	458	DINHEIRO	APROVADO	47.72	2024-02-26 11:49:00+00	2024-02-26 11:49:00+00	2024-02-26 11:49:00+00
459	459	PIX	APROVADO	162.00	2023-11-30 23:13:00+00	2023-11-30 23:13:00+00	2023-11-30 23:13:00+00
460	460	CARTAO_CREDITO	ESTORNADO	113.30	2024-02-04 12:27:00+00	2024-02-04 12:27:00+00	2024-02-04 12:27:00+00
461	461	CARTAO_CREDITO	APROVADO	93.20	2023-10-25 21:29:00+00	2023-10-25 21:29:00+00	2023-10-25 21:29:00+00
462	462	CARTAO_CREDITO	ESTORNADO	160.40	2024-01-29 11:45:00+00	2024-01-29 11:45:00+00	2024-01-29 11:45:00+00
463	463	DINHEIRO	APROVADO	109.30	2024-02-12 23:43:00+00	2024-02-12 23:43:00+00	2024-02-12 23:43:00+00
464	464	CARTAO_CREDITO	APROVADO	121.70	2023-12-11 20:48:00+00	2023-12-11 20:48:00+00	2023-12-11 20:48:00+00
465	465	VALE_REFEICAO	APROVADO	108.30	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00
466	466	CARTAO_CREDITO	APROVADO	33.90	2023-10-25 18:54:00+00	2023-10-25 18:54:00+00	2023-10-25 18:54:00+00
467	467	VALE_REFEICAO	APROVADO	80.20	2024-02-17 18:10:00+00	2024-02-17 18:10:00+00	2024-02-17 18:10:00+00
468	468	CARTAO_CREDITO	APROVADO	46.90	2024-01-21 19:10:00+00	2024-01-21 19:10:00+00	2024-01-21 19:10:00+00
469	469	VALE_REFEICAO	APROVADO	133.60	2024-01-01 18:54:00+00	2024-01-01 18:54:00+00	2024-01-01 18:54:00+00
470	470	VALE_REFEICAO	ESTORNADO	34.90	2024-01-19 13:40:00+00	2024-01-19 13:40:00+00	2024-01-19 13:40:00+00
471	471	CARTAO_CREDITO	APROVADO	120.70	2023-10-30 12:38:00+00	2023-10-30 12:38:00+00	2023-10-30 12:38:00+00
472	472	PIX	APROVADO	27.40	2024-01-06 23:22:00+00	2024-01-06 23:22:00+00	2024-01-06 23:22:00+00
473	473	PIX	APROVADO	174.38	2024-03-06 11:23:00+00	2024-03-06 11:23:00+00	2024-03-06 11:23:00+00
474	474	PIX	RECUSADO	65.90	2024-01-13 20:33:00+00	2024-01-13 20:33:00+00	2024-01-13 20:33:00+00
475	475	CARTAO_CREDITO	APROVADO	194.10	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
476	476	PIX	APROVADO	92.70	2023-10-24 19:27:00+00	2023-10-24 19:27:00+00	2023-10-24 19:27:00+00
477	477	VALE_REFEICAO	APROVADO	106.30	2023-12-13 22:51:00+00	2023-12-13 22:51:00+00	2023-12-13 22:51:00+00
478	478	PIX	APROVADO	16.50	2024-01-04 23:36:00+00	2024-01-04 23:36:00+00	2024-01-04 23:36:00+00
479	479	VALE_REFEICAO	APROVADO	60.40	2023-12-11 12:27:00+00	2023-12-11 12:27:00+00	2023-12-11 12:27:00+00
480	480	PIX	APROVADO	117.80	2023-11-29 21:41:00+00	2023-11-29 21:41:00+00	2023-11-29 21:41:00+00
\.


--
-- Data for Name: pedidos; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.pedidos (id, cliente_id, endereco_id, cupom_id, data_pedido, status, subtotal, taxa_entrega, valor_desconto, valor_total, observacoes, created_at, updated_at) FROM stdin;
1	51	51	\N	2023-12-30 18:08:00+00	ENTREGUE	65.30	13.00	0.00	78.30	Ponto da carne bem passado	2023-12-30 18:08:00+00	2023-12-30 18:08:00+00
2	21	21	\N	2023-12-10 18:47:00+00	ENTREGUE	62.80	7.50	0.00	70.30	\N	2023-12-10 18:47:00+00	2023-12-10 18:47:00+00
3	37	37	3	2023-10-14 23:51:00+00	ENTREGUE	168.80	7.50	15.00	161.30	Sem cebola no burger por favor	2023-10-14 23:51:00+00	2023-10-14 23:51:00+00
4	78	78	\N	2024-02-20 20:31:00+00	ENTREGUE	7.50	13.00	0.00	20.50	Por favor enviar bastante guardanapo	2024-02-20 20:31:00+00	2024-02-20 20:31:00+00
5	22	91	\N	2023-11-04 19:46:00+00	ENTREGUE	26.40	6.00	0.00	32.40	Ponto da carne ao ponto para mal	2023-11-04 19:46:00+00	2023-11-04 19:46:00+00
6	20	20	\N	2024-02-07 22:11:00+00	SAIU_PARA_ENTREGA	54.30	8.50	0.00	62.80	Ponto da carne ao ponto para mal	2024-02-07 22:11:00+00	2024-02-07 22:11:00+00
7	77	77	2	2024-03-04 11:48:00+00	EM_PREPARO	118.10	11.00	11.81	117.29	Ponto da carne bem passado	2024-03-04 11:48:00+00	2024-03-04 11:48:00+00
8	62	111	\N	2024-02-07 11:57:00+00	CANCELADO	172.80	8.00	0.00	180.80	Por favor enviar bastante guardanapo	2024-02-07 11:57:00+00	2024-02-07 11:57:00+00
9	74	74	\N	2023-11-21 18:03:00+00	ENTREGUE	196.80	12.00	0.00	208.80	Ponto da carne ao ponto para mal	2023-11-21 18:03:00+00	2023-11-21 18:03:00+00
10	29	29	\N	2023-12-13 20:55:00+00	ENTREGUE	69.80	10.00	0.00	79.80	Deixar na portaria com o porteiro	2023-12-13 20:55:00+00	2023-12-13 20:55:00+00
11	40	100	\N	2023-10-09 11:06:00+00	ENTREGUE	51.80	10.00	0.00	61.80	Tocar a campainha quando chegar	2023-10-09 11:06:00+00	2023-10-09 11:06:00+00
12	64	112	\N	2023-12-30 12:31:00+00	ENTREGUE	89.80	11.50	0.00	101.30	Tocar a campainha quando chegar	2023-12-30 12:31:00+00	2023-12-30 12:31:00+00
13	79	79	\N	2024-01-11 12:59:00+00	ENTREGUE	197.10	13.00	0.00	210.10	\N	2024-01-11 12:59:00+00	2024-01-11 12:59:00+00
14	49	49	\N	2023-11-24 11:04:00+00	ENTREGUE	62.90	6.00	0.00	68.90	Ponto da carne bem passado	2023-11-24 11:04:00+00	2023-11-24 11:04:00+00
15	1	1	\N	2023-10-19 12:49:00+00	ENTREGUE	45.40	10.50	0.00	55.90	\N	2023-10-19 12:49:00+00	2023-10-19 12:49:00+00
16	14	14	\N	2024-01-22 12:50:00+00	ENTREGUE	100.30	10.50	0.00	110.80	\N	2024-01-22 12:50:00+00	2024-01-22 12:50:00+00
17	57	57	\N	2023-11-08 11:51:00+00	ENTREGUE	33.90	14.00	0.00	47.90	Ponto da carne bem passado	2023-11-08 11:51:00+00	2023-11-08 11:51:00+00
18	70	115	\N	2023-12-02 13:05:00+00	EM_PREPARO	29.40	11.00	0.00	40.40	Tocar a campainha quando chegar	2023-12-02 13:05:00+00	2023-12-02 13:05:00+00
19	63	63	\N	2023-12-22 13:07:00+00	ENTREGUE	312.40	10.00	0.00	322.40	Ponto da carne ao ponto para mal	2023-12-22 13:07:00+00	2023-12-22 13:07:00+00
20	24	92	\N	2023-11-24 20:12:00+00	ENTREGUE	96.70	6.00	0.00	102.70	Ponto da carne bem passado	2023-11-24 20:12:00+00	2023-11-24 20:12:00+00
21	1	1	\N	2023-11-20 18:27:00+00	ENTREGUE	27.40	10.50	0.00	37.90	Por favor enviar bastante guardanapo	2023-11-20 18:27:00+00	2023-11-20 18:27:00+00
22	12	12	\N	2023-12-19 11:37:00+00	ENTREGUE	96.30	10.50	0.00	106.80	Ponto da carne ao ponto para mal	2023-12-19 11:37:00+00	2023-12-19 11:37:00+00
23	63	63	\N	2023-10-21 12:05:00+00	ENTREGUE	128.70	10.00	0.00	138.70	\N	2023-10-21 12:05:00+00	2023-10-21 12:05:00+00
24	20	20	\N	2024-02-28 20:44:00+00	EM_PREPARO	84.80	8.50	0.00	93.30	\N	2024-02-28 20:44:00+00	2024-02-28 20:44:00+00
25	3	3	\N	2023-12-26 19:40:00+00	ENTREGUE	73.80	13.00	0.00	86.80	Tocar a campainha quando chegar	2023-12-26 19:40:00+00	2023-12-26 19:40:00+00
26	45	45	\N	2023-10-28 19:17:00+00	ENTREGUE	55.80	8.50	0.00	64.30	Por favor enviar bastante guardanapo	2023-10-28 19:17:00+00	2023-10-28 19:17:00+00
27	16	88	\N	2023-11-06 23:02:00+00	ENTREGUE	24.90	10.00	0.00	34.90	Por favor enviar bastante guardanapo	2023-11-06 23:02:00+00	2023-11-06 23:02:00+00
28	21	21	\N	2024-02-14 22:44:00+00	ENTREGUE	110.20	7.50	0.00	117.70	Por favor enviar bastante guardanapo	2024-02-14 22:44:00+00	2024-02-14 22:44:00+00
29	79	79	\N	2023-12-08 20:59:00+00	CANCELADO	4.50	13.00	0.00	17.50	Ponto da carne ao ponto para mal	2023-12-08 20:59:00+00	2023-12-08 20:59:00+00
30	1	1	\N	2023-11-07 12:43:00+00	ENTREGUE	218.00	10.50	0.00	228.50	Por favor enviar bastante guardanapo	2023-11-07 12:43:00+00	2023-11-07 12:43:00+00
31	75	75	\N	2023-10-20 12:36:00+00	SAIU_PARA_ENTREGA	60.70	7.50	0.00	68.20	Ponto da carne bem passado	2023-10-20 12:36:00+00	2023-10-20 12:36:00+00
32	4	82	\N	2023-10-27 13:12:00+00	ENTREGUE	177.70	11.50	0.00	189.20	Por favor enviar bastante guardanapo	2023-10-27 13:12:00+00	2023-10-27 13:12:00+00
33	68	68	\N	2023-12-26 18:16:00+00	ENTREGUE	4.50	14.00	0.00	18.50	\N	2023-12-26 18:16:00+00	2023-12-26 18:16:00+00
34	21	21	\N	2023-10-26 13:58:00+00	ENTREGUE	33.80	7.50	0.00	41.30	Ponto da carne ao ponto para mal	2023-10-26 13:58:00+00	2023-10-26 13:58:00+00
35	22	91	\N	2023-12-30 20:32:00+00	ENTREGUE	76.30	6.00	0.00	82.30	Deixar na portaria com o porteiro	2023-12-30 20:32:00+00	2023-12-30 20:32:00+00
36	21	21	\N	2024-01-22 11:37:00+00	ENTREGUE	34.90	7.50	0.00	42.40	Tocar a campainha quando chegar	2024-01-22 11:37:00+00	2024-01-22 11:37:00+00
37	35	35	\N	2023-10-07 13:23:00+00	ENTREGUE	54.80	13.00	0.00	67.80	Deixar na portaria com o porteiro	2023-10-07 13:23:00+00	2023-10-07 13:23:00+00
38	56	108	\N	2023-12-09 21:47:00+00	ENTREGUE	16.90	8.00	0.00	24.90	Deixar na portaria com o porteiro	2023-12-09 21:47:00+00	2023-12-09 21:47:00+00
39	54	54	\N	2023-11-27 23:55:00+00	ENTREGUE	225.70	10.00	0.00	235.70	Deixar na portaria com o porteiro	2023-11-27 23:55:00+00	2023-11-27 23:55:00+00
40	32	32	\N	2024-02-16 18:54:00+00	ENTREGUE	120.70	10.00	0.00	130.70	\N	2024-02-16 18:54:00+00	2024-02-16 18:54:00+00
41	14	14	\N	2024-02-22 23:00:00+00	ENTREGUE	147.00	10.50	0.00	157.50	Ponto da carne ao ponto para mal	2024-02-22 23:00:00+00	2024-02-22 23:00:00+00
42	33	33	\N	2023-12-26 11:57:00+00	ENTREGUE	46.90	6.00	0.00	52.90	\N	2023-12-26 11:57:00+00	2023-12-26 11:57:00+00
43	44	44	\N	2024-03-01 18:45:00+00	EM_PREPARO	35.90	9.00	0.00	44.90	Ponto da carne bem passado	2024-03-01 18:45:00+00	2024-03-01 18:45:00+00
44	63	63	4	2023-11-11 18:27:00+00	ENTREGUE	149.20	10.00	10.00	149.20	Ponto da carne ao ponto para mal	2023-11-11 18:27:00+00	2023-11-11 18:27:00+00
45	55	55	\N	2023-10-10 19:29:00+00	ENTREGUE	54.80	8.50	0.00	63.30	\N	2023-10-10 19:29:00+00	2023-10-10 19:29:00+00
46	1	1	\N	2024-01-19 12:04:00+00	ENTREGUE	64.80	10.50	0.00	75.30	Deixar na portaria com o porteiro	2024-01-19 12:04:00+00	2024-01-19 12:04:00+00
47	8	84	\N	2023-10-26 13:55:00+00	CANCELADO	87.20	13.00	0.00	100.20	Deixar na portaria com o porteiro	2023-10-26 13:55:00+00	2023-10-26 13:55:00+00
48	75	75	\N	2023-11-16 19:50:00+00	CANCELADO	49.40	7.50	0.00	56.90	Sem cebola no burger por favor	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
49	38	99	\N	2023-11-08 11:13:00+00	SAIU_PARA_ENTREGA	29.90	10.00	0.00	39.90	Sem cebola no burger por favor	2023-11-08 11:13:00+00	2023-11-08 11:13:00+00
50	13	13	\N	2023-11-01 22:13:00+00	ENTREGUE	82.80	11.50	0.00	94.30	\N	2023-11-01 22:13:00+00	2023-11-01 22:13:00+00
51	35	35	\N	2023-12-02 23:20:00+00	ENTREGUE	66.70	13.00	0.00	79.70	Tocar a campainha quando chegar	2023-12-02 23:20:00+00	2023-12-02 23:20:00+00
52	10	85	\N	2024-01-13 18:35:00+00	EM_PREPARO	76.30	10.00	0.00	86.30	Ponto da carne ao ponto para mal	2024-01-13 18:35:00+00	2024-01-13 18:35:00+00
53	67	67	\N	2023-10-13 12:33:00+00	EM_PREPARO	28.90	14.00	0.00	42.90	Sem cebola no burger por favor	2023-10-13 12:33:00+00	2023-10-13 12:33:00+00
54	25	25	\N	2023-10-02 21:25:00+00	ENTREGUE	74.80	8.50	0.00	83.30	Ponto da carne ao ponto para mal	2023-10-02 21:25:00+00	2023-10-02 21:25:00+00
55	22	91	\N	2023-11-01 12:16:00+00	ENTREGUE	72.30	6.00	0.00	78.30	Ponto da carne bem passado	2023-11-01 12:16:00+00	2023-11-01 12:16:00+00
56	22	91	\N	2023-10-26 23:43:00+00	EM_PREPARO	94.70	6.00	0.00	100.70	Por favor enviar bastante guardanapo	2023-10-26 23:43:00+00	2023-10-26 23:43:00+00
57	27	27	\N	2023-10-28 19:54:00+00	CANCELADO	79.20	14.00	0.00	93.20	\N	2023-10-28 19:54:00+00	2023-10-28 19:54:00+00
58	62	62	\N	2024-03-07 22:15:00+00	SAIU_PARA_ENTREGA	5.00	14.00	0.00	19.00	Tocar a campainha quando chegar	2024-03-07 22:15:00+00	2024-03-07 22:15:00+00
59	22	91	\N	2024-01-21 18:55:00+00	CANCELADO	61.30	6.00	0.00	67.30	Ponto da carne ao ponto para mal	2024-01-21 18:55:00+00	2024-01-21 18:55:00+00
60	13	13	\N	2023-12-21 12:56:00+00	CANCELADO	9.90	11.50	0.00	21.40	Tocar a campainha quando chegar	2023-12-21 12:56:00+00	2023-12-21 12:56:00+00
61	47	47	\N	2023-10-30 22:08:00+00	ENTREGUE	194.80	10.50	0.00	205.30	Sem cebola no burger por favor	2023-10-30 22:08:00+00	2023-10-30 22:08:00+00
62	54	54	\N	2024-02-08 13:53:00+00	ENTREGUE	141.30	10.00	0.00	151.30	Tocar a campainha quando chegar	2024-02-08 13:53:00+00	2024-02-08 13:53:00+00
63	64	64	\N	2024-01-29 12:14:00+00	ENTREGUE	116.70	9.00	0.00	125.70	Ponto da carne ao ponto para mal	2024-01-29 12:14:00+00	2024-01-29 12:14:00+00
64	24	24	\N	2023-12-05 23:17:00+00	ENTREGUE	84.30	10.00	0.00	94.30	Sem cebola no burger por favor	2023-12-05 23:17:00+00	2023-12-05 23:17:00+00
65	24	92	\N	2024-03-08 20:31:00+00	SAIU_PARA_ENTREGA	165.20	6.00	0.00	171.20	Por favor enviar bastante guardanapo	2024-03-08 20:31:00+00	2024-03-08 20:31:00+00
66	71	71	\N	2024-02-26 22:11:00+00	ENTREGUE	113.70	13.00	0.00	126.70	\N	2024-02-26 22:11:00+00	2024-02-26 22:11:00+00
67	18	89	\N	2024-01-03 11:17:00+00	ENTREGUE	4.50	11.50	0.00	16.00	Por favor enviar bastante guardanapo	2024-01-03 11:17:00+00	2024-01-03 11:17:00+00
68	47	47	\N	2023-12-13 18:49:00+00	ENTREGUE	87.90	10.50	0.00	98.40	Por favor enviar bastante guardanapo	2023-12-13 18:49:00+00	2023-12-13 18:49:00+00
69	15	15	\N	2023-12-24 13:28:00+00	EM_PREPARO	159.60	8.50	0.00	168.10	\N	2023-12-24 13:28:00+00	2023-12-24 13:28:00+00
70	7	7	\N	2024-01-22 22:09:00+00	SAIU_PARA_ENTREGA	174.80	11.50	0.00	186.30	Tocar a campainha quando chegar	2024-01-22 22:09:00+00	2024-01-22 22:09:00+00
71	45	45	\N	2024-01-14 20:20:00+00	ENTREGUE	4.50	8.50	0.00	13.00	Tocar a campainha quando chegar	2024-01-14 20:20:00+00	2024-01-14 20:20:00+00
72	17	17	\N	2023-10-21 11:23:00+00	ENTREGUE	51.80	7.00	0.00	58.80	Ponto da carne bem passado	2023-10-21 11:23:00+00	2023-10-21 11:23:00+00
73	8	8	\N	2024-01-15 12:53:00+00	CANCELADO	7.50	11.50	0.00	19.00	Por favor enviar bastante guardanapo	2024-01-15 12:53:00+00	2024-01-15 12:53:00+00
74	25	25	\N	2024-01-08 13:43:00+00	SAIU_PARA_ENTREGA	114.60	8.50	0.00	123.10	Ponto da carne ao ponto para mal	2024-01-08 13:43:00+00	2024-01-08 13:43:00+00
75	8	8	\N	2023-10-05 13:33:00+00	ENTREGUE	97.80	11.50	0.00	109.30	Por favor enviar bastante guardanapo	2023-10-05 13:33:00+00	2023-10-05 13:33:00+00
76	50	105	\N	2024-01-18 23:58:00+00	ENTREGUE	96.70	10.00	0.00	106.70	Ponto da carne ao ponto para mal	2024-01-18 23:58:00+00	2024-01-18 23:58:00+00
77	39	39	\N	2024-02-16 18:02:00+00	ENTREGUE	64.40	11.00	0.00	75.40	Sem cebola no burger por favor	2024-02-16 18:02:00+00	2024-02-16 18:02:00+00
78	70	70	\N	2024-01-03 12:51:00+00	ENTREGUE	173.80	11.00	0.00	184.80	Ponto da carne ao ponto para mal	2024-01-03 12:51:00+00	2024-01-03 12:51:00+00
79	48	48	\N	2023-10-25 13:27:00+00	ENTREGUE	70.80	7.00	0.00	77.80	Por favor enviar bastante guardanapo	2023-10-25 13:27:00+00	2023-10-25 13:27:00+00
80	80	80	\N	2023-11-04 21:39:00+00	ENTREGUE	72.70	7.00	0.00	79.70	Sem cebola no burger por favor	2023-11-04 21:39:00+00	2023-11-04 21:39:00+00
81	3	3	2	2024-03-07 21:43:00+00	ENTREGUE	58.80	13.00	5.88	65.92	Deixar na portaria com o porteiro	2024-03-07 21:43:00+00	2024-03-07 21:43:00+00
82	5	5	\N	2023-10-20 12:56:00+00	ENTREGUE	62.70	10.50	0.00	73.20	Tocar a campainha quando chegar	2023-10-20 12:56:00+00	2023-10-20 12:56:00+00
83	21	21	\N	2024-02-11 12:43:00+00	ENTREGUE	181.40	7.50	0.00	188.90	Ponto da carne bem passado	2024-02-11 12:43:00+00	2024-02-11 12:43:00+00
84	20	20	4	2024-02-06 23:18:00+00	ENTREGUE	151.10	8.50	10.00	149.60	\N	2024-02-06 23:18:00+00	2024-02-06 23:18:00+00
85	40	100	6	2023-10-13 21:52:00+00	ENTREGUE	196.80	10.00	39.36	167.44	Sem cebola no burger por favor	2023-10-13 21:52:00+00	2023-10-13 21:52:00+00
86	25	25	\N	2024-02-15 23:38:00+00	ENTREGUE	32.90	8.50	0.00	41.40	Sem cebola no burger por favor	2024-02-15 23:38:00+00	2024-02-15 23:38:00+00
87	73	73	\N	2023-11-02 23:30:00+00	ENTREGUE	185.10	7.00	0.00	192.10	Ponto da carne ao ponto para mal	2023-11-02 23:30:00+00	2023-11-02 23:30:00+00
88	11	11	\N	2024-02-14 18:10:00+00	ENTREGUE	56.80	7.00	0.00	63.80	Deixar na portaria com o porteiro	2024-02-14 18:10:00+00	2024-02-14 18:10:00+00
89	20	20	\N	2024-02-05 13:34:00+00	ENTREGUE	82.90	8.50	0.00	91.40	\N	2024-02-05 13:34:00+00	2024-02-05 13:34:00+00
90	47	47	\N	2024-02-25 11:07:00+00	ENTREGUE	154.00	10.50	0.00	164.50	Ponto da carne bem passado	2024-02-25 11:07:00+00	2024-02-25 11:07:00+00
91	71	71	\N	2023-12-21 19:38:00+00	ENTREGUE	172.80	13.00	0.00	185.80	Deixar na portaria com o porteiro	2023-12-21 19:38:00+00	2023-12-21 19:38:00+00
92	52	106	2	2023-11-08 22:11:00+00	ENTREGUE	201.20	8.50	20.12	189.58	Sem cebola no burger por favor	2023-11-08 22:11:00+00	2023-11-08 22:11:00+00
93	12	86	5	2023-11-03 19:17:00+00	ENTREGUE	120.20	14.00	10.00	124.20	\N	2023-11-03 19:17:00+00	2023-11-03 19:17:00+00
94	33	33	\N	2024-02-17 12:34:00+00	CANCELADO	34.90	6.00	0.00	40.90	\N	2024-02-17 12:34:00+00	2024-02-17 12:34:00+00
95	29	29	\N	2023-11-08 22:08:00+00	ENTREGUE	82.90	10.00	0.00	92.90	Tocar a campainha quando chegar	2023-11-08 22:08:00+00	2023-11-08 22:08:00+00
96	20	90	4	2024-03-07 11:10:00+00	ENTREGUE	53.90	8.50	10.00	52.40	Ponto da carne ao ponto para mal	2024-03-07 11:10:00+00	2024-03-07 11:10:00+00
97	37	37	\N	2023-12-07 13:26:00+00	ENTREGUE	63.80	7.50	0.00	71.30	\N	2023-12-07 13:26:00+00	2023-12-07 13:26:00+00
98	59	59	\N	2024-01-04 11:37:00+00	ENTREGUE	48.80	10.50	0.00	59.30	Ponto da carne bem passado	2024-01-04 11:37:00+00	2024-01-04 11:37:00+00
99	24	92	\N	2023-10-05 13:02:00+00	EM_PREPARO	122.60	6.00	0.00	128.60	Por favor enviar bastante guardanapo	2023-10-05 13:02:00+00	2023-10-05 13:02:00+00
100	76	118	8	2024-01-05 23:14:00+00	ENTREGUE	237.20	10.00	28.46	218.74	Por favor enviar bastante guardanapo	2024-01-05 23:14:00+00	2024-01-05 23:14:00+00
101	14	87	\N	2024-03-01 13:43:00+00	ENTREGUE	94.80	9.00	0.00	103.80	Ponto da carne bem passado	2024-03-01 13:43:00+00	2024-03-01 13:43:00+00
102	22	91	\N	2023-10-18 19:22:00+00	ENTREGUE	145.10	6.00	0.00	151.10	Deixar na portaria com o porteiro	2023-10-18 19:22:00+00	2023-10-18 19:22:00+00
103	61	61	\N	2024-02-13 13:30:00+00	EM_PREPARO	23.90	13.00	0.00	36.90	Ponto da carne bem passado	2024-02-13 13:30:00+00	2024-02-13 13:30:00+00
104	25	25	\N	2024-02-05 23:57:00+00	ENTREGUE	4.50	8.50	0.00	13.00	Ponto da carne bem passado	2024-02-05 23:57:00+00	2024-02-05 23:57:00+00
105	7	7	3	2023-10-03 19:26:00+00	CANCELADO	136.70	11.50	15.00	133.20	Deixar na portaria com o porteiro	2023-10-03 19:26:00+00	2023-10-03 19:26:00+00
106	11	11	\N	2024-01-09 22:00:00+00	CANCELADO	38.80	7.00	0.00	45.80	\N	2024-01-09 22:00:00+00	2024-01-09 22:00:00+00
107	22	22	9	2024-02-22 23:10:00+00	ENTREGUE	155.20	10.00	25.00	140.20	Deixar na portaria com o porteiro	2024-02-22 23:10:00+00	2024-02-22 23:10:00+00
108	11	11	\N	2024-01-07 12:56:00+00	ENTREGUE	224.20	7.00	0.00	231.20	Ponto da carne bem passado	2024-01-07 12:56:00+00	2024-01-07 12:56:00+00
109	8	8	\N	2024-01-26 12:04:00+00	ENTREGUE	112.70	11.50	0.00	124.20	Ponto da carne ao ponto para mal	2024-01-26 12:04:00+00	2024-01-26 12:04:00+00
110	7	7	\N	2023-12-25 20:18:00+00	ENTREGUE	76.80	11.50	0.00	88.30	Ponto da carne ao ponto para mal	2023-12-25 20:18:00+00	2023-12-25 20:18:00+00
111	20	20	5	2023-11-13 13:16:00+00	ENTREGUE	116.60	8.50	10.00	115.10	Ponto da carne bem passado	2023-11-13 13:16:00+00	2023-11-13 13:16:00+00
112	69	69	\N	2024-01-20 11:05:00+00	ENTREGUE	70.40	6.00	0.00	76.40	Tocar a campainha quando chegar	2024-01-20 11:05:00+00	2024-01-20 11:05:00+00
113	56	56	4	2024-01-01 13:35:00+00	EM_PREPARO	108.60	10.00	10.00	108.60	Por favor enviar bastante guardanapo	2024-01-01 13:35:00+00	2024-01-01 13:35:00+00
114	21	21	\N	2023-12-25 11:06:00+00	CANCELADO	82.80	7.50	0.00	90.30	Sem cebola no burger por favor	2023-12-25 11:06:00+00	2023-12-25 11:06:00+00
115	68	68	\N	2023-11-25 12:44:00+00	ENTREGUE	29.90	14.00	0.00	43.90	\N	2023-11-25 12:44:00+00	2023-11-25 12:44:00+00
116	59	59	\N	2024-01-24 18:51:00+00	EM_PREPARO	24.90	10.50	0.00	35.40	Tocar a campainha quando chegar	2024-01-24 18:51:00+00	2024-01-24 18:51:00+00
117	28	94	\N	2023-10-11 20:11:00+00	ENTREGUE	86.70	12.00	0.00	98.70	Tocar a campainha quando chegar	2023-10-11 20:11:00+00	2023-10-11 20:11:00+00
118	20	20	\N	2023-11-11 21:35:00+00	ENTREGUE	18.90	8.50	0.00	27.40	Ponto da carne bem passado	2023-11-11 21:35:00+00	2023-11-11 21:35:00+00
119	9	9	\N	2023-11-11 20:52:00+00	SAIU_PARA_ENTREGA	28.90	10.00	0.00	38.90	Ponto da carne bem passado	2023-11-11 20:52:00+00	2023-11-11 20:52:00+00
120	41	41	\N	2023-12-10 22:18:00+00	EM_PREPARO	31.40	7.50	0.00	38.90	Ponto da carne ao ponto para mal	2023-12-10 22:18:00+00	2023-12-10 22:18:00+00
121	23	23	\N	2023-12-10 13:55:00+00	ENTREGUE	20.00	12.00	0.00	32.00	Tocar a campainha quando chegar	2023-12-10 13:55:00+00	2023-12-10 13:55:00+00
122	68	114	\N	2024-02-07 22:00:00+00	ENTREGUE	46.90	6.00	0.00	52.90	Sem cebola no burger por favor	2024-02-07 22:00:00+00	2024-02-07 22:00:00+00
123	27	27	\N	2024-03-04 12:56:00+00	CANCELADO	41.90	14.00	0.00	55.90	Por favor enviar bastante guardanapo	2024-03-04 12:56:00+00	2024-03-04 12:56:00+00
124	22	91	\N	2024-01-29 21:56:00+00	EM_PREPARO	54.30	6.00	0.00	60.30	Ponto da carne ao ponto para mal	2024-01-29 21:56:00+00	2024-01-29 21:56:00+00
125	47	47	\N	2023-10-28 13:26:00+00	ENTREGUE	213.20	10.50	0.00	223.70	Ponto da carne bem passado	2023-10-28 13:26:00+00	2023-10-28 13:26:00+00
126	2	2	\N	2023-10-03 22:55:00+00	ENTREGUE	28.90	8.00	0.00	36.90	Sem cebola no burger por favor	2023-10-03 22:55:00+00	2023-10-03 22:55:00+00
127	22	22	\N	2023-10-02 13:24:00+00	EM_PREPARO	69.30	10.00	0.00	79.30	Por favor enviar bastante guardanapo	2023-10-02 13:24:00+00	2023-10-02 13:24:00+00
128	23	23	\N	2024-02-01 22:49:00+00	ENTREGUE	7.50	12.00	0.00	19.50	Ponto da carne ao ponto para mal	2024-02-01 22:49:00+00	2024-02-01 22:49:00+00
129	13	13	\N	2023-10-21 11:37:00+00	CANCELADO	22.90	11.50	0.00	34.40	Sem cebola no burger por favor	2023-10-21 11:37:00+00	2023-10-21 11:37:00+00
130	3	3	\N	2023-11-01 12:09:00+00	ENTREGUE	43.90	13.00	0.00	56.90	\N	2023-11-01 12:09:00+00	2023-11-01 12:09:00+00
131	44	44	\N	2023-10-15 23:37:00+00	CANCELADO	43.80	9.00	0.00	52.80	Ponto da carne bem passado	2023-10-15 23:37:00+00	2023-10-15 23:37:00+00
132	71	71	\N	2023-10-04 11:21:00+00	EM_PREPARO	24.90	13.00	0.00	37.90	Deixar na portaria com o porteiro	2023-10-04 11:21:00+00	2023-10-04 11:21:00+00
133	44	102	\N	2023-12-09 23:03:00+00	SAIU_PARA_ENTREGA	89.30	10.00	0.00	99.30	\N	2023-12-09 23:03:00+00	2023-12-09 23:03:00+00
134	5	5	\N	2024-01-22 22:44:00+00	ENTREGUE	5.00	10.50	0.00	15.50	Deixar na portaria com o porteiro	2024-01-22 22:44:00+00	2024-01-22 22:44:00+00
135	1	1	\N	2023-11-02 20:36:00+00	ENTREGUE	97.20	10.50	0.00	107.70	Deixar na portaria com o porteiro	2023-11-02 20:36:00+00	2023-11-02 20:36:00+00
136	41	41	\N	2023-12-18 22:25:00+00	ENTREGUE	56.80	7.50	0.00	64.30	\N	2023-12-18 22:25:00+00	2023-12-18 22:25:00+00
137	33	33	\N	2023-10-12 21:07:00+00	ENTREGUE	55.40	6.00	0.00	61.40	Sem cebola no burger por favor	2023-10-12 21:07:00+00	2023-10-12 21:07:00+00
138	10	10	\N	2023-12-23 19:40:00+00	CANCELADO	62.30	8.00	0.00	70.30	Ponto da carne ao ponto para mal	2023-12-23 19:40:00+00	2023-12-23 19:40:00+00
139	63	63	\N	2023-10-06 22:03:00+00	SAIU_PARA_ENTREGA	68.70	10.00	0.00	78.70	Ponto da carne bem passado	2023-10-06 22:03:00+00	2023-10-06 22:03:00+00
140	6	83	\N	2024-02-25 21:01:00+00	ENTREGUE	9.00	8.00	0.00	17.00	Por favor enviar bastante guardanapo	2024-02-25 21:01:00+00	2024-02-25 21:01:00+00
141	21	21	\N	2023-11-14 11:05:00+00	ENTREGUE	171.10	7.50	0.00	178.60	Sem cebola no burger por favor	2023-11-14 11:05:00+00	2023-11-14 11:05:00+00
142	46	103	\N	2024-02-19 11:25:00+00	SAIU_PARA_ENTREGA	173.80	6.00	0.00	179.80	Ponto da carne ao ponto para mal	2024-02-19 11:25:00+00	2024-02-19 11:25:00+00
143	50	50	7	2023-11-12 12:31:00+00	ENTREGUE	130.70	6.00	5.00	131.70	Ponto da carne ao ponto para mal	2023-11-12 12:31:00+00	2023-11-12 12:31:00+00
144	40	100	\N	2023-12-19 21:14:00+00	ENTREGUE	157.00	10.00	0.00	167.00	Ponto da carne ao ponto para mal	2023-12-19 21:14:00+00	2023-12-19 21:14:00+00
145	3	3	\N	2024-03-08 13:04:00+00	CANCELADO	4.50	13.00	0.00	17.50	Deixar na portaria com o porteiro	2024-03-08 13:04:00+00	2024-03-08 13:04:00+00
146	71	71	3	2023-12-21 19:29:00+00	EM_PREPARO	91.80	13.00	15.00	89.80	Deixar na portaria com o porteiro	2023-12-21 19:29:00+00	2023-12-21 19:29:00+00
147	37	37	\N	2023-11-21 20:09:00+00	ENTREGUE	104.80	7.50	0.00	112.30	Tocar a campainha quando chegar	2023-11-21 20:09:00+00	2023-11-21 20:09:00+00
148	6	6	\N	2024-02-23 13:26:00+00	ENTREGUE	115.10	10.50	0.00	125.60	Por favor enviar bastante guardanapo	2024-02-23 13:26:00+00	2024-02-23 13:26:00+00
149	35	35	\N	2024-02-21 23:06:00+00	CANCELADO	129.20	13.00	0.00	142.20	Por favor enviar bastante guardanapo	2024-02-21 23:06:00+00	2024-02-21 23:06:00+00
150	5	5	\N	2023-11-06 22:26:00+00	ENTREGUE	90.70	10.50	0.00	101.20	Ponto da carne bem passado	2023-11-06 22:26:00+00	2023-11-06 22:26:00+00
151	3	3	\N	2023-10-03 13:41:00+00	ENTREGUE	45.40	13.00	0.00	58.40	Sem cebola no burger por favor	2023-10-03 13:41:00+00	2023-10-03 13:41:00+00
152	15	15	\N	2023-10-09 23:50:00+00	ENTREGUE	29.40	8.50	0.00	37.90	\N	2023-10-09 23:50:00+00	2023-10-09 23:50:00+00
153	2	2	\N	2024-02-29 13:41:00+00	ENTREGUE	141.40	8.00	0.00	149.40	Ponto da carne bem passado	2024-02-29 13:41:00+00	2024-02-29 13:41:00+00
154	5	5	\N	2023-11-30 12:40:00+00	ENTREGUE	46.90	10.50	0.00	57.40	Sem cebola no burger por favor	2023-11-30 12:40:00+00	2023-11-30 12:40:00+00
155	56	108	\N	2024-01-26 18:23:00+00	ENTREGUE	67.90	8.00	0.00	75.90	Ponto da carne ao ponto para mal	2024-01-26 18:23:00+00	2024-01-26 18:23:00+00
156	2	2	\N	2024-02-16 21:56:00+00	ENTREGUE	31.80	8.00	0.00	39.80	Tocar a campainha quando chegar	2024-02-16 21:56:00+00	2024-02-16 21:56:00+00
157	19	19	\N	2024-02-02 22:49:00+00	ENTREGUE	177.20	6.00	0.00	183.20	Sem cebola no burger por favor	2024-02-02 22:49:00+00	2024-02-02 22:49:00+00
158	72	116	\N	2024-01-21 19:49:00+00	ENTREGUE	216.70	9.00	0.00	225.70	Por favor enviar bastante guardanapo	2024-01-21 19:49:00+00	2024-01-21 19:49:00+00
159	23	23	\N	2024-01-17 11:43:00+00	CANCELADO	105.20	12.00	0.00	117.20	Tocar a campainha quando chegar	2024-01-17 11:43:00+00	2024-01-17 11:43:00+00
160	33	33	1	2023-12-08 12:42:00+00	ENTREGUE	149.90	6.00	22.48	133.42	Ponto da carne bem passado	2023-12-08 12:42:00+00	2023-12-08 12:42:00+00
161	28	94	\N	2023-10-26 12:37:00+00	ENTREGUE	59.80	12.00	0.00	71.80	Deixar na portaria com o porteiro	2023-10-26 12:37:00+00	2023-10-26 12:37:00+00
162	47	47	\N	2024-01-22 21:13:00+00	ENTREGUE	55.30	10.50	0.00	65.80	Ponto da carne ao ponto para mal	2024-01-22 21:13:00+00	2024-01-22 21:13:00+00
163	29	29	\N	2023-10-27 22:03:00+00	ENTREGUE	16.90	10.00	0.00	26.90	\N	2023-10-27 22:03:00+00	2023-10-27 22:03:00+00
164	9	9	\N	2023-10-01 20:18:00+00	ENTREGUE	117.70	10.00	0.00	127.70	Por favor enviar bastante guardanapo	2023-10-01 20:18:00+00	2023-10-01 20:18:00+00
165	50	105	\N	2024-02-02 22:57:00+00	ENTREGUE	119.70	10.00	0.00	129.70	Deixar na portaria com o porteiro	2024-02-02 22:57:00+00	2024-02-02 22:57:00+00
166	11	11	\N	2024-02-12 21:51:00+00	ENTREGUE	79.30	7.00	0.00	86.30	\N	2024-02-12 21:51:00+00	2024-02-12 21:51:00+00
167	3	3	\N	2023-11-10 21:26:00+00	ENTREGUE	4.50	13.00	0.00	17.50	Deixar na portaria com o porteiro	2023-11-10 21:26:00+00	2023-11-10 21:26:00+00
168	16	88	8	2023-10-12 11:28:00+00	ENTREGUE	195.60	10.00	23.47	182.13	\N	2023-10-12 11:28:00+00	2023-10-12 11:28:00+00
169	69	69	\N	2024-01-22 21:53:00+00	CANCELADO	64.30	6.00	0.00	70.30	Ponto da carne ao ponto para mal	2024-01-22 21:53:00+00	2024-01-22 21:53:00+00
170	61	61	4	2023-12-08 13:23:00+00	ENTREGUE	76.30	13.00	10.00	79.30	Por favor enviar bastante guardanapo	2023-12-08 13:23:00+00	2023-12-08 13:23:00+00
171	35	35	\N	2023-10-18 19:41:00+00	ENTREGUE	75.80	13.00	0.00	88.80	Tocar a campainha quando chegar	2023-10-18 19:41:00+00	2023-10-18 19:41:00+00
172	41	41	\N	2024-01-17 18:27:00+00	CANCELADO	46.90	7.50	0.00	54.40	Deixar na portaria com o porteiro	2024-01-17 18:27:00+00	2024-01-17 18:27:00+00
173	10	85	\N	2024-01-06 12:25:00+00	ENTREGUE	66.80	10.00	0.00	76.80	Deixar na portaria com o porteiro	2024-01-06 12:25:00+00	2024-01-06 12:25:00+00
446	23	23	\N	2024-02-25 18:10:00+00	ENTREGUE	7.50	12.00	0.00	19.50	\N	2024-02-25 18:10:00+00	2024-02-25 18:10:00+00
174	3	3	\N	2024-01-07 18:17:00+00	CANCELADO	86.80	13.00	0.00	99.80	Ponto da carne ao ponto para mal	2024-01-07 18:17:00+00	2024-01-07 18:17:00+00
175	28	94	\N	2023-10-19 12:24:00+00	ENTREGUE	183.10	12.00	0.00	195.10	Ponto da carne bem passado	2023-10-19 12:24:00+00	2023-10-19 12:24:00+00
176	17	17	\N	2024-02-23 21:01:00+00	ENTREGUE	49.80	7.00	0.00	56.80	Sem cebola no burger por favor	2024-02-23 21:01:00+00	2024-02-23 21:01:00+00
177	77	77	\N	2023-11-01 12:47:00+00	ENTREGUE	7.00	11.00	0.00	18.00	Tocar a campainha quando chegar	2023-11-01 12:47:00+00	2023-11-01 12:47:00+00
178	75	75	\N	2023-10-08 18:22:00+00	ENTREGUE	149.60	7.50	0.00	157.10	Ponto da carne ao ponto para mal	2023-10-08 18:22:00+00	2023-10-08 18:22:00+00
179	42	42	\N	2023-11-20 21:45:00+00	ENTREGUE	99.80	10.00	0.00	109.80	Tocar a campainha quando chegar	2023-11-20 21:45:00+00	2023-11-20 21:45:00+00
180	33	33	\N	2023-11-21 22:36:00+00	ENTREGUE	23.90	6.00	0.00	29.90	Por favor enviar bastante guardanapo	2023-11-21 22:36:00+00	2023-11-21 22:36:00+00
181	79	79	4	2024-01-26 21:16:00+00	ENTREGUE	105.70	13.00	10.00	108.70	Deixar na portaria com o porteiro	2024-01-26 21:16:00+00	2024-01-26 21:16:00+00
182	19	19	\N	2023-12-19 22:34:00+00	ENTREGUE	23.90	6.00	0.00	29.90	Ponto da carne bem passado	2023-12-19 22:34:00+00	2023-12-19 22:34:00+00
183	12	86	\N	2024-02-05 13:55:00+00	ENTREGUE	4.50	14.00	0.00	18.50	Ponto da carne ao ponto para mal	2024-02-05 13:55:00+00	2024-02-05 13:55:00+00
184	43	43	\N	2023-11-24 18:08:00+00	ENTREGUE	34.40	9.00	0.00	43.40	\N	2023-11-24 18:08:00+00	2023-11-24 18:08:00+00
185	5	5	\N	2023-12-12 23:01:00+00	EM_PREPARO	32.40	10.50	0.00	42.90	Ponto da carne bem passado	2023-12-12 23:01:00+00	2023-12-12 23:01:00+00
186	32	96	\N	2023-11-28 11:45:00+00	ENTREGUE	16.90	8.00	0.00	24.90	Sem cebola no burger por favor	2023-11-28 11:45:00+00	2023-11-28 11:45:00+00
187	19	19	1	2024-02-14 12:52:00+00	EM_PREPARO	125.10	6.00	18.76	112.34	Por favor enviar bastante guardanapo	2024-02-14 12:52:00+00	2024-02-14 12:52:00+00
188	25	25	\N	2023-11-26 18:18:00+00	CANCELADO	19.80	8.50	0.00	28.30	Ponto da carne ao ponto para mal	2023-11-26 18:18:00+00	2023-11-26 18:18:00+00
189	14	87	\N	2024-01-08 23:48:00+00	ENTREGUE	67.70	9.00	0.00	76.70	Por favor enviar bastante guardanapo	2024-01-08 23:48:00+00	2024-01-08 23:48:00+00
190	60	110	\N	2024-03-01 20:21:00+00	ENTREGUE	37.90	12.00	0.00	49.90	Sem cebola no burger por favor	2024-03-01 20:21:00+00	2024-03-01 20:21:00+00
191	68	114	\N	2023-11-22 18:53:00+00	ENTREGUE	138.70	6.00	0.00	144.70	Ponto da carne ao ponto para mal	2023-11-22 18:53:00+00	2023-11-22 18:53:00+00
192	80	80	\N	2023-12-29 19:07:00+00	ENTREGUE	42.40	7.00	0.00	49.40	Ponto da carne ao ponto para mal	2023-12-29 19:07:00+00	2023-12-29 19:07:00+00
193	6	6	\N	2024-03-08 12:34:00+00	EM_PREPARO	153.20	10.50	0.00	163.70	Deixar na portaria com o porteiro	2024-03-08 12:34:00+00	2024-03-08 12:34:00+00
194	40	100	\N	2023-11-11 23:38:00+00	EM_PREPARO	87.80	10.00	0.00	97.80	Por favor enviar bastante guardanapo	2023-11-11 23:38:00+00	2023-11-11 23:38:00+00
195	3	3	\N	2023-12-25 12:03:00+00	ENTREGUE	30.90	13.00	0.00	43.90	Sem cebola no burger por favor	2023-12-25 12:03:00+00	2023-12-25 12:03:00+00
196	66	66	\N	2024-01-03 12:59:00+00	ENTREGUE	61.80	9.00	0.00	70.80	Tocar a campainha quando chegar	2024-01-03 12:59:00+00	2024-01-03 12:59:00+00
197	15	15	\N	2023-12-02 19:31:00+00	SAIU_PARA_ENTREGA	81.30	8.50	0.00	89.80	Sem cebola no burger por favor	2023-12-02 19:31:00+00	2023-12-02 19:31:00+00
198	78	119	\N	2024-02-18 13:24:00+00	SAIU_PARA_ENTREGA	50.40	10.50	0.00	60.90	Deixar na portaria com o porteiro	2024-02-18 13:24:00+00	2024-02-18 13:24:00+00
199	4	82	\N	2024-01-24 13:08:00+00	ENTREGUE	40.90	11.50	0.00	52.40	Tocar a campainha quando chegar	2024-01-24 13:08:00+00	2024-01-24 13:08:00+00
200	22	91	\N	2024-02-27 13:03:00+00	ENTREGUE	32.40	6.00	0.00	38.40	Ponto da carne ao ponto para mal	2024-02-27 13:03:00+00	2024-02-27 13:03:00+00
201	12	86	4	2023-12-01 19:27:00+00	ENTREGUE	62.90	14.00	10.00	66.90	Sem cebola no burger por favor	2023-12-01 19:27:00+00	2023-12-01 19:27:00+00
202	7	7	\N	2023-11-20 23:44:00+00	SAIU_PARA_ENTREGA	29.90	11.50	0.00	41.40	\N	2023-11-20 23:44:00+00	2023-11-20 23:44:00+00
203	70	115	\N	2023-10-29 18:54:00+00	ENTREGUE	146.70	11.00	0.00	157.70	Deixar na portaria com o porteiro	2023-10-29 18:54:00+00	2023-10-29 18:54:00+00
204	25	25	7	2024-02-21 22:26:00+00	ENTREGUE	116.80	8.50	5.00	120.30	Ponto da carne bem passado	2024-02-21 22:26:00+00	2024-02-21 22:26:00+00
205	13	13	\N	2024-02-17 11:01:00+00	ENTREGUE	57.80	11.50	0.00	69.30	Por favor enviar bastante guardanapo	2024-02-17 11:01:00+00	2024-02-17 11:01:00+00
206	71	71	\N	2023-11-23 12:58:00+00	SAIU_PARA_ENTREGA	222.60	13.00	0.00	235.60	Ponto da carne ao ponto para mal	2023-11-23 12:58:00+00	2023-11-23 12:58:00+00
207	20	20	5	2023-10-07 12:39:00+00	ENTREGUE	93.70	8.50	10.00	92.20	Por favor enviar bastante guardanapo	2023-10-07 12:39:00+00	2023-10-07 12:39:00+00
208	17	17	2	2023-12-21 13:26:00+00	ENTREGUE	42.40	7.00	4.24	45.16	Ponto da carne bem passado	2023-12-21 13:26:00+00	2023-12-21 13:26:00+00
209	12	12	4	2023-10-16 11:49:00+00	ENTREGUE	109.80	10.50	10.00	110.30	Sem cebola no burger por favor	2023-10-16 11:49:00+00	2023-10-16 11:49:00+00
210	32	32	\N	2023-11-30 20:24:00+00	ENTREGUE	23.90	10.00	0.00	33.90	Tocar a campainha quando chegar	2023-11-30 20:24:00+00	2023-11-30 20:24:00+00
211	4	82	\N	2024-02-11 19:29:00+00	EM_PREPARO	73.70	11.50	0.00	85.20	Por favor enviar bastante guardanapo	2024-02-11 19:29:00+00	2024-02-11 19:29:00+00
212	66	113	\N	2023-10-10 18:00:00+00	SAIU_PARA_ENTREGA	112.20	8.50	0.00	120.70	Por favor enviar bastante guardanapo	2023-10-10 18:00:00+00	2023-10-10 18:00:00+00
213	26	93	\N	2023-11-04 11:48:00+00	ENTREGUE	39.40	13.00	0.00	52.40	Ponto da carne ao ponto para mal	2023-11-04 11:48:00+00	2023-11-04 11:48:00+00
214	24	24	\N	2023-10-20 19:53:00+00	CANCELADO	51.80	10.00	0.00	61.80	Ponto da carne bem passado	2023-10-20 19:53:00+00	2023-10-20 19:53:00+00
215	10	85	\N	2023-11-16 11:36:00+00	ENTREGUE	29.90	10.00	0.00	39.90	Ponto da carne bem passado	2023-11-16 11:36:00+00	2023-11-16 11:36:00+00
216	23	23	\N	2023-10-27 22:38:00+00	ENTREGUE	58.80	12.00	0.00	70.80	Ponto da carne ao ponto para mal	2023-10-27 22:38:00+00	2023-10-27 22:38:00+00
217	56	56	\N	2023-10-19 12:53:00+00	ENTREGUE	65.70	10.00	0.00	75.70	Deixar na portaria com o porteiro	2023-10-19 12:53:00+00	2023-10-19 12:53:00+00
218	22	22	\N	2023-10-27 21:34:00+00	ENTREGUE	79.80	10.00	0.00	89.80	Sem cebola no burger por favor	2023-10-27 21:34:00+00	2023-10-27 21:34:00+00
219	9	9	8	2024-01-06 18:15:00+00	ENTREGUE	149.90	10.00	17.99	141.91	\N	2024-01-06 18:15:00+00	2024-01-06 18:15:00+00
220	1	1	\N	2024-03-09 19:15:00+00	SAIU_PARA_ENTREGA	172.80	10.50	0.00	183.30	Ponto da carne ao ponto para mal	2024-03-09 19:15:00+00	2024-03-09 19:15:00+00
221	7	7	\N	2023-10-05 18:45:00+00	ENTREGUE	123.70	11.50	0.00	135.20	Ponto da carne ao ponto para mal	2023-10-05 18:45:00+00	2023-10-05 18:45:00+00
222	74	117	3	2023-11-06 19:15:00+00	ENTREGUE	86.80	10.00	15.00	81.80	\N	2023-11-06 19:15:00+00	2023-11-06 19:15:00+00
223	42	42	\N	2023-10-25 13:40:00+00	ENTREGUE	52.30	10.00	0.00	62.30	Deixar na portaria com o porteiro	2023-10-25 13:40:00+00	2023-10-25 13:40:00+00
224	22	91	\N	2023-10-13 13:44:00+00	ENTREGUE	36.40	6.00	0.00	42.40	Ponto da carne bem passado	2023-10-13 13:44:00+00	2023-10-13 13:44:00+00
225	11	11	\N	2023-12-04 18:58:00+00	EM_PREPARO	56.90	7.00	0.00	63.90	Ponto da carne ao ponto para mal	2023-12-04 18:58:00+00	2023-12-04 18:58:00+00
226	12	12	\N	2024-03-06 12:36:00+00	ENTREGUE	65.70	10.50	0.00	76.20	Deixar na portaria com o porteiro	2024-03-06 12:36:00+00	2024-03-06 12:36:00+00
227	9	9	\N	2024-01-12 12:46:00+00	CANCELADO	63.20	10.00	0.00	73.20	Por favor enviar bastante guardanapo	2024-01-12 12:46:00+00	2024-01-12 12:46:00+00
228	34	34	\N	2024-01-05 19:17:00+00	ENTREGUE	67.40	9.00	0.00	76.40	Ponto da carne ao ponto para mal	2024-01-05 19:17:00+00	2024-01-05 19:17:00+00
229	10	85	\N	2023-12-07 20:08:00+00	ENTREGUE	87.40	10.00	0.00	97.40	Deixar na portaria com o porteiro	2023-12-07 20:08:00+00	2023-12-07 20:08:00+00
230	9	9	\N	2023-12-12 13:19:00+00	ENTREGUE	37.40	10.00	0.00	47.40	Ponto da carne ao ponto para mal	2023-12-12 13:19:00+00	2023-12-12 13:19:00+00
231	72	116	\N	2023-10-15 22:44:00+00	SAIU_PARA_ENTREGA	33.90	9.00	0.00	42.90	Ponto da carne bem passado	2023-10-15 22:44:00+00	2023-10-15 22:44:00+00
232	16	88	9	2024-01-19 13:21:00+00	CANCELADO	205.10	10.00	25.00	190.10	Ponto da carne ao ponto para mal	2024-01-19 13:21:00+00	2024-01-19 13:21:00+00
233	44	44	\N	2023-12-05 22:33:00+00	SAIU_PARA_ENTREGA	96.70	9.00	0.00	105.70	Ponto da carne bem passado	2023-12-05 22:33:00+00	2023-12-05 22:33:00+00
234	70	70	\N	2023-12-21 22:16:00+00	ENTREGUE	103.70	11.00	0.00	114.70	Tocar a campainha quando chegar	2023-12-21 22:16:00+00	2023-12-21 22:16:00+00
235	5	5	\N	2024-01-30 11:20:00+00	ENTREGUE	81.70	10.50	0.00	92.20	Ponto da carne bem passado	2024-01-30 11:20:00+00	2024-01-30 11:20:00+00
236	57	57	\N	2023-11-30 21:21:00+00	ENTREGUE	140.20	14.00	0.00	154.20	Sem cebola no burger por favor	2023-11-30 21:21:00+00	2023-11-30 21:21:00+00
237	76	76	2	2023-11-09 22:57:00+00	ENTREGUE	32.90	7.50	3.29	37.11	Ponto da carne bem passado	2023-11-09 22:57:00+00	2023-11-09 22:57:00+00
238	39	39	4	2023-10-26 22:41:00+00	CANCELADO	77.80	11.00	10.00	78.80	Deixar na portaria com o porteiro	2023-10-26 22:41:00+00	2023-10-26 22:41:00+00
239	66	66	\N	2023-12-06 23:32:00+00	ENTREGUE	143.10	9.00	0.00	152.10	Tocar a campainha quando chegar	2023-12-06 23:32:00+00	2023-12-06 23:32:00+00
240	24	24	2	2023-12-29 21:10:00+00	ENTREGUE	64.80	10.00	6.48	68.32	Deixar na portaria com o porteiro	2023-12-29 21:10:00+00	2023-12-29 21:10:00+00
241	5	5	\N	2023-12-22 18:32:00+00	ENTREGUE	19.80	10.50	0.00	30.30	Por favor enviar bastante guardanapo	2023-12-22 18:32:00+00	2023-12-22 18:32:00+00
242	14	14	\N	2023-11-03 11:21:00+00	ENTREGUE	59.80	10.50	0.00	70.30	Ponto da carne ao ponto para mal	2023-11-03 11:21:00+00	2023-11-03 11:21:00+00
243	14	87	\N	2023-12-12 12:49:00+00	ENTREGUE	155.10	9.00	0.00	164.10	Sem cebola no burger por favor	2023-12-12 12:49:00+00	2023-12-12 12:49:00+00
244	68	114	\N	2024-01-02 11:14:00+00	ENTREGUE	59.90	6.00	0.00	65.90	Tocar a campainha quando chegar	2024-01-02 11:14:00+00	2024-01-02 11:14:00+00
245	10	85	\N	2023-12-21 12:38:00+00	ENTREGUE	100.50	10.00	0.00	110.50	Deixar na portaria com o porteiro	2023-12-21 12:38:00+00	2023-12-21 12:38:00+00
246	23	23	\N	2024-01-14 19:11:00+00	ENTREGUE	85.80	12.00	0.00	97.80	Ponto da carne bem passado	2024-01-14 19:11:00+00	2024-01-14 19:11:00+00
247	8	8	\N	2024-03-09 11:10:00+00	ENTREGUE	33.90	11.50	0.00	45.40	Deixar na portaria com o porteiro	2024-03-09 11:10:00+00	2024-03-09 11:10:00+00
248	56	56	9	2024-02-08 22:51:00+00	ENTREGUE	173.60	10.00	25.00	158.60	Sem cebola no burger por favor	2024-02-08 22:51:00+00	2024-02-08 22:51:00+00
249	65	65	\N	2023-12-05 21:50:00+00	ENTREGUE	84.20	11.00	0.00	95.20	Ponto da carne ao ponto para mal	2023-12-05 21:50:00+00	2023-12-05 21:50:00+00
250	16	88	\N	2023-11-24 11:12:00+00	CANCELADO	219.00	10.00	0.00	229.00	Por favor enviar bastante guardanapo	2023-11-24 11:12:00+00	2023-11-24 11:12:00+00
251	60	60	7	2023-11-28 19:38:00+00	SAIU_PARA_ENTREGA	229.10	12.00	5.00	236.10	Sem cebola no burger por favor	2023-11-28 19:38:00+00	2023-11-28 19:38:00+00
252	8	8	4	2023-11-24 11:27:00+00	ENTREGUE	120.20	11.50	10.00	121.70	Tocar a campainha quando chegar	2023-11-24 11:27:00+00	2023-11-24 11:27:00+00
253	20	90	6	2023-11-25 11:47:00+00	ENTREGUE	112.30	8.50	22.46	98.34	Ponto da carne ao ponto para mal	2023-11-25 11:47:00+00	2023-11-25 11:47:00+00
254	5	5	\N	2023-10-26 12:35:00+00	EM_PREPARO	18.90	10.50	0.00	29.40	Deixar na portaria com o porteiro	2023-10-26 12:35:00+00	2023-10-26 12:35:00+00
255	19	19	\N	2024-02-27 11:12:00+00	ENTREGUE	199.30	6.00	0.00	205.30	Ponto da carne ao ponto para mal	2024-02-27 11:12:00+00	2024-02-27 11:12:00+00
256	70	70	\N	2024-02-23 23:01:00+00	CANCELADO	52.80	11.00	0.00	63.80	Deixar na portaria com o porteiro	2024-02-23 23:01:00+00	2024-02-23 23:01:00+00
257	79	79	\N	2024-01-31 19:34:00+00	EM_PREPARO	24.90	13.00	0.00	37.90	Ponto da carne bem passado	2024-01-31 19:34:00+00	2024-01-31 19:34:00+00
258	8	84	7	2023-12-19 23:21:00+00	ENTREGUE	65.90	13.00	5.00	73.90	\N	2023-12-19 23:21:00+00	2023-12-19 23:21:00+00
259	28	94	4	2023-12-09 22:38:00+00	ENTREGUE	128.70	12.00	10.00	130.70	Ponto da carne bem passado	2023-12-09 22:38:00+00	2023-12-09 22:38:00+00
260	30	95	\N	2023-10-10 22:19:00+00	ENTREGUE	59.80	11.50	0.00	71.30	\N	2023-10-10 22:19:00+00	2023-10-10 22:19:00+00
261	22	91	\N	2024-02-18 21:36:00+00	ENTREGUE	7.50	6.00	0.00	13.50	Por favor enviar bastante guardanapo	2024-02-18 21:36:00+00	2024-02-18 21:36:00+00
262	22	22	\N	2023-10-25 20:50:00+00	ENTREGUE	82.30	10.00	0.00	92.30	Sem cebola no burger por favor	2023-10-25 20:50:00+00	2023-10-25 20:50:00+00
263	13	13	\N	2024-01-17 13:42:00+00	ENTREGUE	35.90	11.50	0.00	47.40	Ponto da carne bem passado	2024-01-17 13:42:00+00	2024-01-17 13:42:00+00
264	5	5	\N	2024-02-08 18:17:00+00	ENTREGUE	61.80	10.50	0.00	72.30	Por favor enviar bastante guardanapo	2024-02-08 18:17:00+00	2024-02-08 18:17:00+00
265	54	54	\N	2023-11-26 18:15:00+00	ENTREGUE	86.70	10.00	0.00	96.70	Ponto da carne ao ponto para mal	2023-11-26 18:15:00+00	2023-11-26 18:15:00+00
266	6	83	\N	2023-11-16 19:50:00+00	ENTREGUE	31.40	8.00	0.00	39.40	Tocar a campainha quando chegar	2023-11-16 19:50:00+00	2023-11-16 19:50:00+00
267	43	43	\N	2023-11-14 18:27:00+00	ENTREGUE	47.40	9.00	0.00	56.40	Por favor enviar bastante guardanapo	2023-11-14 18:27:00+00	2023-11-14 18:27:00+00
268	60	60	\N	2024-02-08 18:37:00+00	CANCELADO	46.90	12.00	0.00	58.90	Ponto da carne bem passado	2024-02-08 18:37:00+00	2024-02-08 18:37:00+00
269	46	103	\N	2023-10-09 12:49:00+00	ENTREGUE	43.80	6.00	0.00	49.80	Sem cebola no burger por favor	2023-10-09 12:49:00+00	2023-10-09 12:49:00+00
270	52	106	\N	2024-01-15 21:50:00+00	CANCELADO	58.40	8.50	0.00	66.90	Por favor enviar bastante guardanapo	2024-01-15 21:50:00+00	2024-01-15 21:50:00+00
271	27	27	\N	2023-12-09 19:38:00+00	ENTREGUE	21.90	14.00	0.00	35.90	Ponto da carne ao ponto para mal	2023-12-09 19:38:00+00	2023-12-09 19:38:00+00
272	13	13	\N	2024-01-19 21:34:00+00	ENTREGUE	128.10	11.50	0.00	139.60	Deixar na portaria com o porteiro	2024-01-19 21:34:00+00	2024-01-19 21:34:00+00
273	29	29	\N	2024-02-06 13:09:00+00	ENTREGUE	9.00	10.00	0.00	19.00	Ponto da carne ao ponto para mal	2024-02-06 13:09:00+00	2024-02-06 13:09:00+00
274	39	39	\N	2023-12-08 22:37:00+00	EM_PREPARO	53.80	11.00	0.00	64.80	Ponto da carne bem passado	2023-12-08 22:37:00+00	2023-12-08 22:37:00+00
275	16	88	\N	2024-01-06 23:59:00+00	ENTREGUE	42.80	10.00	0.00	52.80	\N	2024-01-06 23:59:00+00	2024-01-06 23:59:00+00
276	2	81	\N	2023-10-03 11:05:00+00	EM_PREPARO	161.10	10.00	0.00	171.10	Sem cebola no burger por favor	2023-10-03 11:05:00+00	2023-10-03 11:05:00+00
277	56	56	\N	2023-12-19 23:50:00+00	ENTREGUE	21.90	10.00	0.00	31.90	\N	2023-12-19 23:50:00+00	2023-12-19 23:50:00+00
278	36	98	\N	2023-12-11 23:24:00+00	ENTREGUE	4.50	11.00	0.00	15.50	Tocar a campainha quando chegar	2023-12-11 23:24:00+00	2023-12-11 23:24:00+00
279	44	102	\N	2024-02-24 19:04:00+00	EM_PREPARO	328.40	10.00	0.00	338.40	Por favor enviar bastante guardanapo	2024-02-24 19:04:00+00	2024-02-24 19:04:00+00
280	69	69	\N	2023-12-25 19:48:00+00	EM_PREPARO	18.90	6.00	0.00	24.90	Ponto da carne ao ponto para mal	2023-12-25 19:48:00+00	2023-12-25 19:48:00+00
281	20	20	\N	2024-02-12 23:38:00+00	ENTREGUE	12.00	8.50	0.00	20.50	\N	2024-02-12 23:38:00+00	2024-02-12 23:38:00+00
282	56	108	\N	2024-01-14 23:15:00+00	SAIU_PARA_ENTREGA	42.80	8.00	0.00	50.80	Ponto da carne bem passado	2024-01-14 23:15:00+00	2024-01-14 23:15:00+00
283	15	15	\N	2024-01-13 18:02:00+00	ENTREGUE	20.00	8.50	0.00	28.50	Por favor enviar bastante guardanapo	2024-01-13 18:02:00+00	2024-01-13 18:02:00+00
284	43	43	\N	2023-10-21 12:50:00+00	ENTREGUE	60.80	9.00	0.00	69.80	Por favor enviar bastante guardanapo	2023-10-21 12:50:00+00	2023-10-21 12:50:00+00
285	55	55	\N	2024-02-23 23:50:00+00	ENTREGUE	91.70	8.50	0.00	100.20	Ponto da carne ao ponto para mal	2024-02-23 23:50:00+00	2024-02-23 23:50:00+00
286	62	62	\N	2023-10-27 22:58:00+00	ENTREGUE	186.80	14.00	0.00	200.80	Por favor enviar bastante guardanapo	2023-10-27 22:58:00+00	2023-10-27 22:58:00+00
287	20	90	\N	2024-02-01 21:44:00+00	EM_PREPARO	12.00	8.50	0.00	20.50	Tocar a campainha quando chegar	2024-02-01 21:44:00+00	2024-02-01 21:44:00+00
288	74	117	5	2023-11-19 12:57:00+00	ENTREGUE	154.50	10.00	10.00	154.50	Deixar na portaria com o porteiro	2023-11-19 12:57:00+00	2023-11-19 12:57:00+00
289	21	21	\N	2023-12-04 21:02:00+00	EM_PREPARO	76.70	7.50	0.00	84.20	Tocar a campainha quando chegar	2023-12-04 21:02:00+00	2023-12-04 21:02:00+00
290	3	3	\N	2024-02-01 11:46:00+00	ENTREGUE	91.30	13.00	0.00	104.30	Sem cebola no burger por favor	2024-02-01 11:46:00+00	2024-02-01 11:46:00+00
291	14	14	\N	2024-02-04 23:26:00+00	SAIU_PARA_ENTREGA	69.30	10.50	0.00	79.80	\N	2024-02-04 23:26:00+00	2024-02-04 23:26:00+00
292	4	4	\N	2024-02-07 19:55:00+00	ENTREGUE	107.80	13.00	0.00	120.80	Ponto da carne bem passado	2024-02-07 19:55:00+00	2024-02-07 19:55:00+00
293	1	1	\N	2024-01-19 12:06:00+00	ENTREGUE	223.50	10.50	0.00	234.00	Ponto da carne ao ponto para mal	2024-01-19 12:06:00+00	2024-01-19 12:06:00+00
294	11	11	\N	2024-01-28 20:55:00+00	ENTREGUE	30.90	7.00	0.00	37.90	Ponto da carne ao ponto para mal	2024-01-28 20:55:00+00	2024-01-28 20:55:00+00
295	16	16	\N	2023-12-28 11:41:00+00	ENTREGUE	74.70	13.00	0.00	87.70	Por favor enviar bastante guardanapo	2023-12-28 11:41:00+00	2023-12-28 11:41:00+00
296	73	73	\N	2023-11-29 13:20:00+00	CANCELADO	34.40	7.00	0.00	41.40	Por favor enviar bastante guardanapo	2023-11-29 13:20:00+00	2023-11-29 13:20:00+00
297	71	71	\N	2024-02-19 20:39:00+00	CANCELADO	89.60	13.00	0.00	102.60	Deixar na portaria com o porteiro	2024-02-19 20:39:00+00	2024-02-19 20:39:00+00
298	57	57	\N	2024-03-02 12:31:00+00	ENTREGUE	38.30	14.00	0.00	52.30	Por favor enviar bastante guardanapo	2024-03-02 12:31:00+00	2024-03-02 12:31:00+00
299	30	30	\N	2024-02-21 11:30:00+00	ENTREGUE	92.30	13.00	0.00	105.30	\N	2024-02-21 11:30:00+00	2024-02-21 11:30:00+00
300	31	31	\N	2024-03-02 18:21:00+00	ENTREGUE	103.70	7.50	0.00	111.20	Deixar na portaria com o porteiro	2024-03-02 18:21:00+00	2024-03-02 18:21:00+00
301	20	20	\N	2023-11-13 12:40:00+00	ENTREGUE	88.70	8.50	0.00	97.20	Tocar a campainha quando chegar	2023-11-13 12:40:00+00	2023-11-13 12:40:00+00
302	18	89	\N	2023-10-05 20:22:00+00	SAIU_PARA_ENTREGA	49.80	11.50	0.00	61.30	\N	2023-10-05 20:22:00+00	2023-10-05 20:22:00+00
303	70	115	9	2024-02-17 13:27:00+00	ENTREGUE	197.50	11.00	25.00	183.50	\N	2024-02-17 13:27:00+00	2024-02-17 13:27:00+00
304	5	5	\N	2023-12-29 21:06:00+00	ENTREGUE	100.80	10.50	0.00	111.30	Ponto da carne ao ponto para mal	2023-12-29 21:06:00+00	2023-12-29 21:06:00+00
305	71	71	4	2023-11-01 12:11:00+00	ENTREGUE	93.30	13.00	10.00	96.30	Deixar na portaria com o porteiro	2023-11-01 12:11:00+00	2023-11-01 12:11:00+00
306	62	111	4	2024-02-23 19:03:00+00	EM_PREPARO	119.20	8.00	10.00	117.20	Ponto da carne ao ponto para mal	2024-02-23 19:03:00+00	2024-02-23 19:03:00+00
307	18	89	\N	2023-11-19 18:57:00+00	ENTREGUE	174.20	11.50	0.00	185.70	Por favor enviar bastante guardanapo	2023-11-19 18:57:00+00	2023-11-19 18:57:00+00
308	70	70	\N	2024-02-03 12:18:00+00	ENTREGUE	4.50	11.00	0.00	15.50	Tocar a campainha quando chegar	2024-02-03 12:18:00+00	2024-02-03 12:18:00+00
309	65	65	\N	2024-02-25 11:52:00+00	CANCELADO	75.80	11.00	0.00	86.80	Sem cebola no burger por favor	2024-02-25 11:52:00+00	2024-02-25 11:52:00+00
310	58	109	\N	2023-11-16 19:40:00+00	ENTREGUE	201.80	7.50	0.00	209.30	Ponto da carne bem passado	2023-11-16 19:40:00+00	2023-11-16 19:40:00+00
311	55	55	\N	2023-11-01 22:16:00+00	EM_PREPARO	12.50	8.50	0.00	21.00	Tocar a campainha quando chegar	2023-11-01 22:16:00+00	2023-11-01 22:16:00+00
312	18	89	2	2024-02-19 11:13:00+00	ENTREGUE	184.70	11.50	18.47	177.73	Ponto da carne ao ponto para mal	2024-02-19 11:13:00+00	2024-02-19 11:13:00+00
313	20	90	\N	2023-11-26 13:12:00+00	SAIU_PARA_ENTREGA	61.80	8.50	0.00	70.30	Sem cebola no burger por favor	2023-11-26 13:12:00+00	2023-11-26 13:12:00+00
314	43	43	3	2023-11-04 13:35:00+00	CANCELADO	81.80	9.00	15.00	75.80	Sem cebola no burger por favor	2023-11-04 13:35:00+00	2023-11-04 13:35:00+00
315	25	25	\N	2023-11-14 20:14:00+00	SAIU_PARA_ENTREGA	121.20	8.50	0.00	129.70	Tocar a campainha quando chegar	2023-11-14 20:14:00+00	2023-11-14 20:14:00+00
316	5	5	\N	2023-10-30 22:01:00+00	CANCELADO	52.90	10.50	0.00	63.40	Ponto da carne bem passado	2023-10-30 22:01:00+00	2023-10-30 22:01:00+00
317	51	51	\N	2024-03-06 21:14:00+00	ENTREGUE	84.80	13.00	0.00	97.80	Deixar na portaria com o porteiro	2024-03-06 21:14:00+00	2024-03-06 21:14:00+00
318	71	71	\N	2024-02-05 11:16:00+00	ENTREGUE	57.30	13.00	0.00	70.30	Por favor enviar bastante guardanapo	2024-02-05 11:16:00+00	2024-02-05 11:16:00+00
319	67	67	\N	2023-11-02 22:55:00+00	ENTREGUE	172.80	14.00	0.00	186.80	Ponto da carne bem passado	2023-11-02 22:55:00+00	2023-11-02 22:55:00+00
320	67	67	\N	2024-01-06 18:05:00+00	ENTREGUE	108.80	14.00	0.00	122.80	Deixar na portaria com o porteiro	2024-01-06 18:05:00+00	2024-01-06 18:05:00+00
321	2	81	7	2023-10-23 22:19:00+00	ENTREGUE	163.50	10.00	5.00	168.50	\N	2023-10-23 22:19:00+00	2023-10-23 22:19:00+00
322	15	15	\N	2023-10-03 23:22:00+00	ENTREGUE	154.40	8.50	0.00	162.90	Tocar a campainha quando chegar	2023-10-03 23:22:00+00	2023-10-03 23:22:00+00
323	78	119	\N	2023-10-28 23:48:00+00	EM_PREPARO	134.50	10.50	0.00	145.00	Ponto da carne ao ponto para mal	2023-10-28 23:48:00+00	2023-10-28 23:48:00+00
324	35	35	\N	2024-02-01 11:35:00+00	CANCELADO	10.00	13.00	0.00	23.00	Ponto da carne ao ponto para mal	2024-02-01 11:35:00+00	2024-02-01 11:35:00+00
325	70	115	\N	2024-02-20 18:31:00+00	ENTREGUE	26.80	11.00	0.00	37.80	\N	2024-02-20 18:31:00+00	2024-02-20 18:31:00+00
326	7	7	\N	2023-10-02 19:51:00+00	ENTREGUE	16.90	11.50	0.00	28.40	Ponto da carne ao ponto para mal	2023-10-02 19:51:00+00	2023-10-02 19:51:00+00
327	10	85	\N	2024-03-08 19:27:00+00	CANCELADO	34.90	10.00	0.00	44.90	\N	2024-03-08 19:27:00+00	2024-03-08 19:27:00+00
328	30	30	10	2024-01-25 18:41:00+00	ENTREGUE	146.10	13.00	36.52	122.58	Ponto da carne ao ponto para mal	2024-01-25 18:41:00+00	2024-01-25 18:41:00+00
329	51	51	\N	2023-11-14 21:04:00+00	ENTREGUE	93.30	13.00	0.00	106.30	Deixar na portaria com o porteiro	2023-11-14 21:04:00+00	2023-11-14 21:04:00+00
330	5	5	9	2023-12-19 23:47:00+00	ENTREGUE	219.70	10.50	25.00	205.20	Por favor enviar bastante guardanapo	2023-12-19 23:47:00+00	2023-12-19 23:47:00+00
331	73	73	\N	2024-02-20 11:38:00+00	ENTREGUE	149.90	7.00	0.00	156.90	Tocar a campainha quando chegar	2024-02-20 11:38:00+00	2024-02-20 11:38:00+00
332	28	94	\N	2023-12-23 22:55:00+00	ENTREGUE	29.90	12.00	0.00	41.90	Tocar a campainha quando chegar	2023-12-23 22:55:00+00	2023-12-23 22:55:00+00
333	70	70	1	2023-12-31 21:13:00+00	ENTREGUE	75.80	11.00	11.37	75.43	Ponto da carne bem passado	2023-12-31 21:13:00+00	2023-12-31 21:13:00+00
334	42	101	\N	2023-12-14 11:05:00+00	ENTREGUE	51.30	7.50	0.00	58.80	Por favor enviar bastante guardanapo	2023-12-14 11:05:00+00	2023-12-14 11:05:00+00
335	14	87	\N	2024-02-07 20:24:00+00	ENTREGUE	69.90	9.00	0.00	78.90	Deixar na portaria com o porteiro	2024-02-07 20:24:00+00	2024-02-07 20:24:00+00
336	8	8	\N	2024-02-06 18:20:00+00	EM_PREPARO	5.00	11.50	0.00	16.50	Ponto da carne ao ponto para mal	2024-02-06 18:20:00+00	2024-02-06 18:20:00+00
337	24	92	\N	2023-10-08 19:23:00+00	ENTREGUE	31.90	6.00	0.00	37.90	Por favor enviar bastante guardanapo	2023-10-08 19:23:00+00	2023-10-08 19:23:00+00
338	24	92	7	2023-10-27 18:23:00+00	CANCELADO	56.80	6.00	5.00	57.80	Ponto da carne bem passado	2023-10-27 18:23:00+00	2023-10-27 18:23:00+00
339	21	21	\N	2024-01-17 22:35:00+00	ENTREGUE	9.90	7.50	0.00	17.40	Por favor enviar bastante guardanapo	2024-01-17 22:35:00+00	2024-01-17 22:35:00+00
340	16	16	\N	2024-01-17 20:37:00+00	ENTREGUE	58.80	13.00	0.00	71.80	\N	2024-01-17 20:37:00+00	2024-01-17 20:37:00+00
341	44	44	\N	2023-11-12 18:35:00+00	EM_PREPARO	95.80	9.00	0.00	104.80	\N	2023-11-12 18:35:00+00	2023-11-12 18:35:00+00
342	13	13	\N	2024-02-11 19:33:00+00	ENTREGUE	37.80	11.50	0.00	49.30	Sem cebola no burger por favor	2024-02-11 19:33:00+00	2024-02-11 19:33:00+00
343	6	6	\N	2023-10-05 20:42:00+00	ENTREGUE	54.80	10.50	0.00	65.30	Ponto da carne ao ponto para mal	2023-10-05 20:42:00+00	2023-10-05 20:42:00+00
344	18	89	\N	2024-01-09 11:16:00+00	ENTREGUE	28.90	11.50	0.00	40.40	Deixar na portaria com o porteiro	2024-01-09 11:16:00+00	2024-01-09 11:16:00+00
345	14	87	\N	2023-10-16 11:56:00+00	CANCELADO	88.70	9.00	0.00	97.70	Por favor enviar bastante guardanapo	2023-10-16 11:56:00+00	2023-10-16 11:56:00+00
346	23	23	\N	2024-01-28 18:01:00+00	ENTREGUE	65.30	12.00	0.00	77.30	Deixar na portaria com o porteiro	2024-01-28 18:01:00+00	2024-01-28 18:01:00+00
347	54	54	\N	2024-03-02 11:58:00+00	ENTREGUE	148.60	10.00	0.00	158.60	Tocar a campainha quando chegar	2024-03-02 11:58:00+00	2024-03-02 11:58:00+00
348	27	27	\N	2024-01-19 23:39:00+00	ENTREGUE	54.30	14.00	0.00	68.30	Sem cebola no burger por favor	2024-01-19 23:39:00+00	2024-01-19 23:39:00+00
349	73	73	\N	2024-01-06 21:05:00+00	ENTREGUE	22.90	7.00	0.00	29.90	Deixar na portaria com o porteiro	2024-01-06 21:05:00+00	2024-01-06 21:05:00+00
350	52	106	\N	2023-10-21 21:50:00+00	SAIU_PARA_ENTREGA	88.70	8.50	0.00	97.20	Ponto da carne bem passado	2023-10-21 21:50:00+00	2023-10-21 21:50:00+00
351	33	33	\N	2023-10-30 13:42:00+00	CANCELADO	111.60	6.00	0.00	117.60	Ponto da carne bem passado	2023-10-30 13:42:00+00	2023-10-30 13:42:00+00
352	14	14	\N	2023-11-06 13:30:00+00	ENTREGUE	39.90	10.50	0.00	50.40	Por favor enviar bastante guardanapo	2023-11-06 13:30:00+00	2023-11-06 13:30:00+00
353	14	14	\N	2023-12-17 19:50:00+00	EM_PREPARO	33.90	10.50	0.00	44.40	Ponto da carne ao ponto para mal	2023-12-17 19:50:00+00	2023-12-17 19:50:00+00
354	71	71	\N	2024-01-10 22:55:00+00	ENTREGUE	57.80	13.00	0.00	70.80	Deixar na portaria com o porteiro	2024-01-10 22:55:00+00	2024-01-10 22:55:00+00
355	11	11	\N	2023-12-21 18:02:00+00	ENTREGUE	59.80	7.00	0.00	66.80	Ponto da carne bem passado	2023-12-21 18:02:00+00	2023-12-21 18:02:00+00
356	18	89	\N	2023-10-11 23:26:00+00	ENTREGUE	154.40	11.50	0.00	165.90	Ponto da carne ao ponto para mal	2023-10-11 23:26:00+00	2023-10-11 23:26:00+00
357	33	33	\N	2023-11-28 19:19:00+00	ENTREGUE	298.60	6.00	0.00	304.60	Ponto da carne bem passado	2023-11-28 19:19:00+00	2023-11-28 19:19:00+00
358	32	32	\N	2024-03-02 11:28:00+00	CANCELADO	195.60	10.00	0.00	205.60	Ponto da carne ao ponto para mal	2024-03-02 11:28:00+00	2024-03-02 11:28:00+00
359	75	75	\N	2024-02-06 21:51:00+00	ENTREGUE	21.90	7.50	0.00	29.40	\N	2024-02-06 21:51:00+00	2024-02-06 21:51:00+00
360	2	81	\N	2023-11-30 18:09:00+00	ENTREGUE	23.90	10.00	0.00	33.90	Ponto da carne bem passado	2023-11-30 18:09:00+00	2023-11-30 18:09:00+00
361	11	11	\N	2023-12-28 19:52:00+00	CANCELADO	54.80	7.00	0.00	61.80	Ponto da carne ao ponto para mal	2023-12-28 19:52:00+00	2023-12-28 19:52:00+00
362	38	99	\N	2024-01-15 19:31:00+00	CANCELADO	54.80	10.00	0.00	64.80	Tocar a campainha quando chegar	2024-01-15 19:31:00+00	2024-01-15 19:31:00+00
363	24	92	\N	2023-10-02 11:43:00+00	CANCELADO	45.40	6.00	0.00	51.40	\N	2023-10-02 11:43:00+00	2023-10-02 11:43:00+00
364	1	1	\N	2023-11-06 21:27:00+00	SAIU_PARA_ENTREGA	79.70	10.50	0.00	90.20	Tocar a campainha quando chegar	2023-11-06 21:27:00+00	2023-11-06 21:27:00+00
365	47	47	\N	2024-01-04 19:39:00+00	ENTREGUE	107.80	10.50	0.00	118.30	Ponto da carne bem passado	2024-01-04 19:39:00+00	2024-01-04 19:39:00+00
366	31	31	\N	2023-12-27 19:10:00+00	ENTREGUE	89.80	7.50	0.00	97.30	\N	2023-12-27 19:10:00+00	2023-12-27 19:10:00+00
367	5	5	\N	2024-01-08 13:10:00+00	ENTREGUE	93.70	10.50	0.00	104.20	Sem cebola no burger por favor	2024-01-08 13:10:00+00	2024-01-08 13:10:00+00
368	4	82	\N	2023-11-18 12:37:00+00	ENTREGUE	146.60	11.50	0.00	158.10	Sem cebola no burger por favor	2023-11-18 12:37:00+00	2023-11-18 12:37:00+00
369	63	63	\N	2023-10-27 23:26:00+00	ENTREGUE	24.90	10.00	0.00	34.90	Sem cebola no burger por favor	2023-10-27 23:26:00+00	2023-10-27 23:26:00+00
370	13	13	\N	2024-03-07 20:51:00+00	ENTREGUE	75.70	11.50	0.00	87.20	\N	2024-03-07 20:51:00+00	2024-03-07 20:51:00+00
371	49	49	\N	2023-11-10 21:33:00+00	ENTREGUE	119.20	6.00	0.00	125.20	Ponto da carne ao ponto para mal	2023-11-10 21:33:00+00	2023-11-10 21:33:00+00
372	14	14	\N	2023-10-27 18:15:00+00	EM_PREPARO	27.40	10.50	0.00	37.90	Ponto da carne bem passado	2023-10-27 18:15:00+00	2023-10-27 18:15:00+00
373	12	86	\N	2024-03-02 12:59:00+00	ENTREGUE	243.50	14.00	0.00	257.50	Ponto da carne ao ponto para mal	2024-03-02 12:59:00+00	2024-03-02 12:59:00+00
374	3	3	1	2023-12-18 23:53:00+00	SAIU_PARA_ENTREGA	51.40	13.00	7.71	56.69	Por favor enviar bastante guardanapo	2023-12-18 23:53:00+00	2023-12-18 23:53:00+00
375	20	90	\N	2024-03-07 20:11:00+00	ENTREGUE	22.90	8.50	0.00	31.40	\N	2024-03-07 20:11:00+00	2024-03-07 20:11:00+00
376	13	13	\N	2023-12-05 23:48:00+00	ENTREGUE	184.60	11.50	0.00	196.10	Por favor enviar bastante guardanapo	2023-12-05 23:48:00+00	2023-12-05 23:48:00+00
377	32	96	\N	2023-10-04 11:20:00+00	ENTREGUE	46.40	8.00	0.00	54.40	Deixar na portaria com o porteiro	2023-10-04 11:20:00+00	2023-10-04 11:20:00+00
378	80	120	\N	2024-02-05 13:31:00+00	ENTREGUE	91.70	8.50	0.00	100.20	Deixar na portaria com o porteiro	2024-02-05 13:31:00+00	2024-02-05 13:31:00+00
379	46	103	\N	2023-12-22 22:26:00+00	ENTREGUE	87.80	6.00	0.00	93.80	Tocar a campainha quando chegar	2023-12-22 22:26:00+00	2023-12-22 22:26:00+00
380	31	31	\N	2024-03-02 21:04:00+00	ENTREGUE	83.70	7.50	0.00	91.20	Ponto da carne bem passado	2024-03-02 21:04:00+00	2024-03-02 21:04:00+00
381	56	108	\N	2024-02-22 19:32:00+00	ENTREGUE	42.40	8.00	0.00	50.40	\N	2024-02-22 19:32:00+00	2024-02-22 19:32:00+00
382	64	64	\N	2023-12-06 23:17:00+00	ENTREGUE	34.40	9.00	0.00	43.40	Tocar a campainha quando chegar	2023-12-06 23:17:00+00	2023-12-06 23:17:00+00
383	78	78	\N	2024-01-22 21:18:00+00	ENTREGUE	61.20	13.00	0.00	74.20	Tocar a campainha quando chegar	2024-01-22 21:18:00+00	2024-01-22 21:18:00+00
384	15	15	\N	2023-10-23 20:49:00+00	ENTREGUE	100.80	8.50	0.00	109.30	Deixar na portaria com o porteiro	2023-10-23 20:49:00+00	2023-10-23 20:49:00+00
385	1	1	9	2023-12-05 19:42:00+00	ENTREGUE	161.60	10.50	25.00	147.10	Por favor enviar bastante guardanapo	2023-12-05 19:42:00+00	2023-12-05 19:42:00+00
386	2	2	\N	2023-12-24 19:05:00+00	ENTREGUE	86.30	8.00	0.00	94.30	Deixar na portaria com o porteiro	2023-12-24 19:05:00+00	2023-12-24 19:05:00+00
387	13	13	\N	2023-12-16 19:44:00+00	ENTREGUE	191.10	11.50	0.00	202.60	Ponto da carne ao ponto para mal	2023-12-16 19:44:00+00	2023-12-16 19:44:00+00
388	58	58	\N	2023-11-26 23:47:00+00	CANCELADO	50.80	14.00	0.00	64.80	Deixar na portaria com o porteiro	2023-11-26 23:47:00+00	2023-11-26 23:47:00+00
389	44	102	\N	2024-01-21 23:12:00+00	EM_PREPARO	34.80	10.00	0.00	44.80	Tocar a campainha quando chegar	2024-01-21 23:12:00+00	2024-01-21 23:12:00+00
390	17	17	\N	2023-12-26 20:28:00+00	CANCELADO	149.90	7.00	0.00	156.90	Sem cebola no burger por favor	2023-12-26 20:28:00+00	2023-12-26 20:28:00+00
391	23	23	\N	2023-11-10 23:21:00+00	SAIU_PARA_ENTREGA	60.30	12.00	0.00	72.30	Tocar a campainha quando chegar	2023-11-10 23:21:00+00	2023-11-10 23:21:00+00
392	9	9	\N	2023-11-07 21:00:00+00	ENTREGUE	7.50	10.00	0.00	17.50	Por favor enviar bastante guardanapo	2023-11-07 21:00:00+00	2023-11-07 21:00:00+00
393	49	49	\N	2024-03-04 13:08:00+00	ENTREGUE	28.40	6.00	0.00	34.40	Por favor enviar bastante guardanapo	2024-03-04 13:08:00+00	2024-03-04 13:08:00+00
394	56	56	\N	2023-12-14 22:41:00+00	ENTREGUE	85.80	10.00	0.00	95.80	Por favor enviar bastante guardanapo	2023-12-14 22:41:00+00	2023-12-14 22:41:00+00
395	3	3	\N	2024-01-13 11:08:00+00	ENTREGUE	89.30	13.00	0.00	102.30	Sem cebola no burger por favor	2024-01-13 11:08:00+00	2024-01-13 11:08:00+00
396	73	73	\N	2023-10-27 11:36:00+00	SAIU_PARA_ENTREGA	5.00	7.00	0.00	12.00	Deixar na portaria com o porteiro	2023-10-27 11:36:00+00	2023-10-27 11:36:00+00
397	25	25	\N	2023-12-25 11:28:00+00	ENTREGUE	102.80	8.50	0.00	111.30	Sem cebola no burger por favor	2023-12-25 11:28:00+00	2023-12-25 11:28:00+00
398	10	85	\N	2024-01-25 19:03:00+00	ENTREGUE	48.90	10.00	0.00	58.90	\N	2024-01-25 19:03:00+00	2024-01-25 19:03:00+00
399	23	23	\N	2024-02-17 23:12:00+00	ENTREGUE	63.80	12.00	0.00	75.80	Sem cebola no burger por favor	2024-02-17 23:12:00+00	2024-02-17 23:12:00+00
400	15	15	1	2023-10-10 12:59:00+00	ENTREGUE	174.00	8.50	26.10	156.40	Por favor enviar bastante guardanapo	2023-10-10 12:59:00+00	2023-10-10 12:59:00+00
401	36	36	2	2023-10-14 22:57:00+00	SAIU_PARA_ENTREGA	111.70	14.00	11.17	114.53	Deixar na portaria com o porteiro	2023-10-14 22:57:00+00	2023-10-14 22:57:00+00
402	57	57	\N	2023-10-15 11:28:00+00	ENTREGUE	36.90	14.00	0.00	50.90	Sem cebola no burger por favor	2023-10-15 11:28:00+00	2023-10-15 11:28:00+00
403	12	86	\N	2024-02-12 22:57:00+00	CANCELADO	206.70	14.00	0.00	220.70	\N	2024-02-12 22:57:00+00	2024-02-12 22:57:00+00
404	39	39	\N	2024-02-14 13:40:00+00	ENTREGUE	62.90	11.00	0.00	73.90	Deixar na portaria com o porteiro	2024-02-14 13:40:00+00	2024-02-14 13:40:00+00
405	51	51	\N	2023-12-11 12:01:00+00	ENTREGUE	19.80	13.00	0.00	32.80	Tocar a campainha quando chegar	2023-12-11 12:01:00+00	2023-12-11 12:01:00+00
406	29	29	\N	2024-02-21 23:20:00+00	ENTREGUE	44.40	10.00	0.00	54.40	Tocar a campainha quando chegar	2024-02-21 23:20:00+00	2024-02-21 23:20:00+00
407	49	49	\N	2023-10-13 21:07:00+00	ENTREGUE	24.30	6.00	0.00	30.30	Ponto da carne ao ponto para mal	2023-10-13 21:07:00+00	2023-10-13 21:07:00+00
408	64	64	\N	2023-11-10 21:02:00+00	CANCELADO	51.90	9.00	0.00	60.90	Ponto da carne bem passado	2023-11-10 21:02:00+00	2023-11-10 21:02:00+00
409	33	33	9	2023-10-10 23:38:00+00	ENTREGUE	232.80	6.00	25.00	213.80	Ponto da carne bem passado	2023-10-10 23:38:00+00	2023-10-10 23:38:00+00
410	71	71	\N	2024-02-11 21:56:00+00	ENTREGUE	82.70	13.00	0.00	95.70	Ponto da carne ao ponto para mal	2024-02-11 21:56:00+00	2024-02-11 21:56:00+00
411	4	4	\N	2023-10-07 13:21:00+00	ENTREGUE	39.80	13.00	0.00	52.80	\N	2023-10-07 13:21:00+00	2023-10-07 13:21:00+00
412	2	81	\N	2023-12-12 21:19:00+00	ENTREGUE	111.70	10.00	0.00	121.70	Ponto da carne bem passado	2023-12-12 21:19:00+00	2023-12-12 21:19:00+00
413	7	7	5	2023-11-08 21:54:00+00	ENTREGUE	78.70	11.50	10.00	80.20	Por favor enviar bastante guardanapo	2023-11-08 21:54:00+00	2023-11-08 21:54:00+00
414	3	3	\N	2024-03-05 19:12:00+00	ENTREGUE	4.50	13.00	0.00	17.50	Sem cebola no burger por favor	2024-03-05 19:12:00+00	2024-03-05 19:12:00+00
415	9	9	\N	2023-10-19 11:58:00+00	SAIU_PARA_ENTREGA	27.40	10.00	0.00	37.40	Tocar a campainha quando chegar	2023-10-19 11:58:00+00	2023-10-19 11:58:00+00
416	11	11	\N	2023-11-19 20:59:00+00	EM_PREPARO	33.90	7.00	0.00	40.90	Ponto da carne bem passado	2023-11-19 20:59:00+00	2023-11-19 20:59:00+00
417	44	102	\N	2023-12-14 18:23:00+00	ENTREGUE	26.40	10.00	0.00	36.40	Sem cebola no burger por favor	2023-12-14 18:23:00+00	2023-12-14 18:23:00+00
418	68	68	\N	2024-01-23 23:00:00+00	ENTREGUE	81.30	14.00	0.00	95.30	Ponto da carne bem passado	2024-01-23 23:00:00+00	2024-01-23 23:00:00+00
419	72	72	1	2024-01-17 18:09:00+00	EM_PREPARO	46.40	7.00	6.96	46.44	Tocar a campainha quando chegar	2024-01-17 18:09:00+00	2024-01-17 18:09:00+00
420	78	119	\N	2023-12-19 19:56:00+00	ENTREGUE	84.30	10.50	0.00	94.80	Tocar a campainha quando chegar	2023-12-19 19:56:00+00	2023-12-19 19:56:00+00
421	3	3	\N	2023-11-06 12:54:00+00	ENTREGUE	43.80	13.00	0.00	56.80	\N	2023-11-06 12:54:00+00	2023-11-06 12:54:00+00
422	71	71	\N	2023-11-09 19:19:00+00	CANCELADO	127.10	13.00	0.00	140.10	Tocar a campainha quando chegar	2023-11-09 19:19:00+00	2023-11-09 19:19:00+00
423	68	114	\N	2023-12-05 23:23:00+00	ENTREGUE	29.90	6.00	0.00	35.90	\N	2023-12-05 23:23:00+00	2023-12-05 23:23:00+00
424	7	7	\N	2023-11-29 12:33:00+00	EM_PREPARO	24.90	11.50	0.00	36.40	Tocar a campainha quando chegar	2023-11-29 12:33:00+00	2023-11-29 12:33:00+00
425	78	78	\N	2023-11-19 22:52:00+00	ENTREGUE	25.90	13.00	0.00	38.90	Por favor enviar bastante guardanapo	2023-11-19 22:52:00+00	2023-11-19 22:52:00+00
426	22	22	\N	2023-10-28 20:38:00+00	ENTREGUE	21.90	10.00	0.00	31.90	Ponto da carne ao ponto para mal	2023-10-28 20:38:00+00	2023-10-28 20:38:00+00
427	15	15	\N	2023-11-10 21:31:00+00	EM_PREPARO	266.00	8.50	0.00	274.50	Sem cebola no burger por favor	2023-11-10 21:31:00+00	2023-11-10 21:31:00+00
428	55	55	\N	2024-01-26 21:49:00+00	ENTREGUE	47.80	8.50	0.00	56.30	Ponto da carne ao ponto para mal	2024-01-26 21:49:00+00	2024-01-26 21:49:00+00
429	13	13	\N	2024-01-06 23:03:00+00	CANCELADO	65.80	11.50	0.00	77.30	Por favor enviar bastante guardanapo	2024-01-06 23:03:00+00	2024-01-06 23:03:00+00
430	30	95	\N	2023-12-23 18:29:00+00	CANCELADO	110.70	11.50	0.00	122.20	Tocar a campainha quando chegar	2023-12-23 18:29:00+00	2023-12-23 18:29:00+00
431	17	17	\N	2023-11-03 12:08:00+00	EM_PREPARO	52.30	7.00	0.00	59.30	Por favor enviar bastante guardanapo	2023-11-03 12:08:00+00	2023-11-03 12:08:00+00
432	7	7	\N	2023-11-03 20:26:00+00	ENTREGUE	101.90	11.50	0.00	113.40	\N	2023-11-03 20:26:00+00	2023-11-03 20:26:00+00
433	13	13	\N	2024-01-11 18:16:00+00	SAIU_PARA_ENTREGA	62.90	11.50	0.00	74.40	Deixar na portaria com o porteiro	2024-01-11 18:16:00+00	2024-01-11 18:16:00+00
434	4	4	\N	2024-01-03 18:11:00+00	ENTREGUE	9.90	13.00	0.00	22.90	Por favor enviar bastante guardanapo	2024-01-03 18:11:00+00	2024-01-03 18:11:00+00
435	13	13	\N	2023-11-09 23:11:00+00	ENTREGUE	60.30	11.50	0.00	71.80	Ponto da carne bem passado	2023-11-09 23:11:00+00	2023-11-09 23:11:00+00
436	12	86	\N	2024-01-27 19:05:00+00	ENTREGUE	45.80	14.00	0.00	59.80	Ponto da carne ao ponto para mal	2024-01-27 19:05:00+00	2024-01-27 19:05:00+00
437	50	50	\N	2024-03-09 13:52:00+00	ENTREGUE	4.50	6.00	0.00	10.50	\N	2024-03-09 13:52:00+00	2024-03-09 13:52:00+00
438	25	25	1	2024-03-04 18:08:00+00	ENTREGUE	157.60	8.50	23.64	142.46	Sem cebola no burger por favor	2024-03-04 18:08:00+00	2024-03-04 18:08:00+00
439	48	48	\N	2023-10-31 23:45:00+00	EM_PREPARO	62.90	7.00	0.00	69.90	Tocar a campainha quando chegar	2023-10-31 23:45:00+00	2023-10-31 23:45:00+00
440	23	23	\N	2023-12-28 11:46:00+00	EM_PREPARO	84.20	12.00	0.00	96.20	Sem cebola no burger por favor	2023-12-28 11:46:00+00	2023-12-28 11:46:00+00
441	33	33	\N	2023-12-31 11:05:00+00	ENTREGUE	37.90	6.00	0.00	43.90	\N	2023-12-31 11:05:00+00	2023-12-31 11:05:00+00
442	18	89	\N	2023-11-23 20:40:00+00	ENTREGUE	12.00	11.50	0.00	23.50	Por favor enviar bastante guardanapo	2023-11-23 20:40:00+00	2023-11-23 20:40:00+00
443	66	113	\N	2024-01-21 13:33:00+00	ENTREGUE	9.00	8.50	0.00	17.50	Sem cebola no burger por favor	2024-01-21 13:33:00+00	2024-01-21 13:33:00+00
444	40	100	8	2023-10-18 19:48:00+00	ENTREGUE	127.30	10.00	15.28	122.02	Ponto da carne bem passado	2023-10-18 19:48:00+00	2023-10-18 19:48:00+00
445	24	24	\N	2024-01-06 23:05:00+00	ENTREGUE	129.80	10.00	0.00	139.80	Tocar a campainha quando chegar	2024-01-06 23:05:00+00	2024-01-06 23:05:00+00
447	49	49	\N	2023-12-29 20:38:00+00	ENTREGUE	23.40	6.00	0.00	29.40	Deixar na portaria com o porteiro	2023-12-29 20:38:00+00	2023-12-29 20:38:00+00
448	1	1	\N	2023-12-04 13:16:00+00	ENTREGUE	173.10	10.50	0.00	183.60	Ponto da carne bem passado	2023-12-04 13:16:00+00	2023-12-04 13:16:00+00
449	69	69	\N	2023-12-15 19:05:00+00	ENTREGUE	9.00	6.00	0.00	15.00	Sem cebola no burger por favor	2023-12-15 19:05:00+00	2023-12-15 19:05:00+00
450	12	12	\N	2023-11-30 20:21:00+00	EM_PREPARO	82.90	10.50	0.00	93.40	\N	2023-11-30 20:21:00+00	2023-11-30 20:21:00+00
451	15	15	\N	2024-01-12 22:34:00+00	ENTREGUE	62.90	8.50	0.00	71.40	Sem cebola no burger por favor	2024-01-12 22:34:00+00	2024-01-12 22:34:00+00
452	24	24	\N	2024-02-01 22:27:00+00	ENTREGUE	21.90	10.00	0.00	31.90	Sem cebola no burger por favor	2024-02-01 22:27:00+00	2024-02-01 22:27:00+00
453	23	23	\N	2024-03-07 12:57:00+00	ENTREGUE	91.80	12.00	0.00	103.80	Por favor enviar bastante guardanapo	2024-03-07 12:57:00+00	2024-03-07 12:57:00+00
454	15	15	\N	2024-03-06 21:50:00+00	ENTREGUE	192.80	8.50	0.00	201.30	\N	2024-03-06 21:50:00+00	2024-03-06 21:50:00+00
455	14	14	\N	2023-11-09 13:01:00+00	ENTREGUE	48.80	10.50	0.00	59.30	Sem cebola no burger por favor	2023-11-09 13:01:00+00	2023-11-09 13:01:00+00
456	18	89	\N	2024-01-04 22:38:00+00	EM_PREPARO	33.80	11.50	0.00	45.30	Ponto da carne ao ponto para mal	2024-01-04 22:38:00+00	2024-01-04 22:38:00+00
457	48	104	\N	2024-02-17 22:51:00+00	ENTREGUE	86.80	9.00	0.00	95.80	Ponto da carne ao ponto para mal	2024-02-17 22:51:00+00	2024-02-17 22:51:00+00
458	17	17	1	2024-02-26 11:49:00+00	ENTREGUE	47.90	7.00	7.18	47.72	Tocar a campainha quando chegar	2024-02-26 11:49:00+00	2024-02-26 11:49:00+00
459	22	22	\N	2023-11-30 23:13:00+00	ENTREGUE	152.00	10.00	0.00	162.00	Tocar a campainha quando chegar	2023-11-30 23:13:00+00	2023-11-30 23:13:00+00
460	12	12	\N	2024-02-04 12:27:00+00	CANCELADO	102.80	10.50	0.00	113.30	Por favor enviar bastante guardanapo	2024-02-04 12:27:00+00	2024-02-04 12:27:00+00
461	18	89	7	2023-10-25 21:29:00+00	ENTREGUE	86.70	11.50	5.00	93.20	Tocar a campainha quando chegar	2023-10-25 21:29:00+00	2023-10-25 21:29:00+00
462	12	12	\N	2024-01-29 11:45:00+00	CANCELADO	149.90	10.50	0.00	160.40	\N	2024-01-29 11:45:00+00	2024-01-29 11:45:00+00
463	32	32	\N	2024-02-12 23:43:00+00	ENTREGUE	99.30	10.00	0.00	109.30	Ponto da carne ao ponto para mal	2024-02-12 23:43:00+00	2024-02-12 23:43:00+00
464	28	94	\N	2023-12-11 20:48:00+00	ENTREGUE	109.70	12.00	0.00	121.70	Ponto da carne bem passado	2023-12-11 20:48:00+00	2023-12-11 20:48:00+00
465	11	11	\N	2024-01-02 20:54:00+00	ENTREGUE	101.30	7.00	0.00	108.30	Ponto da carne bem passado	2024-01-02 20:54:00+00	2024-01-02 20:54:00+00
466	64	64	\N	2023-10-25 18:54:00+00	ENTREGUE	24.90	9.00	0.00	33.90	Ponto da carne ao ponto para mal	2023-10-25 18:54:00+00	2023-10-25 18:54:00+00
467	55	55	4	2024-02-17 18:10:00+00	ENTREGUE	81.70	8.50	10.00	80.20	Ponto da carne ao ponto para mal	2024-02-17 18:10:00+00	2024-02-17 18:10:00+00
468	17	17	\N	2024-01-21 19:10:00+00	ENTREGUE	39.90	7.00	0.00	46.90	\N	2024-01-21 19:10:00+00	2024-01-21 19:10:00+00
469	69	69	\N	2024-01-01 18:54:00+00	ENTREGUE	127.60	6.00	0.00	133.60	Ponto da carne bem passado	2024-01-01 18:54:00+00	2024-01-01 18:54:00+00
470	25	25	\N	2024-01-19 13:40:00+00	CANCELADO	26.40	8.50	0.00	34.90	Deixar na portaria com o porteiro	2024-01-19 13:40:00+00	2024-01-19 13:40:00+00
471	19	19	\N	2023-10-30 12:38:00+00	ENTREGUE	114.70	6.00	0.00	120.70	Tocar a campainha quando chegar	2023-10-30 12:38:00+00	2023-10-30 12:38:00+00
472	12	12	\N	2024-01-06 23:22:00+00	ENTREGUE	16.90	10.50	0.00	27.40	\N	2024-01-06 23:22:00+00	2024-01-06 23:22:00+00
473	12	86	2	2024-03-06 11:23:00+00	ENTREGUE	178.20	14.00	17.82	174.38	Sem cebola no burger por favor	2024-03-06 11:23:00+00	2024-03-06 11:23:00+00
474	72	72	\N	2024-01-13 20:33:00+00	CANCELADO	58.90	7.00	0.00	65.90	Ponto da carne ao ponto para mal	2024-01-13 20:33:00+00	2024-01-13 20:33:00+00
475	13	13	\N	2024-01-02 21:28:00+00	EM_PREPARO	182.60	11.50	0.00	194.10	Deixar na portaria com o porteiro	2024-01-02 21:28:00+00	2024-01-02 21:28:00+00
476	18	89	\N	2023-10-24 19:27:00+00	ENTREGUE	81.20	11.50	0.00	92.70	Ponto da carne ao ponto para mal	2023-10-24 19:27:00+00	2023-10-24 19:27:00+00
477	36	36	3	2023-12-13 22:51:00+00	ENTREGUE	107.30	14.00	15.00	106.30	Ponto da carne bem passado	2023-12-13 22:51:00+00	2023-12-13 22:51:00+00
478	11	11	\N	2024-01-04 23:36:00+00	ENTREGUE	9.50	7.00	0.00	16.50	Ponto da carne ao ponto para mal	2024-01-04 23:36:00+00	2024-01-04 23:36:00+00
479	1	1	\N	2023-12-11 12:27:00+00	ENTREGUE	49.90	10.50	0.00	60.40	Deixar na portaria com o porteiro	2023-12-11 12:27:00+00	2023-12-11 12:27:00+00
480	78	78	\N	2023-11-29 21:41:00+00	EM_PREPARO	104.80	13.00	0.00	117.80	Ponto da carne ao ponto para mal	2023-11-29 21:41:00+00	2023-11-29 21:41:00+00
\.


--
-- Data for Name: produtos; Type: TABLE DATA; Schema: baha_lanches; Owner: -
--

COPY baha_lanches.produtos (id, categoria_id, nome, descricao, preco, custo_producao, disponivel, created_at, updated_at) FROM stdin;
1	1	Smash Classic	Pão brioche, 1x smash burger 100g, american cheese fatiado, picles e maionese da casa.	24.90	8.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
2	1	Double Smash Cheddar	Pão brioche, 2x smash burgers 100g, cheddar melt inglês duplo e cebola grelhada.	32.90	12.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
3	1	Smash Bacon Lovers	Pão brioche, 2x smash 100g, cheddar inglês, fatias crocantes de bacon defumado e maionese.	36.90	13.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
4	1	Triple Smash Monster	Pão brioche, 3x smash 100g, triplo cheddar, fatias de bacon e cebola crispy.	42.90	16.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
5	2	Baha Burger Costela	Blend artesanal de costela 180g, queijo gouda derretido, cebola caramelizada e rúcula.	39.90	14.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
6	2	Grand Picanha Burger	Blend suculento de picanha 180g, queijo prato, vinagrete especial da casa e farofa de bacon.	44.90	16.80	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
7	2	Blue Cheese & Bacon	Blend bovino 180g, creme de queijo gorgonzola, bacon caramelizado no melaço e agrião fresco.	41.90	15.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
8	2	Crispy Chicken Baha	Sobrecoxa desossada empanada ultra crocante, salada coleslaw americana e molho honey mustard.	34.90	11.20	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
9	2	Veggie Mushroom Burger	Burger artesanal de cogumelos e grão de bico, queijo brie maçaricado e tomate confit.	37.90	13.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
10	3	Combo Solo Smash	Double Smash Cheddar + Batata Frita Palito Individual + Coca-Cola Lata 350ml.	46.90	17.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
11	3	Combo Duplo Clássico	2x Smash Classic + 2x Batatas Fritas Individuais + 2x Refrigerantes Lata à escolha.	82.90	29.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
12	3	Combo Costela Gourmet	Baha Burger Costela + Batata Rústica com Alecrim + Cerveja IPA Artesanal Baha 355ml.	62.90	22.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
13	3	Combo Galera Baha	2x Smash Bacon + 2x Baha Costela + 2x Batatas Grandes Cheddar & Bacon + 4x Refrigerantes.	149.90	54.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
14	4	Batata Frita Tradicional	Porção 250g de batatas fininhas, douradas, sequinhas e crocantes temperadas com sal fino.	18.90	5.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
15	4	Batata Rústica Alecrim	Porção 300g cortada rústica com casca, finalizada com alecrim fresco e flor de sal.	22.90	6.80	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
16	4	Batata Baha Cheddar & Bacon	Batata rústica 350g coberta com calda quente de queijo cheddar inglês e farofa crocante de bacon.	29.90	9.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
17	4	Onion Rings Crocantes	12 anéis de cebola selecionados empanados na farinha panko, servidos com molho barbecue.	24.90	7.20	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
18	4	Dadinhos de Tapioca Coalho	10 unidades douradas de dadinhos de tapioca com queijo coalho e geleia de pimenta defumada.	26.90	8.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
19	4	Coxinhas de Frango Cremosas	8 mini coxinhas sem massa, 100% recheadas de frango desfiado com requeijão cremoso.	28.90	9.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
20	5	Coca-Cola Original 350ml	Lata 350ml estupidamente gelada.	7.50	3.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
21	5	Coca-Cola Sem Açúcar 350ml	Lata 350ml estupidamente gelada.	7.50	3.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
22	5	Guaraná Antarctica 350ml	Lata 350ml estupidamente gelada.	7.00	2.80	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
23	5	Cerveja IPA Artesanal 355ml	Long neck artesanal de lúpulo aromático, teor alcoólico 6.2%.	16.90	7.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
24	5	Chá Mate Gelado com Limão	Garrafa 500ml de mate artesanal infusionado com suco de limão siciliano.	9.90	3.20	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
25	5	Água Mineral sem Gás 500ml	Garrafa pet 500ml.	5.00	1.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
26	5	Milkshake de Nutella e Ninho	Copo 400ml de sorvete batido com farta calda de Nutella e polvilhado de Leite Ninho.	23.90	8.50	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
27	5	Milkshake Morango Pedaços	Copo 400ml feito com sorvete de baunilha artesanal e compota natural de morangos.	21.90	7.80	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
28	6	Brownie Belga com Sorvete	Brownie denso de chocolate belga 70% servido aquecido com bola de sorvete de baunilha.	24.90	8.00	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
29	6	Pote Maionese Verde 50ml	Molho da casa com base de ervas frescas e toque de alho assado.	4.50	1.20	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
30	6	Pote Geleia de Pimenta 50ml	Geleia artesanal defumada agridoce com toque moderado de pimenta dedo-de-moça.	4.50	1.30	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
31	6	Pote Barbecue Defumado 50ml	Molho barbecue preparado artesanalmente com açúcar mascavo e fumaça líquida.	4.50	1.20	t	2026-11-01 23:30:01.516593+00	2026-11-01 23:30:01.516593+00
\.


--
-- Name: avaliacoes_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.avaliacoes_id_seq', 243, true);


--
-- Name: bairros_entrega_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.bairros_entrega_id_seq', 22, true);


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.categorias_id_seq', 6, true);


--
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.clientes_id_seq', 80, true);


--
-- Name: cupons_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.cupons_id_seq', 10, true);


--
-- Name: enderecos_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.enderecos_id_seq', 120, true);


--
-- Name: grupos_entrega_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.grupos_entrega_id_seq', 4, true);


--
-- Name: ingredientes_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.ingredientes_id_seq', 12, true);


--
-- Name: item_adicionais_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.item_adicionais_id_seq', 237, true);


--
-- Name: itens_pedido_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.itens_pedido_id_seq', 1047, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.migrations_id_seq', 15, true);


--
-- Name: pagamentos_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.pagamentos_id_seq', 480, true);


--
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.pedidos_id_seq', 480, true);


--
-- Name: produtos_id_seq; Type: SEQUENCE SET; Schema: baha_lanches; Owner: -
--

SELECT pg_catalog.setval('baha_lanches.produtos_id_seq', 31, true);


--
-- Name: avaliacoes avaliacoes_pedido_id_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.avaliacoes
    ADD CONSTRAINT avaliacoes_pedido_id_unique UNIQUE (pedido_id);


--
-- Name: avaliacoes avaliacoes_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.avaliacoes
    ADD CONSTRAINT avaliacoes_pkey PRIMARY KEY (id);


--
-- Name: bairros_entrega bairros_entrega_bairro_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.bairros_entrega
    ADD CONSTRAINT bairros_entrega_bairro_unique UNIQUE (bairro);


--
-- Name: bairros_entrega bairros_entrega_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.bairros_entrega
    ADD CONSTRAINT bairros_entrega_pkey PRIMARY KEY (id);


--
-- Name: categorias categorias_nome_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.categorias
    ADD CONSTRAINT categorias_nome_unique UNIQUE (nome);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: clientes clientes_cpf_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.clientes
    ADD CONSTRAINT clientes_cpf_unique UNIQUE (cpf);


--
-- Name: clientes clientes_email_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.clientes
    ADD CONSTRAINT clientes_email_unique UNIQUE (email);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: cupons cupons_codigo_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.cupons
    ADD CONSTRAINT cupons_codigo_unique UNIQUE (codigo);


--
-- Name: cupons cupons_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.cupons
    ADD CONSTRAINT cupons_pkey PRIMARY KEY (id);


--
-- Name: enderecos enderecos_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.enderecos
    ADD CONSTRAINT enderecos_pkey PRIMARY KEY (id);


--
-- Name: grupos_entrega grupos_entrega_nome_grupo_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.grupos_entrega
    ADD CONSTRAINT grupos_entrega_nome_grupo_unique UNIQUE (nome_grupo);


--
-- Name: grupos_entrega grupos_entrega_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.grupos_entrega
    ADD CONSTRAINT grupos_entrega_pkey PRIMARY KEY (id);


--
-- Name: ingredientes ingredientes_nome_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.ingredientes
    ADD CONSTRAINT ingredientes_nome_unique UNIQUE (nome);


--
-- Name: ingredientes ingredientes_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.ingredientes
    ADD CONSTRAINT ingredientes_pkey PRIMARY KEY (id);


--
-- Name: item_adicionais item_adicionais_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.item_adicionais
    ADD CONSTRAINT item_adicionais_pkey PRIMARY KEY (id);


--
-- Name: itens_pedido itens_pedido_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.itens_pedido
    ADD CONSTRAINT itens_pedido_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: pagamentos pagamentos_pedido_id_unique; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pagamentos
    ADD CONSTRAINT pagamentos_pedido_id_unique UNIQUE (pedido_id);


--
-- Name: pagamentos pagamentos_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pagamentos
    ADD CONSTRAINT pagamentos_pkey PRIMARY KEY (id);


--
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);


--
-- Name: produtos produtos_pkey; Type: CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);


--
-- Name: idx_gabriel_data_pedido_pedidos; Type: INDEX; Schema: baha_lanches; Owner: -
--

CREATE INDEX idx_gabriel_data_pedido_pedidos ON baha_lanches.pedidos USING btree (data_pedido);


--
-- Name: idx_gabriel_id_cliente_pedidos; Type: INDEX; Schema: baha_lanches; Owner: -
--

CREATE INDEX idx_gabriel_id_cliente_pedidos ON baha_lanches.pedidos USING btree (cliente_id);


--
-- Name: idx_gabriel_id_pedido_itens_pedido; Type: INDEX; Schema: baha_lanches; Owner: -
--

CREATE INDEX idx_gabriel_id_pedido_itens_pedido ON baha_lanches.itens_pedido USING btree (pedido_id);


--
-- Name: idx_pedidos_abertos_data; Type: INDEX; Schema: baha_lanches; Owner: -
--

CREATE INDEX idx_pedidos_abertos_data ON baha_lanches.pedidos USING btree (data_pedido) WHERE ((status)::text = ANY ((ARRAY['RECEBIDO'::character varying, 'EM_PREPARO'::character varying, 'PRONTO'::character varying, 'SAIU_PARA_ENTREGA'::character varying])::text[]));


--
-- Name: uq_enderecos_cliente_principal; Type: INDEX; Schema: baha_lanches; Owner: -
--

CREATE UNIQUE INDEX uq_enderecos_cliente_principal ON baha_lanches.enderecos USING btree (cliente_id) WHERE e_principal;


--
-- Name: item_adicionais trg_adicionais_recalcular_total; Type: TRIGGER; Schema: baha_lanches; Owner: -
--

CREATE TRIGGER trg_adicionais_recalcular_total AFTER INSERT OR DELETE OR UPDATE ON baha_lanches.item_adicionais FOR EACH ROW EXECUTE FUNCTION baha_lanches.fn_trg_recalcular_total_pedido();


--
-- Name: itens_pedido trg_itens_recalcular_total; Type: TRIGGER; Schema: baha_lanches; Owner: -
--

CREATE TRIGGER trg_itens_recalcular_total AFTER INSERT OR DELETE OR UPDATE ON baha_lanches.itens_pedido FOR EACH ROW EXECUTE FUNCTION baha_lanches.fn_trg_recalcular_total_pedido();


--
-- Name: pedidos trg_pedidos_validar_status; Type: TRIGGER; Schema: baha_lanches; Owner: -
--

CREATE TRIGGER trg_pedidos_validar_status BEFORE UPDATE OF status ON baha_lanches.pedidos FOR EACH ROW EXECUTE FUNCTION baha_lanches.fn_trg_validar_status_pedido();


--
-- Name: avaliacoes avaliacoes_cliente_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.avaliacoes
    ADD CONSTRAINT avaliacoes_cliente_id_foreign FOREIGN KEY (cliente_id) REFERENCES baha_lanches.clientes(id);


--
-- Name: avaliacoes avaliacoes_pedido_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.avaliacoes
    ADD CONSTRAINT avaliacoes_pedido_id_foreign FOREIGN KEY (pedido_id) REFERENCES baha_lanches.pedidos(id) ON DELETE CASCADE;


--
-- Name: bairros_entrega bairros_entrega_grupo_entrega_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.bairros_entrega
    ADD CONSTRAINT bairros_entrega_grupo_entrega_id_foreign FOREIGN KEY (grupo_entrega_id) REFERENCES baha_lanches.grupos_entrega(id);


--
-- Name: enderecos enderecos_cliente_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.enderecos
    ADD CONSTRAINT enderecos_cliente_id_foreign FOREIGN KEY (cliente_id) REFERENCES baha_lanches.clientes(id) ON DELETE CASCADE;


--
-- Name: item_adicionais item_adicionais_ingrediente_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.item_adicionais
    ADD CONSTRAINT item_adicionais_ingrediente_id_foreign FOREIGN KEY (ingrediente_id) REFERENCES baha_lanches.ingredientes(id);


--
-- Name: item_adicionais item_adicionais_item_pedido_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.item_adicionais
    ADD CONSTRAINT item_adicionais_item_pedido_id_foreign FOREIGN KEY (item_pedido_id) REFERENCES baha_lanches.itens_pedido(id) ON DELETE CASCADE;


--
-- Name: itens_pedido itens_pedido_pedido_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.itens_pedido
    ADD CONSTRAINT itens_pedido_pedido_id_foreign FOREIGN KEY (pedido_id) REFERENCES baha_lanches.pedidos(id) ON DELETE CASCADE;


--
-- Name: itens_pedido itens_pedido_produto_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.itens_pedido
    ADD CONSTRAINT itens_pedido_produto_id_foreign FOREIGN KEY (produto_id) REFERENCES baha_lanches.produtos(id);


--
-- Name: pagamentos pagamentos_pedido_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pagamentos
    ADD CONSTRAINT pagamentos_pedido_id_foreign FOREIGN KEY (pedido_id) REFERENCES baha_lanches.pedidos(id) ON DELETE CASCADE;


--
-- Name: pedidos pedidos_cliente_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pedidos
    ADD CONSTRAINT pedidos_cliente_id_foreign FOREIGN KEY (cliente_id) REFERENCES baha_lanches.clientes(id);


--
-- Name: pedidos pedidos_cupom_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pedidos
    ADD CONSTRAINT pedidos_cupom_id_foreign FOREIGN KEY (cupom_id) REFERENCES baha_lanches.cupons(id);


--
-- Name: pedidos pedidos_endereco_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.pedidos
    ADD CONSTRAINT pedidos_endereco_id_foreign FOREIGN KEY (endereco_id) REFERENCES baha_lanches.enderecos(id);


--
-- Name: produtos produtos_categoria_id_foreign; Type: FK CONSTRAINT; Schema: baha_lanches; Owner: -
--

ALTER TABLE ONLY baha_lanches.produtos
    ADD CONSTRAINT produtos_categoria_id_foreign FOREIGN KEY (categoria_id) REFERENCES baha_lanches.categorias(id);


--
-- PostgreSQL database dump complete
--


