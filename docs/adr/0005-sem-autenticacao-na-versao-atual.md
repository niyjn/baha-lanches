# 0005. Sem autenticação na versão atual

- **Status:** Aceita, com revisão prevista
- **Data:** 01/11/2026 (registrada em 03/11/2026)

## Contexto

O foco desta versão foi o fluxo de pedidos e as regras no banco. O escopo atual não traz requisito de login, de perfis diferentes nem de auditoria por usuário.

## Decisão

Não implementar login, perfis ou tokens nesta versão. Todas as rotas web e `/api/produtos` são públicas para quem acessa o servidor.

## Consequências

**Positivas**

- Menos código e configuração; todas as telas ficam disponíveis direto.

**Negativas e riscos**

- Qualquer pessoa com acesso à URL pode alterar dados, inclusive pela API.
- Não é possível saber quem registrou um pedido, um pagamento ou um cancelamento.
- Atendente e gerente usam as mesmas telas, sem separação de responsabilidades.

## Revisão prevista

Antes de publicar o sistema fora da rede da lanchonete:

1. Adicionar autenticação nas telas web (Laravel Breeze ou starter kit equivalente).
2. Proteger `/api/produtos` com token (Laravel Sanctum) e limite de requisições.
3. Separar os perfis atendente e gerente com *policies*.
4. Registrar o usuário responsável nas operações de pedido e pagamento.
