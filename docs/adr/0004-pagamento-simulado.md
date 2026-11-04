# 0004. Pagamento registrado manualmente (simulado)

- **Status:** Aceita
- **Data:** 02/11/2026 (registrada em 03/11/2026)

## Contexto

O fluxo do pedido depende do resultado do pagamento (aprovado libera o preparo; recusado cancela). Integrar um gateway real exigiria contrato, credenciais e tratamento de retornos assíncronos, o que está fora do escopo atual.

## Decisão

- O atendente registra o resultado na tela do pedido, escolhendo o método e clicando em **Pagamento aprovado** ou **Pagamento recusado**.
- `PedidoService::registrarPagamento()` grava o pagamento com o valor total do pedido e aplica a consequência: `EM_PREPARO` se aprovado, cancelamento via `sp_cancelar_pedido` se recusado.
- Um pedido tem no máximo um pagamento (`pagamentos_pedido_id_unique`).

## Consequências

**Positivas**

- O ciclo completo do pedido pode ser exercitado e testado sem dependências externas.
- A tabela `pagamentos` e seus status já seguem o formato que um gateway usaria.

**Negativas**

- Não há conferência automática do pagamento; a informação depende do atendente.
- Não é possível tentar pagar de novo após uma recusa: o pedido é cancelado e deve ser refeito.
- O status `PENDENTE` existe no banco, mas não é usado pela aplicação. Uma integração futura com gateway deve começar por ele.
