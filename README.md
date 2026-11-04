# Baha Lanches

Sistema de pedidos de uma lanchonete, feito com Laravel e PostgreSQL (Neon). Ver `docs/` para aprofundamento.

## Como executar

Requer PHP 8.3 com as extensões `pdo_pgsql` e `pgsql` habilitadas, Composer e `psql`.

```bash
composer install
cp .env.example .env
php artisan key:generate
```

Preencha as variáveis `DB_*` do `.env` com o endpoint direto do Neon, sem `-pooler` no host.

Em um banco vazio:

```bash
psql "$DATABASE_URL" -c "CREATE SCHEMA baha_lanches"
php artisan migrate
php artisan db:seed
php artisan serve
```

## Banco de dados

Os scripts SQL ficam em `database/sql`. Os índices, functions, procedures e triggers estão em `02_objetos.sql`.

## Testes

Os testes apagam as tabelas do banco configurado, então use uma branch separada do Neon no `.env.testing`.

```bash
cp .env.testing.example .env.testing
php artisan key:generate --env=testing
php artisan test
```
