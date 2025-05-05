<?php

namespace App\Services\NCM;

use App\Repositories\Eloquent\NCM\NCMRepository;
use Illuminate\Support\Facades\Log;

class NCMsServices
{
    public function __construct(
        protected NCMRepository $ncmRepository
    ) {}

    public function getAllNCMs(int $issuer_id)
    {
        return response()->json([
            'success' => true,
            'all' => $this->ncmRepository->getAllNCMs($issuer_id)
        ]);
    }

    public function searchNCM(array $data)
    {
        $ncm = $this->ncmRepository->searchNCM($data);
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
        
            $this->ncmRepository->registerNCM(
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
