# 0003. Interface server-side com Blade e Bootstrap via CDN

- **Status:** Aceita
- **Data:** 02/11/2026 (registrada em 03/11/2026)

## Contexto

As telas são formulários e listagens usados por um atendente, sem necessidade de atualização em tempo real. Para esse tipo de interface, um pipeline de front-end (Node, Vite, bundling) traria mais configuração do que benefício.

## Decisão

- Renderizar as telas no servidor com Blade, uma pasta por módulo em `resources/views`, com um layout único (`layouts/app.blade.php`).
- Carregar Bootstrap 5.3 e a fonte Poppins por CDN; estilos próprios em `public/css/app.css`.
- Usar JavaScript apenas onde é indispensável: adicionar e remover linhas de item no formulário de novo pedido (`pedidos/create.blade.php`, com `<template>`).
- Mostrar ou esconder botões de ação conforme o status do pedido, sem depender disso como regra (a regra é garantida no service e no banco).

## Consequências

**Positivas**

- Nenhuma etapa de build: `composer install` e `php artisan serve` bastam.
- Telas simples de manter e de testar com requisições HTTP (`$this->get(...)`, `$this->post(...)`).

**Negativas**

- Dependência de CDN externa; sem internet, as telas ficam sem estilo.
- Interações mais ricas (atualização automática do painel de pedidos, por exemplo) exigiriam reavaliar essa decisão.
