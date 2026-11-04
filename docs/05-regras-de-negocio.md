# 5. Regras de negócio

Catálogo das regras implementadas. A coluna **Garantida em** mostra onde a regra é aplicada; quando aparecem duas camadas, a segunda é a barreira final.

Legenda: **Req** = Form Request · **Svc** = Service · **BD** = PostgreSQL · **UI** = só a tela (não é garantia).

## 5.1 Pedidos

| Código | Regra | Garantida em |
|---|---|---|
| RN-01 | Todo pedido precisa de ao menos um item, com quantidade ≥ 1. Linhas em branco do formulário são ignoradas. | Req (`PedidoRequest`) · BD (`CHECK quantidade > 0`) |
| RN-02 | Cliente inativo não pode fazer pedidos. | Svc (`PedidoService::criar`) · UI (só lista clientes ativos) |
| RN-03 | Produto ou adicional indisponível não pode ser vendido. Se um item falhar, o pedido inteiro é desfeito. | Svc (transação) · UI |
| RN-04 | O preço do item e do adicional é congelado no momento da venda. | Svc (copia `preco` / `preco_adicional`) |
| RN-05 | A taxa de entrega é definida pelo grupo do bairro do endereço e fica gravada no pedido. | BD (`fn_taxa_entrega`) |
| RN-06 | Subtotal, desconto e total são sempre calculados pelo banco. | BD (triggers) |
| RN-07 | Todo pedido nasce com status `RECEBIDO` e aguardando pagamento. | Svc |
| RN-08 | Pedido pago não aceita alteração de itens nem de cupom. | BD (trigger e `sp_aplicar_cupom`) |
| RN-09 | Pedido encerrado (`ENTREGUE` ou `CANCELADO`) não muda de status nem de itens. | BD (triggers) · UI (esconde as ações) |
| RN-10 | O status avança só na sequência `EM_PREPARO → PRONTO → SAIU_PARA_ENTREGA → ENTREGUE`. `RECEBIDO` só sai pelo pagamento. | Svc (`PROXIMO_STATUS`) |
| RN-11 | Qualquer pedido aberto pode ser cancelado. | BD (`sp_cancelar_pedido`) |

## 5.2 Pagamentos

| Código | Regra | Garantida em |
|---|---|---|
| RN-12 | Cada pedido tem no máximo um pagamento, registrado só enquanto o pedido está `RECEBIDO`. | Svc (`lockForUpdate`) · BD (`UNIQUE pedido_id`) |
| RN-13 | O valor do pagamento é o `valor_total` do pedido no momento do registro. | Svc |
| RN-14 | Pagamento aprovado leva o pedido para `EM_PREPARO`. | Svc |
| RN-15 | Pagamento recusado cancela o pedido. | Svc + BD (`sp_cancelar_pedido`) |
| RN-16 | Ao cancelar um pedido, pagamento aprovado vira `ESTORNADO` e pendente vira `RECUSADO`. | BD (`sp_cancelar_pedido`) |
| RN-17 | Métodos aceitos: PIX, cartão de crédito, cartão de débito, dinheiro e vale-refeição. | Req · BD (`CHECK`) |

## 5.3 Cupons

| Código | Regra | Garantida em |
|---|---|---|
| RN-18 | O código do cupom é único e sempre gravado em maiúsculas. A aplicação aceita o código digitado em minúsculas. | Req (`CupomRequest`) · BD (`upper()` em `sp_aplicar_cupom`) |
| RN-19 | Cupom percentual vai até 100%; cupom de valor fixo nunca deixa o total abaixo da taxa de entrega (desconto limitado ao subtotal). | Req · BD (`LEAST`) |
| RN-20 | Cupom só vale se estiver ativo, dentro da validade e com subtotal ≥ valor mínimo. | BD (`fn_calcular_desconto_cupom`) |
| RN-21 | O limite de usos conta apenas pedidos não cancelados. Cancelar um pedido devolve o uso. | BD |
| RN-22 | Um pedido aceita apenas um cupom. | BD (`sp_aplicar_cupom`) |
| RN-23 | Se os itens mudarem e o subtotal ficar abaixo do mínimo, o desconto é zerado automaticamente. | BD (trigger) |

## 5.4 Clientes e endereços

| Código | Regra | Garantida em |
|---|---|---|
| RN-24 | E-mail e CPF são únicos; CPF no formato `000.000.000-00`; data de nascimento no passado. | Req · BD (`UNIQUE`) |
| RN-25 | Só é possível cadastrar endereço em bairro atendido; CEP no formato `00000-000`. | Req (`exists:bairros_entrega,bairro`) |
| RN-26 | Todo endereço é de Guarapuava/PR; cidade e estado não são informados pelo usuário. | Svc (`EnderecoService`) |
| RN-27 | Cada cliente tem no máximo um endereço principal. Marcar um novo desmarca o anterior. | Svc · BD (índice único parcial) |
| RN-28 | Endereço já usado em pedido não pode ser alterado (só pode virar ou deixar de ser principal) nem excluído. | Svc · BD (FK) |

## 5.5 Exclusões

| Código | Regra | Garantida em |
|---|---|---|
| RN-29 | Não se exclui categoria com produtos, produto já vendido, cliente com pedidos nem cupom já usado. A orientação é desativar. | BD (FK) → Svc (`CrudService::excluir`) |
| RN-30 | Excluir um cliente sem pedidos exclui também os endereços dele. | BD (`ON DELETE CASCADE`) |

## 5.6 Rastreabilidade com os testes

Cada regra tem ao menos um teste automatizado. Alguns exemplos:

| Regra | Teste |
|---|---|
| RN-03 | `PedidoTest::test_produto_indisponivel`, `test_adicional_indisponivel` |
| RN-06 | `TriggersBancoTest::test_novo_item_atualiza_o_total` |
| RN-10 | `PedidoTest::test_avancar_status_ate_entregue`, `test_nao_avanca_sem_pagamento` |
| RN-12 | `PedidoTest::test_nao_paga_duas_vezes` |
| RN-16 | `ProceduresBancoTest::test_cancelar_estorna_pagamento_aprovado` |
| RN-21 | `FuncoesBancoTest::test_limite_de_usos_do_cupom` |
| RN-23 | `TriggersBancoTest::test_desconto_recalcula_quando_muda_item` |
| RN-28 | `EnderecoTest::test_nao_edita_endereco_com_pedido`, `test_endereco_com_pedido_pode_virar_principal` |
| RN-29 | `ProdutoTest::test_nao_exclui_produto_vendido`, `ClienteTest::test_nao_exclui_cliente_com_pedido` |

A lista completa de testes está em [Testes](10-testes.md).
