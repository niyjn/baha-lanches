@extends('layouts.app')

@section('titulo', 'Editar categoria')

@section('conteudo')
    <h1>Editar categoria</h1>

    <form method="POST" action="{{ route('categorias.update', $categoria) }}">
        @method('PUT')
        @include('categorias._form')
    </form>
@endsection
