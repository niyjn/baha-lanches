# 8. API REST

API JSON para consulta e manutenção do cadastro de produtos, pensada para sistemas externos como cardápio digital, aplicativo ou totem.

| Item | Valor |
|---|---|
| URL base | `{APP_URL}/api` (local: `http://localhost:8000/api`) |
| Formato | JSON (`Content-Type: application/json`, `Accept: application/json`) |
| Autenticação | Nenhuma na versão atual. Ver [ADR-0005](adr/0005-sem-autenticacao-na-versao-atual.md). |
| Implementação | `routes/api.php` → `App\Http\Controllers\Api\ProdutoController` → `ProdutoService` → `ProdutoResource` |

## 8.1 Endpoints

| Método | Rota | Nome da rota | Descrição | Sucesso |
|---|---|---|---|---|
| `GET` | `/api/produtos` | `api.produtos.index` | Lista produtos paginados (15 por página), ordenados por nome | `200` |
| `POST` | `/api/produtos` | `api.produtos.store` | Cria um produto | `201` |
| `GET` | `/api/produtos/{id}` | `api.produtos.show` | Consulta um produto | `200` |
| `PUT` | `/api/produtos/{id}` | `api.produtos.update` | Atualiza o produto inteiro | `200` |
| `PATCH` | `/api/produtos/{id}` | `api.produtos.update` | Atualiza só os campos enviados | `200` |
| `DELETE` | `/api/produtos/{id}` | `api.produtos.destroy` | Exclui um produto | `204` |

## 8.2 Representação do produto

```json
{
  "id": 12,
  "nome": "X-Bacon",
  "descricao": "Pão, hambúrguer, queijo e bacon",
  "preco": 28.9,
  "custo_producao": 11.5,
  "disponivel": true,
  "categoria_id": 1,
  "categoria": "Lanches",
  "criado_em": "2026-11-01T23:15:08-03:00",
  "atualizado_em": "2026-11-01T23:15:08-03:00"
}
```

| Campo | Tipo | Observação |
|---|---|---|
| `preco`, `custo_producao` | número | Convertidos para `float` no JSON. |
| `categoria` | string | Nome da categoria. Aparece só quando a categoria foi carregada (listagem e consulta). |
| `criado_em`, `atualizado_em` | string ISO 8601 | Podem ser `null` em registros legados. |

A listagem segue o formato padrão de paginação do Laravel:

```json
{
  "data": [ { "id": 12, "nome": "X-Bacon", "...": "..." } ],
  "links": { "first": "...", "last": "...", "prev": null, "next": "..." },
  "meta": { "current_page": 1, "per_page": 15, "total": 31, "...": "..." }
}
```

Use `?page=N` para navegar entre as páginas.

## 8.3 Corpo das requisições de escrita

| Campo | `POST` / `PUT` | `PATCH` | Validação |
|---|---|---|---|
| `categoria_id` | obrigatório | opcional | inteiro, categoria existente |
| `nome` | obrigatório | opcional | texto, até 100 caracteres |
| `descricao` | opcional | opcional | texto ou `null` |
| `preco` | obrigatório | opcional | número entre 0 e 99.999.999,99 |
| `custo_producao` | obrigatório | opcional | número entre 0 e 99.999.999,99 |
| `disponivel` | opcional (padrão `true`) | opcional | booleano |

Exemplo:

```bash
curl -X POST http://localhost:8000/api/produtos \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"categoria_id": 1, "nome": "Suco de Laranja", "preco": 9.00, "custo_producao": 3.00}'
```

Marcar um produto como indisponível sem reenviar os outros campos:

```bash
curl -X PATCH http://localhost:8000/api/produtos/12 \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"disponivel": false}'
```

## 8.4 Erros

| Status | Quando | Corpo |
|---|---|---|
| `404 Not Found` | Produto inexistente | `{"message": "..."}` |
| `409 Conflict` | Exclusão de produto que já aparece em pedidos | `{"message": "Produto já vendido não pode ser excluído. Marque-o como indisponível."}` |
| `422 Unprocessable Content` | Falha de validação | `{"message": "...", "errors": {"campo": ["mensagem"]}}` |
| `500 Internal Server Error` | Erro inesperado | `{"message": "Server Error"}` (detalhes só com `APP_DEBUG=true`) |

Toda rota em `api/*` responde em JSON, mesmo sem o cabeçalho `Accept`, por causa da configuração `shouldRenderJsonWhen` em `bootstrap/app.php`.

## 8.5 Limitações conhecidas

- Não há autenticação nem limite de requisições (*rate limiting*). Antes de expor a API publicamente, é preciso adicionar ao menos um token de acesso (por exemplo, Laravel Sanctum).
- Não há filtros na listagem (por categoria ou disponibilidade); o cliente precisa filtrar do lado dele.
- A API cobre apenas produtos. Pedidos, clientes e cupons só são acessíveis pelas telas.
