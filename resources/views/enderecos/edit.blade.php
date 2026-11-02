@extends('layouts.app')

@section('titulo', 'Editar endereço')

@section('conteudo')
    <h1>Editar endereço</h1>

    <form method="POST" action="{{ route('enderecos.update', $endereco) }}">
        @method('PUT')
        @include('enderecos._form')
    </form>
@endsection
