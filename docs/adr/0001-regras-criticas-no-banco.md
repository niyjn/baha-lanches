# 0001. Regras críticas de pedido implementadas no PostgreSQL

- **Status:** Aceita
- **Data:** 01/11/2026 (registrada em 03/11/2026)

## Contexto

O sistema nasceu de um projeto de banco de dados, e o PostgreSQL já concentrava a modelagem e as consultas do negócio. Os valores do pedido (subtotal, desconto e total) dependem de várias tabelas (`itens_pedido`, `item_adicionais`, `cupons`, `pagamentos`) e precisam continuar corretos mesmo quando os dados são alterados fora da aplicação, por exemplo em scripts SQL de carga, correção ou migração.

## Decisão

Implementar no banco, em `database/sql/02_objetos.sql`:

- o cálculo de subtotal, desconto e total (`fn_subtotal_pedido`, `fn_calcular_desconto_cupom`) e o recálculo automático por triggers;
- as operações que alteram vários registros de forma atômica (`sp_aplicar_cupom`, `sp_cancelar_pedido`);
- as proteções de estado (pedido encerrado não muda; pedido pago não muda itens nem cupom).

O PHP valida a entrada, orquestra o fluxo em transação e traduz os `RAISE EXCEPTION` (SQLSTATE `P0001`) em `RegraNegocioException`.

## Consequências

**Positivas**

- Os totais ficam corretos independentemente de quem altera os dados.
- As regras não podem ser contornadas por outro caminho de escrita (outro controller, `tinker`, script SQL).
- Bloqueios `FOR UPDATE` dentro das procedures tratam concorrência no mesmo pedido.

**Negativas**

- Parte da lógica fica fora do PHP; quem lê só o código Laravel não enxerga as regras completas. Mitigado por [Objetos do banco](../04-objetos-do-banco.md) e [Regras de negócio](../05-regras-de-negocio.md).
- Os testes precisam de um PostgreSQL real; não é possível usar SQLite em memória.
- Alterar uma regra exige editar o SQL e criar uma migration que reexecute `02_objetos.sql`.
- Mensagens de erro ficam no SQL e são exibidas ao usuário como estão.
