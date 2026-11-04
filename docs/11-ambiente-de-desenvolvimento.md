# 11. Ambiente de desenvolvimento

## 11.1 Requisitos

| Ferramenta | Versão | Observação |
|---|---|---|
| PHP | 8.3 ou superior | Extensões `pdo_pgsql`, `pgsql` e `openssl` habilitadas |
| Composer | 2.x | |
| PostgreSQL | 18 | Neon (nuvem) ou local |
| `psql` | compatível com o servidor | Para criar o schema e rodar os scripts SQL |
| Docker | opcional | Alternativa para subir um PostgreSQL local |

Não há etapa de build de front-end: Bootstrap e a fonte são carregados por CDN e o CSS próprio fica em `public/css/app.css`.

## 11.2 Instalação

```bash
git clone https://github.com/niyjn/baha-lanches.git
cd baha-lanches
composer install
cp .env.example .env
php artisan key:generate
```

Preencha as variáveis de banco do `.env` (seção 11.3) e, em um banco vazio:

```bash
psql "$DATABASE_URL" -c "CREATE SCHEMA baha_lanches"
php artisan migrate
php artisan db:seed
php artisan serve
```

A aplicação fica em `http://localhost:8000` e abre na lista de pedidos.

## 11.3 Variáveis de ambiente

| Variável | Exemplo (Neon) | Exemplo (local) | Descrição |
|---|---|---|---|
| `DB_CONNECTION` | `pgsql` | `pgsql` | Driver |
| `DB_HOST` | `ep-xxxx.sa-east-1.aws.neon.tech` | `127.0.0.1` | Host. No Neon, usar o endpoint **sem** `-pooler`. |
| `DB_PORT` | `5432` | `5432` | Porta |
| `DB_DATABASE` | `baha_lanches_DB` | `baha_lanches_DB` | Nome do banco |
| `DB_USERNAME` | `neondb_owner` | `postgres` | Usuário |
| `DB_PASSWORD` | — | — | Senha. Nunca versionar. |
| `DB_SCHEMA` | `baha_lanches` | `baha_lanches` | Vira o `search_path` da conexão |
| `DB_SSLMODE` | `require` | `disable` | Uso de SSL |
| `APP_LOCALE` | `pt_BR` | `pt_BR` | Idioma |

`.env` e `.env.testing` estão no `.gitignore`. Os arquivos `.env.example` e `.env.testing.example` servem de modelo.

## 11.4 PostgreSQL local com Docker

Alternativa ao Neon para desenvolver sem internet ou sem credenciais da nuvem:

```bash
docker run -d --name baha_lanches_db \
  -e POSTGRES_PASSWORD=<senha-local> \
  -e POSTGRES_DB=baha_lanches_DB \
  -p 127.0.0.1:5433:5432 \
  postgres:18

docker exec baha_lanches_db psql -U postgres -d baha_lanches_DB -c "CREATE SCHEMA baha_lanches"
```

No `.env`: `DB_HOST=127.0.0.1`, `DB_PORT=5433`, `DB_USERNAME=postgres`, `DB_PASSWORD=<senha-local>`, `DB_SSLMODE=disable`.

Para os testes, crie um segundo banco no mesmo container e aponte o `.env.testing` para ele:

```bash
docker exec baha_lanches_db psql -U postgres -c "CREATE DATABASE baha_lanches_test"
docker exec baha_lanches_db psql -U postgres -d baha_lanches_test -c "CREATE SCHEMA baha_lanches"
```

Depois de reiniciar a máquina, basta `docker start baha_lanches_db`.

## 11.5 Comandos úteis

| Comando | Para quê |
|---|---|
| `php artisan route:list --except-vendor` | Lista todas as rotas da aplicação |
| `php artisan migrate:status` | Mostra quais migrations já rodaram |
| `php artisan config:show database.connections.pgsql` | Confere para qual banco o `.env` aponta |
| `php artisan tinker` | Console interativo com os models |
| `php artisan test` | Executa a suíte de testes ([Testes](10-testes.md)) |
| `./vendor/bin/pint` | Formata o código no padrão do Laravel |

## 11.6 Problemas comuns

| Sintoma | Causa provável | Solução |
|---|---|---|
| `could not find driver` | Extensão `pdo_pgsql` desabilitada | Habilitar `pdo_pgsql` e `pgsql` no `php.ini` |
| `Call to undefined function openssl_cipher_iv_length()` | PHP sem a extensão `openssl` (comum quando há mais de um PHP instalado) | Usar o PHP com `openssl` habilitado ou habilitar a extensão; conferir com `php -m` |
| `relation "pedidos" does not exist` | Schema `baha_lanches` não criado ou `DB_SCHEMA` errado | Criar o schema e conferir `DB_SCHEMA` |
| `Não há entrega para o bairro ...` ao criar pedido | Endereço em bairro que não está em `bairros_entrega` | Rodar o seed ou cadastrar o bairro |
| Testes falham com "Crie o .env.testing..." | `.env.testing` não existe | Seguir a seção 10.4 de [Testes](10-testes.md) |
