# 0002. Camada de services entre controllers e models

- **Status:** Aceita
- **Data:** 01/11/2026 (registrada em 03/11/2026)

## Contexto

A mesma operação precisa ser usada por mais de uma entrada: o cadastro de produtos é acessado pela tela e pela API, e a criação de pedidos combina várias tabelas, chamadas ao banco e tratamento de erros. Colocar isso nos controllers duplicaria código e misturaria regra com resposta HTTP.

## Decisão

- Criar services em `app/Services`, um por módulo, injetados nos controllers.
- Cadastros simples (categorias, clientes, cupons, produtos) herdam de `CrudService`, que implementa listar, criar, atualizar e excluir e converte o erro de chave estrangeira (`23503`) em mensagem de negócio.
- Endereços (`EnderecoService`) e pedidos (`PedidoService`) têm services próprios por terem regras específicas.
- Validação de formato fica nos Form Requests (`app/Http/Requests`); os controllers só recebem dados já validados.

## Consequências

**Positivas**

- Controllers web e API reutilizam o mesmo `ProdutoService`.
- Regras e transações ficam em um único lugar, fácil de testar.
- Criar um novo cadastro simples exige só uma classe com três propriedades.

**Negativas**

- Mais uma camada para navegar em operações triviais.
- `CrudService` assume que todo cadastro filho tem o mesmo comportamento; um cadastro com regra diferente precisa sair da herança.
