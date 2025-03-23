<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\EcommerceRequest\PDVSaleRequest;
use App\Http\Requests\EcommerceRequest\PDVSaveSaleRequest;
use App\Services\EcommerceService\PDVService;
use Illuminate\Support\Facades\Log;

class PDVController extends Controller
{
    public function __construct(
        protected PDVService $pdvService
    ){
        Log::info('Memória usada PDVController::class, __construct: ' . memory_get_usage(true));
    }

    public function getAll(){
        return $this->pdvService->getAll();
    }

    public function saveSale(PDVSaveSaleRequest $request)
    {
        Log::info('Memória usada PDVController::class, saveSale: ' . memory_get_usage(true));
        $data = $request->validated();
        
        return $this->pdvService->saveSale($data, $data['products']);
        
    }
    
    public function finalizeSale(PDVSaleRequest $request, int $id)
    {
        $data = $request->validated();
        Log::info('Dados recebidos nos controllers');
        Log::info($data);
        return $this->pdvService->finalizeSale($request->input('paymentsValues'), $request->input('typeOperation'), $id, $data['pdvID']);
        
    }

    public function findSavePDV()
    {
        return $this->pdvService->findSavePDV();
        
    }
    
    public function findSavePDVByID(int $id)
    {
        return $this->pdvService->findSavePDVByID($id);
        
    }
}
