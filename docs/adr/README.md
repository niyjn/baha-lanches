# Registro de decisões de arquitetura (ADR)

Cada ADR (*Architecture Decision Record*) registra uma decisão técnica relevante: o contexto, o que foi decidido e as consequências. As decisões abaixo foram tomadas durante o desenvolvimento e registradas retroativamente em 03/11/2026, a partir do código e do histórico do repositório.

| ADR | Título | Status |
|---|---|---|
| [0001](0001-regras-criticas-no-banco.md) | Regras críticas de pedido implementadas no PostgreSQL | Aceita |
| [0002](0002-camada-de-services.md) | Camada de services entre controllers e models | Aceita |
| [0003](0003-interface-blade-sem-build.md) | Interface server-side com Blade e Bootstrap via CDN | Aceita |
| [0004](0004-pagamento-simulado.md) | Pagamento registrado manualmente (simulado) | Aceita |
| [0005](0005-sem-autenticacao-na-versao-atual.md) | Sem autenticação na versão atual | Aceita, com revisão prevista |
| [0006](0006-entrega-por-bairro-e-grupo.md) | Taxa de entrega por grupo de bairros de Guarapuava | Aceita |

## Modelo

Para registrar uma nova decisão, copie a estrutura abaixo em `NNNN-titulo-curto.md`:

```markdown
# NNNN. Título

- **Status:** Proposta | Aceita | Substituída por NNNN | Descartada
- **Data:** DD/MM/AAAA

## Contexto
Qual problema ou necessidade motivou a decisão.

## Decisão
O que foi decidido.

## Consequências
O que melhora, o que piora e o que passa a ser obrigatório.
```
