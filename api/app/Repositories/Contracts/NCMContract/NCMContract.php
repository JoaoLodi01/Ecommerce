<?php

namespace App\Repositories\Contracts\NCMContract;

interface NCMContract
{
    public function getAllNCMs(int $issuer_id);
    public function registerNCM(
        int $issuer_id,
        string|int $ncm,
        string $description,
        float $nacional_federal,
        float $importados_federal,
        float $estadul,
        float $municipal,
        string $inicio,
        string $fim,
        string $chave,
        string $versao,

    );

    public function create(
        int $issuer_id,
        string|int $ncm,
        string $description,
        float $nacional_federal,
        float $importados_federal,
        float $estadul,
        float $municipal,
        string $inicio,
        string $fim,
        string $chave,
        string $versao,

    );

}