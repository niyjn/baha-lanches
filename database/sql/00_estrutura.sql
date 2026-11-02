-- Estrutura completa do banco (tabelas, índices, functions, procedures e triggers).
-- Gerado com pg_dump. Rodar antes do 03_dados.sql.

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


