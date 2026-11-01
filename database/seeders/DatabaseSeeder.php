<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Carrega os dados do Baha Lanches a partir do script SQL.
     */
    public function run(): void
    {
        DB::unprepared(file_get_contents(database_path('sql/03_dados.sql')));
    }
}
