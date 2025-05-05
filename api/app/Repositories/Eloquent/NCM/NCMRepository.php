<?php

namespace App\Repositories\Eloquent\NCM;

use App\Models\Registers\NCM;
use App\Repositories\Contracts\NCMContract\NCMContract;
use Illuminate\Support\Facades\Log;

class NCMRepository implements NCMContract
{

    public function getAllNCMs(int $issuer_id)
    {
        return NCM::where('issuer_id', $issuer_id)->paginate(50000);
    }

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
        string $versao
    )
    {
        Log::info('Inicio ' . $inicio);
        Log::info('Fim ' . $fim);
        NCM::create([
            'issuer_id' => $issuer_id,
            'ncm' => $ncm,
            'description' => mb_convert_encoding($description, 'UTF-8', 'UTF-8'),
            'nacional_federal' => $nacional_federal,
            'importados_federal' => $importados_federal,
            'estadual' => $estadul,
            'municipal' => $municipal,
            'inicio' => date('Y-m-d', strtotime(str_replace('/', '-', $inicio))),
            //'inicio' => $inicio,
            'fim' => date('Y-m-d', strtotime(str_replace('/', '-', $fim))),
            //'fim' => $fim,
            'chave' => $chave,
            'versao' => $versao,

        ]);
    }

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
        string $versao
    )
    {
        NCM::create([
            'issuer_id' => $issuer_id,
            'ncm' => $ncm,
            'description' => $description,
            'nacional_federal' => $nacional_federal,
            'importados_federal' => $importados_federal,
            'estadual' => $estadul,
            'municipal' => $municipal,
            'inicio' => $inicio,
            'fim' => $fim,
            'chave' => $chave,
            'versao' => $versao,

        ]);
    }

}