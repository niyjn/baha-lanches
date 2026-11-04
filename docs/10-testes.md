# 10. Testes

## 10.1 Estratégia

A suíte usa PHPUnit e testa o sistema em três níveis:

| Nível | Pasta | O que cobre | Usa banco? |
|---|---|---|---|
| Unitário | `tests/Unit` | Classes isoladas, sem subir o Laravel. Hoje: a tradução de mensagens do PostgreSQL em `RegraNegocioException`. | Não |
| Banco | `tests/Feature/Banco` | Functions, procedures, triggers e índices chamados direto por SQL. | Sim |
| Funcional | `tests/Feature` | Fluxos completos pelas rotas web e pela API: validação, regras, mensagens e o que fica gravado. | Sim |

Como boa parte das regras está no PostgreSQL ([ADR-0001](adr/0001-regras-criticas-no-banco.md)), os testes rodam contra um **PostgreSQL de verdade**, com as mesmas migrations do sistema. Não é usado SQLite em memória, porque ele não executaria as functions e triggers.

## 10.2 Isolamento

- Todos os testes de `Feature` usam o trait `RefreshDatabase`: na primeira execução as migrations recriam o schema; depois, cada teste roda dentro de uma transação desfeita no final. Um teste nunca enxerga dados de outro.
- Cada teste cria só os dados de que precisa, com o helper `tests/Concerns/CriaDadosDoLanche.php`. O projeto não usa o seeder nos testes, para que os valores esperados fiquem visíveis dentro de cada teste.
- `tests/TestCase.php` interrompe a suíte se não existir `.env.testing`, evitando que os testes rodem contra o banco configurado no `.env`.

### Helper `CriaDadosDoLanche`

| Método | Cria |
|---|---|
| `criarBairro($nome, $taxa)` | Grupo e bairro de entrega (padrão: Centro, R$ 5,00) |
| `criarCliente($dados)` | Cliente ativo com e-mail e CPF únicos |
| `criarEndereco($cliente, $dados)` | Endereço em Guarapuava/PR |
| `criarCategoria($dados)` | Categoria ativa |
| `criarProduto($dados)` | Produto disponível de R$ 20,00 |
| `criarIngrediente($dados)` | Adicional de R$ 3,00 |
| `criarCupom($dados)` | Cupom `DESC10`, 10%, válido por 1 mês |
| `criarPedido($endereco, $itens, $cupom)` | Pedido criado pelo `PedidoService`; padrão: 2 × R$ 20,00 + R$ 5,00 de entrega = R$ 45,00 |

## 10.3 Inventário

| Arquivo | Testes | Cobertura |
|---|---|---|
| `Unit/RegraNegocioExceptionTest.php` | 3 | Extração da mensagem do `RAISE EXCEPTION`, mensagem padrão e preservação do erro original |
| `Feature/Banco/FuncoesBancoTest.php` | 9 | `fn_taxa_entrega`, `fn_subtotal_pedido`, `fn_calcular_desconto_cupom` |
| `Feature/Banco/ProceduresBancoTest.php` | 11 | `sp_aplicar_cupom`, `sp_cancelar_pedido` |
| `Feature/Banco/TriggersBancoTest.php` | 9 | Recálculo de totais, bloqueios por status e pagamento, endereço principal único |
| `Feature/PedidoTest.php` | 23 | UC-01 a UC-06 |
| `Feature/ProdutoTest.php` | 7 | CRUD web de produtos |
| `Feature/Api/ProdutoApiTest.php` | 9 | Contrato da API, códigos `200`, `201`, `204`, `404`, `409` e `422` |
| `Feature/ClienteTest.php` | 8 | CRUD de clientes e validações |
| `Feature/EnderecoTest.php` | 9 | Cadastro, edição e exclusão de endereços |
| `Feature/CategoriaTest.php` | 5 | CRUD de categorias |
| `Feature/CupomTest.php` | 7 | CRUD de cupons e validações |
| **Total** | **100** | |

A relação entre regras de negócio e testes está em [Regras de negócio](05-regras-de-negocio.md#56-rastreabilidade-com-os-testes).

## 10.4 Como executar

Pré-requisito: um banco PostgreSQL **exclusivo para testes**, com o schema `baha_lanches` criado.

```bash
cp .env.testing.example .env.testing
php artisan key:generate --env=testing
```

Preencha as variáveis `DB_*` do `.env.testing` com o banco de testes e confira para onde elas apontam antes da primeira execução:

```bash
php artisan config:show database.connections.pgsql --env=testing
```

Executar:

```bash
php artisan test                                   # suíte completa
php artisan test --testsuite=Unit                  # só unitários
php artisan test tests/Feature/Banco               # só objetos do banco
php artisan test --filter=PedidoTest               # uma classe
php artisan test --filter=test_pagamento_aprovado  # um teste
```

> **Atenção:** `RefreshDatabase` apaga e recria todas as tabelas do banco do `.env.testing`. Nunca aponte esse arquivo para o banco principal.

## 10.5 Convenções para novos testes

- Um arquivo por módulo em `tests/Feature`; objetos do banco em `tests/Feature/Banco`.
- Nome do método em português, minúsculo e descritivo: `test_nao_exclui_cupom_usado`. O PHPUnit exibe esse nome na saída.
- Estrutura em três blocos: prepara os dados, executa a ação e confere o resultado.
- Use os métodos de `CriaDadosDoLanche` e informe só os atributos que importam para o teste.
- Para regras que dependem do banco, confira também o estado gravado (`assertDatabaseHas`, `fresh()`), e não só a resposta HTTP.
- Ao criar uma regra nova, adicione o teste e a linha correspondente em [Regras de negócio](05-regras-de-negocio.md).
