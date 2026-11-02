@extends('layouts.app')

@section('titulo', 'Novo endereço')

@section('conteudo')
    <h1>Novo endereço de {{ $cliente->nome }}</h1>

    <form method="POST" action="{{ route('clientes.enderecos.store', $cliente) }}">
        @include('enderecos._form')
    </form>
@endsection
