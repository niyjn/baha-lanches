# 7. Fluxos e estados

## 7.1 Ciclo de vida do pedido

```mermaid
stateDiagram-v2
    direction LR
    [*] --> RECEBIDO : pedido criado (UC-01)

    RECEBIDO --> EM_PREPARO : pagamento aprovado (UC-03)
    RECEBIDO --> CANCELADO : pagamento recusado (UC-03)

    EM_PREPARO --> PRONTO : avançar status (UC-04)
    PRONTO --> SAIU_PARA_ENTREGA : avançar status
    SAIU_PARA_ENTREGA --> ENTREGUE : avançar status

    RECEBIDO --> CANCELADO : cancelar (UC-05)
    EM_PREPARO --> CANCELADO : cancelar
    PRONTO --> CANCELADO : cancelar
    SAIU_PARA_ENTREGA --> CANCELADO : cancelar

    ENTREGUE --> [*]
    CANCELADO --> [*]

    note right of RECEBIDO
        Único status que aceita
        cupom e pagamento
    end note
    note right of CANCELADO
        Estados finais: o trigger
        trg_pedidos_validar_status
        bloqueia qualquer mudança
    end note
```

| Status | Itens podem mudar? | Aceita cupom? | Aceita pagamento? | Ações na tela |
|---|---|---|---|---|
| `RECEBIDO` | Sim (se ainda sem pagamento) | Sim | Sim | Aplicar cupom, registrar pagamento, cancelar |
| `EM_PREPARO` | Não (já pago) | Não | Não | Avançar status, cancelar |
| `PRONTO` | Não | Não | Não | Avançar status, cancelar |
| `SAIU_PARA_ENTREGA` | Não | Não | Não | Avançar status, cancelar |
| `ENTREGUE` | Não | Não | Não | Nenhuma |
| `CANCELADO` | Não | Não | Não | Nenhuma |

## 7.2 Ciclo de vida do pagamento

```mermaid
stateDiagram-v2
    direction LR
    [*] --> APROVADO : atendente aprova
    [*] --> RECUSADO : atendente recusa
    [*] --> PENDENTE : somente dados legados

    APROVADO --> ESTORNADO : pedido cancelado
    PENDENTE --> RECUSADO : pedido cancelado

    APROVADO --> [*]
    RECUSADO --> [*]
    ESTORNADO --> [*]
```

> A aplicação nunca cria pagamentos `PENDENTE`. Esse status existe por compatibilidade com o banco do 1º bimestre e é tratado por `sp_cancelar_pedido`.

## 7.3 Sequência: registrar pedido com cupom

```mermaid
sequenceDiagram
    autonumber
    actor A as Atendente
    participant C as PedidoController
    participant S as PedidoService
    participant DB as PostgreSQL

    A->>C: POST /pedidos (endereço, itens, cupom)
    C->>S: criar(dados)
    S->>DB: BEGIN
    S->>DB: busca endereço e cliente
    alt cliente inativo
        S-->>A: "Cliente inativo não pode fazer pedidos."
    end
    S->>DB: SELECT fn_taxa_entrega(bairro)
    DB-->>S: taxa
    S->>DB: INSERT pedidos (status RECEBIDO, subtotal 0, total = taxa)
    loop cada item
        S->>DB: verifica se o produto está disponível
        S->>DB: INSERT itens_pedido (preço congelado)
        DB->>DB: trg_itens_recalcular_total
        loop cada adicional
            S->>DB: INSERT item_adicionais
            DB->>DB: trg_adicionais_recalcular_total
        end
    end
    S->>DB: CALL sp_aplicar_cupom(pedido, código)
    DB->>DB: fn_calcular_desconto_cupom
    alt cupom inválido
        DB-->>S: RAISE EXCEPTION
        S->>DB: ROLLBACK
        S-->>A: mensagem do banco, nada gravado
    end
    S->>DB: COMMIT
    S-->>C: Pedido
    C-->>A: redirect /pedidos/{id}
```

## 7.4 Sequência: registrar pagamento

```mermaid
sequenceDiagram
    autonumber
    actor A as Atendente
    participant C as PedidoController
    participant S as PedidoService
    participant DB as PostgreSQL

    A->>C: POST /pedidos/{id}/pagamento (método, aprovado)
    C->>S: registrarPagamento(pedido, método, aprovado)
    S->>DB: BEGIN
    S->>DB: SELECT ... FOR UPDATE (pedido)
    alt status diferente de RECEBIDO ou já pago
        S-->>A: "Este pedido não está aguardando pagamento."
    end
    S->>DB: INSERT pagamentos (valor = valor_total)
    alt aprovado
        S->>DB: UPDATE pedidos SET status = EM_PREPARO
        DB->>DB: trg_pedidos_validar_status
    else recusado
        S->>DB: CALL sp_cancelar_pedido(id)
        DB->>DB: pedido CANCELADO, pagamento RECUSADO
    end
    S->>DB: COMMIT
    C-->>A: redirect /pedidos/{id}
```

## 7.5 Sequência: cancelar pedido pago

```mermaid
sequenceDiagram
    autonumber
    actor A as Atendente
    participant S as PedidoService
    participant DB as PostgreSQL

    A->>S: cancelar(pedido)
    S->>DB: CALL sp_cancelar_pedido(id)
    DB->>DB: SELECT status FOR UPDATE
    alt ENTREGUE ou CANCELADO
        DB-->>S: RAISE "Pedido N já está encerrado (STATUS)"
        S-->>A: mensagem de erro
    end
    DB->>DB: UPDATE pedidos SET status = CANCELADO
    DB->>DB: UPDATE pagamentos APROVADO → ESTORNADO
    DB-->>S: ok
    S-->>A: "Pedido cancelado."
```

## 7.6 Atividade: cadastro de endereço

```mermaid
flowchart TD
    inicio([Atendente envia o formulário]) --> valida{"Bairro atendido<br/>e CEP válido?"}
    valida -- não --> erroValidacao([Volta com erros de validação])
    valida -- sim --> principal{"Marcado como<br/>principal?"}
    principal -- sim --> desmarca["Desmarca o principal anterior do cliente"]
    principal -- não --> grava
    desmarca --> grava["Grava com cidade Guarapuava e estado PR"]
    grava --> fim([Volta ao detalhe do cliente])
```

Na edição, se o endereço já foi usado em algum pedido, qualquer mudança além de `e_principal` é recusada com "Endereço já usado em pedidos não pode ser alterado. Cadastre um novo."
