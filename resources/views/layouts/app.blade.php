<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('titulo', 'Baha Lanches')</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="{{ route('pedidos.index') }}">Baha Lanches</a>
            <div class="navbar-nav">
                <a class="nav-link {{ request()->routeIs('pedidos.*') ? 'active' : '' }}" href="{{ route('pedidos.index') }}">Pedidos</a>
                <a class="nav-link {{ request()->routeIs('clientes.*', 'enderecos.*') ? 'active' : '' }}" href="{{ route('clientes.index') }}">Clientes</a>
                <a class="nav-link {{ request()->routeIs('produtos.*') ? 'active' : '' }}" href="{{ route('produtos.index') }}">Produtos</a>
                <a class="nav-link {{ request()->routeIs('categorias.*') ? 'active' : '' }}" href="{{ route('categorias.index') }}">Categorias</a>
                <a class="nav-link {{ request()->routeIs('cupons.*') ? 'active' : '' }}" href="{{ route('cupons.index') }}">Cupons</a>
            </div>
        </div>
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

    <main class="container py-4">
        @yield('conteudo')
    </main>
</body>
</html>
