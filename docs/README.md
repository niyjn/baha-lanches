# Documentação técnica — Baha Lanches

Sistema de gestão de pedidos de uma lanchonete com entrega em Guarapuava/PR. A aplicação é um monólito Laravel com telas Blade, uma API REST de produtos e regras de negócio críticas implementadas no PostgreSQL.

> Última atualização: 03/11/2026

## Índice

| # | Documento | Conteúdo |
|---|---|---|
| 1 | [Visão geral](01-visao-geral.md) | Contexto, escopo, atores, glossário e stack |
| 2 | [Arquitetura](02-arquitetura.md) | Camadas, componentes, estrutura de pastas e ciclo de uma requisição |
| 3 | [Modelo de dados](03-modelo-de-dados.md) | Diagrama entidade-relacionamento, dicionário de dados e restrições |
| 4 | [Objetos do banco](04-objetos-do-banco.md) | Functions, procedures, triggers e índices do PostgreSQL |
| 5 | [Regras de negócio](05-regras-de-negocio.md) | Catálogo de regras e em que camada cada uma é garantida |
| 6 | [Casos de uso](06-casos-de-uso.md) | Diagrama UML de casos de uso e especificação de cada caso |
| 7 | [Fluxos e estados](07-fluxos-e-estados.md) | Máquinas de estado e diagramas de sequência dos fluxos principais |
| 8 | [API REST](08-api-rest.md) | Contrato da API de produtos |
| 9 | [Operação do banco](09-operacao-do-banco.md) | Scripts SQL, backup, restauração e análise de índices |
| 10 | [Testes](10-testes.md) | Estratégia, organização e execução da suíte automatizada |
| 11 | [Ambiente de desenvolvimento](11-ambiente-de-desenvolvimento.md) | Instalação, variáveis de ambiente e banco local |
| — | [Decisões de arquitetura (ADRs)](adr/README.md) | Registro das principais decisões técnicas |
| — | [Evidências](evidencias/) | Saídas de backup/restauração e de `EXPLAIN` |

## Por onde começar

- **Novo no projeto:** leia [Visão geral](01-visao-geral.md), [Arquitetura](02-arquitetura.md) e [Ambiente de desenvolvimento](11-ambiente-de-desenvolvimento.md).
- **Vai mexer em pedidos, cupons ou pagamentos:** leia [Regras de negócio](05-regras-de-negocio.md), [Objetos do banco](04-objetos-do-banco.md) e [Fluxos e estados](07-fluxos-e-estados.md). Boa parte dessas regras roda no banco, e não no PHP.
- **Vai integrar outro sistema:** leia [API REST](08-api-rest.md).

## Convenções desta documentação

- Diagramas escritos em [Mermaid](https://mermaid.js.org/), renderizados automaticamente pelo GitHub.
- Nomes de tabelas, colunas, classes e rotas aparecem em `código`, exatamente como estão no projeto.
- Regras de negócio são identificadas como `RN-XX` e casos de uso como `UC-XX`; os demais documentos fazem referência a esses códigos.
