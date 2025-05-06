<?php

namespace App\Services\TributsService;

use App\Repositories\Eloquent\TributsEloquent\TributsRepository;
use Illuminate\Support\Facades\Log;

class TributsServices
{
    public function __construct(
        protected TributsRepository $tributsRepository
    ) {}



    // CSOSN





    // CFOPs
    public function registerCFOP(array $data, int $issuer_id)
    {
        $register = $this->tributsRepository->registerCFOP($data, $issuer_id);
        return response()->json([
            'success' => true,
            'message' => 'CFOPs cadastrados com sucesso',
            'cfops' => $register
        ], 201);
    }


    // NCMs
    public function getAllNCMs(int $issuer_id)
    {
        return response()->json([
            'success' => true,
            'all' => $this->tributsRepository->getAllNCMs($issuer_id)
        ]);
    }

    public function searchNCM(array $data)
    {
        $ncm = $this->tributsRepository->searchNCM($data);
        return response()->json([
            'success' => true,
            'ncm' => $ncm,

        ]);
    }

    public function createNCM(int $issuer_id, string $uf)
    {  
        $path = public_path('IBPT');
        $handle = fopen("$path/$uf.csv", 'r');
        $row = 0;

        while ($line = fgetcsv($handle, 1000, ';')) 
        {
            if($row++ == 0){
                continue;
            }

            if($line[2] == 0)
            {
                $ncm = $line[0];
                $description = $line[3];
                $nacional_federal = $line[4];
                $importados_federal = $line[5];
                $estadul = $line[6];
                $municipal = $line[7];
                $inicio = $line[8];
                $fim = $line[9];
                $chave = $line[10];
                $versao = $line[11];

            }
        
            $this->tributsRepository->registerNCM(
                $issuer_id,
                $ncm,
                $description,
                $nacional_federal,
                $importados_federal,
                $estadul,
                $municipal,
                $inicio,
                $fim,
                $chave,
                $versao
            );

        }
    
        fclose($handle);

    }
} 
