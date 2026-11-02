<?php

namespace App\Exceptions;

use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use RuntimeException;

class RegraNegocioException extends RuntimeException
{
    /**
     * Converte um RAISE EXCEPTION do PostgreSQL (SQLSTATE P0001) em mensagem legível.
     */
    public static function deQuery(QueryException $erro): self
    {
        preg_match('/ERROR:\s+(.+)/', $erro->errorInfo[2] ?? '', $partes);

        return new self($partes[1] ?? 'A operação não pôde ser concluída.', previous: $erro);
    }

    public function render(Request $request): JsonResponse|RedirectResponse
    {
        if ($request->is('api/*') || $request->expectsJson()) {
            return response()->json(['message' => $this->getMessage()], 409);
        }

        return back()->withInput()->with('erro', $this->getMessage());
    }
}
