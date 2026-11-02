@extends('layouts.app')

@section('titulo', 'Editar cupom')

@section('conteudo')
    <h1>Editar cupom</h1>

    <form method="POST" action="{{ route('cupons.update', $cupom) }}">
        @method('PUT')
        @include('cupons._form')
    </form>
@endsection
