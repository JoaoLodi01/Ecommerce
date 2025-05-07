<?php

namespace App\Repositories\Eloquent\TributsEloquent;

use App\Models\Registers\Tributs\{
    NCM,
    CFOP,
    CSOSNCST
};

use App\Repositories\Contracts\TributsContract\TributsContract;
use App\Repositories\Eloquent\RegisterEloquent\RegisterIssuerRepository;
use Illuminate\Support\Facades\Log;

class TributsRepository implements TributsContract
{
   
    // CSOSN / CST

    public function getAllCSOSNCST(int $issuer_id)
    {
        return CSOSNCST::where('issuer_id', $issuer_id)->get();
        
    }

    public function searchCSOSNCST(array $data)
    {
        
    }

    public function registerCSOSNCST(array $data, int $issuer_id)
    {
        $exists = $this->findCSOSNCST($issuer_id);
        if(!$exists)
        {
            foreach ($data as $key => $value) {
                CSOSNCST::create([
                    'issuer_id' => $issuer_id,
                    'cod' => $key,
                    'decription' => $value
                ]);
            }

        }

        return array(
            'message' => 'Já está cadastrado'
        );
        
    }

    public function findCSOSNCST(int $issuer_id)        
    {
        return CSOSNCST::where('issuer_id', $issuer_id)->first();
    }

    // CFOPs
    public function getAllCFOPs(int $issuer_id)
    {
        return CFOP::where('issuer_id', $issuer_id)->get();
    }

    public function searchCFOP(array $data)
    {
        
    }

    public function registerCFOP(array $data, int $issuer_id)
    {
        $exists = $this->findCFOP($issuer_id);
        if(!$exists)
        {
            foreach ($data as $key => $value) {
                CFOP::create([
                    'issuer_id' => $issuer_id,
                    'cod' => $key,
                    'decription' => $value
                ]);
            }

        }

        return array(
            'message' => 'Já está cadastrado'
        );
    }

    public function findCFOP(int $issuer_id)
    {
        return CFOP::where('issuer_id', $issuer_id)->first();
    }

    // NCMs
    public function getAllNCMs(int $issuer_id)
    {
        return NCM::where('issuer_id', $issuer_id)->paginate(12147);
    }

    public function searchNCM(array $data)
    {
        $ncm = NCM::where('issuer_id', $data['issuer_id'])
                ->where(function ($q) use ($data) {
                    $q->where('ncm', 'like', '%' . $data['search'] . '%');

                })->get();
        Log::info("NCM encontrado: $ncm");

        return $ncm;
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