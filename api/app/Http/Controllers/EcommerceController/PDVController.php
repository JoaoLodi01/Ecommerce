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
    ){}

    public function getAll(){
        return $this->pdvService->getAll();
    }

    public function saveSale(PDVSaveSaleRequest $request)
    {
        Log::info('Chamou aqui');
        Log::info('Memória usada PDVController::class, saveSale: ' . memory_get_usage(true));

        $data = $request->validated();
        
        return $this->pdvService->saveSale($data, $data['products']);
        
        return response()->json([
            'data' => $request->all()
        ]);
        
    }
    
    public function finalizeSale(Request $request, int $id)
    {
        //$data = $request->validated();
        //return $this->pdvService->finalizeSale($request->input('paymentsValues'), $request->input('typeOperation'), $id);
        return response()->json([
            'data' => $request->all()
        ]);
    }
}
