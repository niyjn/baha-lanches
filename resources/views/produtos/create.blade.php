@extends('layouts.app')

@section('titulo', 'Novo produto')

@section('conteudo')
    <h1>Novo produto</h1>

    <form method="POST" action="{{ route('produtos.store') }}">
        @include('produtos._form')
    </form>
@endsection
