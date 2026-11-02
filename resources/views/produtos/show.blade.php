@extends('layouts.app')

@section('titulo', $produto->nome)

@section('conteudo')
    <h1>{{ $produto->nome }}</h1>

    <p>Categoria: {{ $produto->categoria->nome }}</p>
    <p>Descrição: {{ $produto->descricao }}</p>
    <p>Preço: R$ {{ number_format($produto->preco, 2, ',', '.') }}</p>
    <p>Custo de produção: R$ {{ number_format($produto->custo_producao, 2, ',', '.') }}</p>
    <p>Disponível: {{ $produto->disponivel ? 'Sim' : 'Não' }}</p>

    <a href="{{ route('produtos.edit', $produto) }}">Editar</a>
@endsection
