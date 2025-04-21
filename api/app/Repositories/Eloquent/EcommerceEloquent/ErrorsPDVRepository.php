<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\ErrorsPDV;
use Illuminate\Support\Facades\Log;

class ErrorsPDVRepository
{
    public function getAllErros()
    {
        $allErros = ErrorsPDV::where('completed', 0)->get();
        return array(
            'errors' => $allErros,
            'count' => count($allErros)
        );
    }

    public function getAllCompletedErros()
    {
        return ErrorsPDV::where('completed', 1)->get();

    }

    public function create(array $data, int $id)
    {
        Log::info('Data in ErrorsRepository: ', ['errors' => $data]);
        
        return ErrorsPDV::create([
            'title' => "Erros encontrados durante a emissão: Controle PDV: {$id}",
            'incorret_cfop' => $data['produtoErroCFOP'] ?? null,
            'incorret_csosn_cst' => $data['produtoErroCSOSN'] ?? null,
            'pdv_id' => $id
        ]);
        
    }

    public function resolveError(int $id)
    {
        return ErrorsPDV::where('pdv_id', $id)->update([
            'completed' => 1
        ]);

    }
}
