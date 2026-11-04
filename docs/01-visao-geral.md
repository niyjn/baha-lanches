# 1. Visão geral

## 1.1 Contexto

A Baha Lanches é uma lanchonete com entrega em domicílio na cidade de Guarapuava/PR. O sistema substitui o controle manual de pedidos e centraliza:

- o cadastro de clientes e seus endereços de entrega;
- o cardápio (categorias, produtos e ingredientes adicionais);
- os cupons de desconto;
- o ciclo de vida do pedido, da criação até a entrega ou o cancelamento, incluindo o pagamento.

O banco de dados nasceu em um projeto anterior (1º bimestre), com outra convenção de nomes, e foi convertido para o padrão do Laravel. O histórico dessa migração está em [Operação do banco](09-operacao-do-banco.md#93-migração-do-banco-legado).

## 1.2 Escopo

### Dentro do escopo

| Módulo | Funcionalidades |
|---|---|
| Pedidos | Listagem com filtro por status, criação com itens e adicionais, aplicação de cupom, registro de pagamento, avanço de status e cancelamento |
| Clientes | CRUD de clientes e cadastro de endereços de entrega |
| Cardápio | CRUD de categorias e produtos |
| Cupons | CRUD de cupons percentuais e de valor fixo |
| Integração | API REST de produtos (`/api/produtos`) |

### Fora do escopo (estado atual)

- **Autenticação e perfis de acesso:** todas as telas e a API são abertas. Ver [ADR-0005](adr/0005-sem-autenticacao-na-versao-atual.md).
- **Gateway de pagamento real:** o pagamento é simulado. O atendente registra se foi aprovado ou recusado. Ver [ADR-0004](adr/0004-pagamento-simulado.md).
- **Cadastro de ingredientes, grupos e bairros de entrega:** esses dados vêm dos scripts SQL e não têm tela própria.
- **Registro de avaliações:** a tabela `avaliacoes` existe e é exibida no detalhe do pedido, mas os dados vêm da carga inicial. Não há tela para registrar uma avaliação.

## 1.3 Atores

| Ator | Tipo | Descrição |
|---|---|---|
| Atendente | Primário, humano | Funcionário da lanchonete que opera todas as telas: cadastra clientes, monta pedidos, registra pagamentos e acompanha a entrega. |
| Gerente | Primário, humano | Mantém o cardápio e os cupons. Hoje usa as mesmas telas do atendente, já que não há perfis de acesso. |
| Sistema integrador | Primário, sistema | Qualquer sistema externo (cardápio digital, app, totem) que consome a API REST de produtos. |
| PostgreSQL | Secundário, sistema | Executa as regras de cálculo e de consistência por meio de functions, procedures e triggers. |

## 1.4 Glossário

| Termo | Significado |
|---|---|
| Adicional | Ingrediente extra cobrado à parte em um item do pedido (ex.: bacon, cheddar). Tabela `item_adicionais`. |
| Bairro atendido | Bairro de Guarapuava com entrega, cadastrado em `bairros_entrega`. Só é possível cadastrar endereços nesses bairros. |
| Grupo de entrega | Faixa de distância do restaurante que define a taxa de entrega (`grupos_entrega`). Cada bairro pertence a um grupo. |
| Pedido aberto | Pedido com status `RECEBIDO`, `EM_PREPARO`, `PRONTO` ou `SAIU_PARA_ENTREGA`. |
| Pedido encerrado | Pedido com status `ENTREGUE` ou `CANCELADO`. Não aceita mais alterações. |
| Endereço principal | Endereço padrão do cliente. Cada cliente tem no máximo um. |
| Estorno | Situação do pagamento aprovado de um pedido que depois foi cancelado (`ESTORNADO`). |
| Regra de negócio (exceção) | Violação de regra levantada pelo PHP ou pelo banco e mostrada ao usuário como mensagem amigável (`RegraNegocioException`). |

## 1.5 Stack tecnológica

| Camada | Tecnologia | Versão |
|---|---|---|
| Linguagem | PHP | 8.3 ou superior |
| Framework | Laravel | 13 |
| Banco de dados | PostgreSQL (Neon em produção) | 18 |
| Linguagem procedural do banco | PL/pgSQL | — |
| Interface | Blade + Bootstrap 5.3 (via CDN) + fonte Poppins | — |
| Testes | PHPUnit | 12 |
| Gerenciador de dependências | Composer | 2 |

## 1.6 Números da base de demonstração

A carga de `database/sql/03_dados.sql`, usada pelo seeder, contém:

| Tabela | Registros |
|---|---|
| `clientes` | 80 |
| `enderecos` | 120 |
| `categorias` | 6 |
| `produtos` | 31 |
| `ingredientes` | 12 |
| `cupons` | 10 |
| `grupos_entrega` / `bairros_entrega` | 4 / 22 |
| `pedidos` / `pagamentos` | 480 / 480 |
| `itens_pedido` / `item_adicionais` | 1047 / 237 |
| `avaliacoes` | 243 |
