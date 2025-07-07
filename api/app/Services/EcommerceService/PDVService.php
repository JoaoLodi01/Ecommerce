<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\PDVRepository;
use Illuminate\Support\Facades\Log;
use App\Traits\LogPayMentRepository;

class PDVService
{
    public function __construct(
        protected PDVRepository $pdvRepository,
        protected LogPayMentRepository $logPayMentRepository

    ){
        Log::info('Memória usada PDVService::class, __construct, linha 13: ' . memory_get_usage(true));
    }

    public function getAll(int $issuer_id){
        return $this->pdvRepository->getAll($issuer_id);
    }

    public function update(array $data, int $id){
        try {
            $this->pdvRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            
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
        $payMentsID = array_filter($paymentsValues);
        $total = array_sum($payMentsID);

        $pdv = $this->findSavePDVByID($pdvID, $issuerID);

        if($pdv)
        {
            if($total >= $pdv->net_value)
            {

            } else {
                // Pagamento menor que o total
            }

        } else {
            // PDV não encontrado

        }
        /*
        $total = 0; // Total pago
        $payMentsID = []; // ID das espécies de pagamento

        $filltred = array_filter($paymentsValues);

        foreach ($filltred as $key => $value) {
            $total += (float) $value;
            $payMentsID[] = $key + 1;
            
        }

        $this->logPayMentRepository->logDebug('Dados', $filltred);
        $pdv = $this->findSavePDVByID($pdvID, $issuerID);

        if($total < $pdv->net_value)
        {
            Log::info('Vai lançar o InsufficientPayment');
            throw new \App\Exceptions\PDVExceptions\InsufficientPayment("Pagamento insuficiente");
        
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
        }*/
    }
}
