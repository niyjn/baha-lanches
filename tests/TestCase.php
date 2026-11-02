<?php

namespace Tests;

use Illuminate\Foundation\Testing\TestCase as BaseTestCase;

abstract class TestCase extends BaseTestCase
{
    protected function setUp(): void
    {
        // Sem .env.testing os testes usariam o .env e poderiam apagar o banco principal
        if (! file_exists(dirname(__DIR__).'/.env.testing')) {
            $this->fail('Crie o .env.testing apontando para a branch de testes do Neon.');
        }

        parent::setUp();
    }
}
