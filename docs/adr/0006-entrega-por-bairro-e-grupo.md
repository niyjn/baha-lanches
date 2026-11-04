# 0006. Taxa de entrega por grupo de bairros de Guarapuava

- **Status:** Aceita
- **Data:** 02/11/2026 (registrada em 03/11/2026)

## Contexto

O banco original tinha endereços de São Paulo e taxa de entrega informada manualmente. A lanchonete atende apenas Guarapuava/PR, e a taxa depende da distância entre o bairro e o restaurante.

## Decisão

- Criar `grupos_entrega` (faixas de distância com o valor da taxa) e `bairros_entrega` (bairros atendidos, cada um ligado a um grupo).
- Calcular a taxa na criação do pedido com `fn_taxa_entrega(bairro)` e gravá-la em `pedidos.taxa_entrega`.
- Restringir o cadastro de endereço aos bairros atendidos (`exists:bairros_entrega,bairro`) e fixar cidade e estado em Guarapuava/PR no `EnderecoService`.
- Migrar os endereços legados para bairros equivalentes de Guarapuava com `04_entrega_guarapuava.sql`, mantendo a taxa e o total dos pedidos antigos.

Carga inicial: 4 grupos (R$ 6,00 a R$ 9,00) e 22 bairros.

## Consequências

**Positivas**

- Mudar a taxa de uma região é uma única alteração em `grupos_entrega`.
- Pedidos antigos não mudam quando a taxa muda, porque o valor fica gravado no pedido.
- Não há como cadastrar endereço fora da área de entrega.

**Negativas**

- A ligação entre `enderecos.bairro` e `bairros_entrega.bairro` é feita pelo nome, sem chave estrangeira. Renomear um bairro exige atualizar os endereços.
- Grupos e bairros não têm tela de manutenção; mudanças são feitas por SQL.
- Atender outra cidade exigiria remover a cidade fixa do `EnderecoService` e incluir a cidade em `bairros_entrega`.
