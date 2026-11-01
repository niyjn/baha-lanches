# Baha Lanches

Sistema de pedidos de uma lanchonete fictícia, feito com Laravel e PostgreSQL (Neon) para o projeto do 2º bimestre de Banco de Dados II e Back-end.

O banco parte do trabalho do 1º bimestre e foi adaptado ao padrão do Laravel.

## Requisitos

- PHP 8.3 com as extensões `pdo_pgsql` e `pgsql`
- Composer
- Cliente do PostgreSQL (`psql`), para rodar os scripts SQL
- Banco PostgreSQL no Neon

No Windows, habilite as extensões no `php.ini`, descomentando `extension=pdo_pgsql` e `extension=pgsql`.

## Como executar

```bash
composer install
cp .env.example .env
php artisan key:generate
```

Preencha as variáveis `DB_*` do `.env` com os dados do Neon e use o endpoint direto, sem `-pooler` no host. O pooler não mantém o `search_path` entre as transações.

Em um banco vazio, crie o schema, as tabelas, os objetos e os dados:

```bash
psql "$DATABASE_URL" -c "CREATE SCHEMA baha_lanches"
php artisan migrate
php artisan db:seed
php artisan serve
```

## Banco de dados

Tudo fica no schema `baha_lanches`.

| Script em `database/sql` | Conteúdo |
|---|---|
| `00_estrutura.sql` | Estrutura completa, gerada com `pg_dump` |
| `01_ajuste_schema_laravel.sql` | Conversão do banco original do 1º bimestre para o padrão do Laravel |
| `02_objetos.sql` | Índices, functions, procedures e triggers (usado pela última migration) |
| `03_dados.sql` | Dados do sistema (usado pelo `db:seed`) |

Para criar tudo só com o `psql`, rode `00_estrutura.sql` e depois `03_dados.sql`.

### Objetos

| Tipo | Nome | Regra de negócio |
|---|---|---|
| Function | `fn_subtotal_pedido(pedido_id)` | Soma itens e adicionais do pedido |
| Function | `fn_calcular_desconto_cupom(cupom_id, subtotal, pedido_ignorado)` | Valida o cupom e calcula o desconto; retorna 0 se ele não se aplica |
| Procedure | `sp_aplicar_cupom(pedido_id, codigo)` | Aplica o cupom e atualiza o total do pedido |
| Procedure | `sp_cancelar_pedido(pedido_id)` | Cancela o pedido e ajusta os pagamentos |
| Trigger | `trg_itens_recalcular_total` | Recalcula o pedido quando um item muda |
| Trigger | `trg_adicionais_recalcular_total` | Recalcula o pedido quando um adicional muda |
| Trigger | `trg_pedidos_validar_status` | Impede mudar o status de pedido entregue ou cancelado |
| Índice | `uq_enderecos_cliente_principal` | Garante um só endereço principal por cliente |
| Índice | `idx_pedidos_abertos_data` | Agiliza a listagem de pedidos em aberto |

Exemplo de chamada pelo Laravel:

```php
DB::statement('CALL sp_cancelar_pedido(?)', [$pedido->id]);
```

### Regras para o CRUD

- Cliente ou produto com pedidos não pode ser excluído. Use `ativo` e `disponivel` para desativar.
- Pedido não deve ser excluído, porque a exclusão apaga itens, pagamento e avaliação. Use `sp_cancelar_pedido`.
- Pedido entregue ou cancelado não aceita mudança de itens nem de status.

## Testes

Os testes usam uma branch separada do Neon, porque `RefreshDatabase` apaga as tabelas do banco configurado.

```bash
cp .env.testing.example .env.testing
php artisan key:generate --env=testing
php artisan test
```

Preencha o `.env.testing` com o endpoint da branch de testes. Sem esse arquivo, os testes param antes de tocar no banco.
