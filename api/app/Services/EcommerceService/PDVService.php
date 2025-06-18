<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\PDVRepository;
use Illuminate\Support\Facades\Log;

class PDVService
{
    public function __construct(
        protected PDVRepository $pdvRepository

    ){
        Log::info('Memória usada PDVService::class, __construct, linha 13: ' . memory_get_usage(true));
    }

    public function returnResponse($th){
        return response()->json([
            'success' => false,
            'th' => $th->getMessage(),
            'line' => $th->getLine(),
            'file' => $th->getFile(),
        ], 400);
    }

    public function getAll(int $issuer_id){
        return $this->pdvRepository->getAll($issuer_id);
    }

    public function update(array $data, int $id){
        try {
            $this->pdvRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findSavePDV()
    {
        return $this->pdvRepository->findSavePDV() ?: false;
        
    }
    
    public function findSavePDVByID(int $id, int $issuerID)
    {
        $pdv = $this->pdvRepository->findSavePDVByID($id, $issuerID);
        return $pdv;
        
    }

    public function saveSale(array $details, array $productsArray)
    {
        $saveSale = $this->pdvRepository->saveSale($details, $productsArray);
        Log::info('Save sale');
        Log::info($saveSale);

        return $saveSale;
    }

    public function finalizeSale(
        array $paymentsValues, 
        string $typeOperation, 
        int $pdvID, 
        int $issuerID,
        int $userID,
    )
    {
        $total = 0; // Total pago
        $payMentsID = []; // ID das espécies de pagamento

        $filltred = array_filter($paymentsValues);

        foreach ($filltred as $key => $value) {
            $total += (float) $value;
            $payMentsID[] = $key + 1;
            
        }

        Log::info('PDVService.php, class:finalizeSale, $total: ' . $total);
        $pdv = $this->findSavePDVByID($pdvID, $issuerID);

        if($total < $pdv->net_value)
        {
            Log::info('Vai lançar o InsufficientPayment');
            throw new \App\Exceptions\InsufficientPayment("Pagamento insuficiente");

        } else {
            $finallyPDV = $this->pdvRepository->finalizeSale(
                $typeOperation, 
                $pdvID, 
                $paymentsValues, 
                $payMentsID, 
                $total,
                $issuerID,
                $userID,
            );
            
            return $finallyPDV;
        }

    }
}
