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

    public function getAll(int $issuer_id){
        return $this->pdvRepository->getAll($issuer_id);
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
        $payMentsID = array_filter($paymentsValues);
        $total = array_sum($payMentsID);

        $pdv = $this->findSavePDVByID($pdvID, $issuerID);

        if($pdv)
        {
            if($total >= $pdv->net_value)
            {
                $finallyPDV = $this->pdvRepository->finalizeSale(
                    $typeOperation, 
                    $pdvID, 
                    $paymentsValues, 
                    $payMentsID, 
                    $issuerID,
                    $userID,
                );
                
                return $finallyPDV;

            } else {
                throw new \App\Exceptions\PDVExceptions\InsufficientPayment("Pagamento insuficiente");
            }

        } else {
            // PDV não encontrado

        }
    }

    public function cancelPDV(int $issuerID, int $pdvCode)
    {
        $canceledPDV = $this->pdvRepository->cancelPDV($issuerID, $pdvCode);
        
        return $canceledPDV;
    }
}
