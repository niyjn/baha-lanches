<?php

use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\CupomController;
use App\Http\Controllers\EnderecoController;
use App\Http\Controllers\PedidoController;
use App\Http\Controllers\ProdutoController;
use Illuminate\Support\Facades\Route;

Route::redirect('/', '/pedidos');

Route::resource('categorias', CategoriaController::class)->except('show');
Route::resource('produtos', ProdutoController::class);
Route::resource('cupons', CupomController::class)->except('show')->parameters(['cupons' => 'cupom']);
Route::resource('clientes', ClienteController::class);
Route::resource('clientes.enderecos', EnderecoController::class)->except(['index', 'show'])->shallow();

Route::resource('pedidos', PedidoController::class)->only(['index', 'create', 'store', 'show']);
Route::post('pedidos/{pedido}/cupom', [PedidoController::class, 'aplicarCupom'])->name('pedidos.aplicar-cupom');
Route::post('pedidos/{pedido}/pagamento', [PedidoController::class, 'registrarPagamento'])->name('pedidos.registrar-pagamento');
Route::post('pedidos/{pedido}/avancar-status', [PedidoController::class, 'avancarStatus'])->name('pedidos.avancar-status');
Route::post('pedidos/{pedido}/cancelar', [PedidoController::class, 'cancelar'])->name('pedidos.cancelar');
