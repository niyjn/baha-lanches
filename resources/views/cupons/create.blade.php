@extends('layouts.app')

@section('titulo', 'Novo cupom')

@section('conteudo')
    <h1>Novo cupom</h1>

    <form method="POST" action="{{ route('cupons.store') }}">
        @include('cupons._form')
    </form>
@endsection
