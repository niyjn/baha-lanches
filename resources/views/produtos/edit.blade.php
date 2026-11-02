@extends('layouts.app')

@section('titulo', 'Editar produto')

@section('conteudo')
    <h1>Editar produto</h1>

    <form method="POST" action="{{ route('produtos.update', $produto) }}">
        @method('PUT')
        @include('produtos._form')
    </form>
@endsection
