<?php

namespace App\Providers;

use Illuminate\Database\Schema\Builder;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Mantém os timestamps com frações de segundo, como no banco original
        Builder::defaultTimePrecision(null);

        // Gera os links de paginação no formato do Bootstrap 5
        Paginator::useBootstrapFive();
    }
}
