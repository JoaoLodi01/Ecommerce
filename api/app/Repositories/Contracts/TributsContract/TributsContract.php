<?php

namespace App\Repositories\Contracts\TributsContract;

interface TributsContract
{
    // CSOSN/CST
    public function getAllCSOSNCST(int $issuer_id);
    public function searchCSOSNCST(array $data);
    public function registerCSOSNCST(array $data, int $issuer_id);
    public function findCSOSNCST(int $issuer_id);

    // CFOP
    public function getAllCFOPs(int $issuer_id);
    public function searchCFOP(array $data);
    public function registerCFOP(array $data, int $issuer_id);
    public function findCFOP(int $issuer_id);

    // NCMs
    public function getAllNCMs(int $issuer_id);
    public function searchNCM(array $data);
    
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