<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use App\Http\Requests\PDV\{
    PDVSaleRequest,
    PDVSaveSaleRequest
    
};

use App\Services\EcommerceService\PDVService;
use Illuminate\Support\Facades\Log;

class PDVController extends Controller
{
    public function __construct(
        protected PDVService $pdvService
    ){
        Log::info('Memória usada PDVController::class, __construct: ' . memory_get_usage(true));
    }

    public function getAll(int $issuer_id){
        return $this->pdvService->getAll($issuer_id);
    }

    public function saveSale(PDVSaveSaleRequest $request)
    {
        $data = $request->validated();
        Log::info('Memória usada PDVController::class, saveSale: ' . memory_get_usage(true));
        Log::channel('pdv')->debug($data['products']);
        
        return apiSuccess('Venda salva', $this->pdvService->saveSale($request->validated(), $data['products']));
        
    }
    
    public function finalizeSale(PDVSaleRequest $request)
    {
        $data = $request->validated();
        Log::debug($data);
        $pdv = $this->pdvService->finalizeSale(
            $data['payments_values'], 
            $data['type_operation'], 
            $data['pdv_id'], 
            $data['issuer_id'],
            $data['user_id']
        );
        
        return apiSuccess('Venda finalizada com sucesso!', $pdv);
    }

    public function cancelPDV(int $issuerID, int $pdvCode)
    {

        return apiSuccess('Dados', $this->pdvService->cancelPDV($issuerID, $pdvCode));

    }

    public function findSavePDV()
    {
        $pdv = $this->pdvService->findSavePDV();
        
        if(!$pdv)
        {
            return apiError('PDV não encontrado');

        };
        
        return apiSuccess($pdv);
        
    }
    
    public function findSavePDVByID(Request $request)
    {
        return $this->pdvService->findSavePDVByID($request->input('pdv_id'), $request->input('issuer_id'));
        
    }
}
