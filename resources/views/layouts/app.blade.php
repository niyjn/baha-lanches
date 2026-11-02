<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('titulo', 'Baha Lanches')</title>
</head>
<body>
    <nav>
        <a href="{{ route('pedidos.index') }}">Pedidos</a>
        <a href="{{ route('clientes.index') }}">Clientes</a>
        <a href="{{ route('produtos.index') }}">Produtos</a>
        <a href="{{ route('categorias.index') }}">Categorias</a>
        <a href="{{ route('cupons.index') }}">Cupons</a>
    </nav>

    @if (session('sucesso'))
        <p role="status">{{ session('sucesso') }}</p>
    @endif

    @if (session('erro'))
        <p role="alert">{{ session('erro') }}</p>
    @endif

    @if ($errors->any())
        <ul role="alert">
            @foreach ($errors->all() as $erro)
                <li>{{ $erro }}</li>
            @endforeach
        </ul>
    @endif

    <main>
        @yield('conteudo')
    </main>
</body>
</html>
