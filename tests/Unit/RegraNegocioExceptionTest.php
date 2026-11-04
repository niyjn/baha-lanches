<?php

namespace Tests\Unit;

use App\Exceptions\RegraNegocioException;
use Illuminate\Database\QueryException;
use PDOException;
use PHPUnit\Framework\TestCase;

class RegraNegocioExceptionTest extends TestCase
{
    private function erroDoBanco($mensagem)
    {
        $pdo = new PDOException($mensagem);
        $pdo->errorInfo = ['P0001', 7, $mensagem];

        return new QueryException('pgsql', 'call sp_cancelar_pedido(?)', [1], $pdo);
    }

    public function test_pega_a_mensagem_do_raise()
    {
        $erro = $this->erroDoBanco("ERROR:  Pedido 5 já está encerrado (ENTREGUE)\nCONTEXT:  PL/pgSQL function sp_cancelar_pedido(bigint) line 9 at RAISE");

        $excecao = RegraNegocioException::deQuery($erro);

        $this->assertEquals('Pedido 5 já está encerrado (ENTREGUE)', $excecao->getMessage());
    }

    public function test_mensagem_padrao_sem_error()
    {
        $excecao = RegraNegocioException::deQuery($this->erroDoBanco('falha sem prefixo'));

        $this->assertEquals('A operação não pôde ser concluída.', $excecao->getMessage());
    }

    public function test_guarda_o_erro_original()
    {
        $erro = $this->erroDoBanco('ERROR:  Cupom X não encontrado');

        $excecao = RegraNegocioException::deQuery($erro);

        $this->assertSame($erro, $excecao->getPrevious());
    }
}
