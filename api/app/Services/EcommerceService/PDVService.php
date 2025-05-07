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

    public function getAll(){
        return $this->pdvRepository->getAll();
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
        try {
            return response()->json([
                'success' => true,
                'pdvs' => $this->pdvRepository->findSavePDV()
                
            ], 200);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }
    public function findSavePDVByID(int $id)
    {
        try {
            return response()->json([
                'success' => true,
                'pdvs' => $this->pdvRepository->findSavePDVByID($id)
                
            ], 200);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function saveSale(array $details, array $productsArray)
    {
        $saveSale = $this->pdvRepository->saveSale($details, $productsArray);
        Log::info('Save sale');
        Log::info($saveSale);

        return $saveSale['success'] ? $saveSale : $saveSale;
    }

    public function finalizeSale(
        array $paymentsValues, 
        string $typeOperation, 
        int $pdvID, 
        int $issuerID
    )
    {
        try {
            $total = 0; // Total pago
            $payMentsID = []; // ID das espécies de pagamento

            $filltred = array_filter($paymentsValues);

            foreach ($filltred as $key => $value) {
                $total += (float) $value;
                $payMentsID[] = $key + 1;
                
            }

            Log::info('PDVService.php, class:finalizeSale, $total: ' . $total);
            $pdv = $this->pdvRepository->finalizeSale(
                $typeOperation, 
                $pdvID, 
                $paymentsValues, 
                $payMentsID, 
                $total,
                $issuerID
            );

            if ($pdv['success']) {
                return response()->json([
                    'success' => $pdv['success'],
                    'pdv' => $pdv['pdv'],
                    'message' => 'Venda finalizada'
                ], 200);

            } else {
                return response()->json([
                    'success' => $pdv['success'],
                    'line' => 113,
                    'file' => 'PDVService | erro manual',
                    'message' => $pdv['errorMessage'] ?? $pdv['message']
                ], 400);
                
            }

            return response()->json([
                'success' => $pdv['success'],
                'pdv' => $pdv['pdv'],
                'message' => $pdv['errorMessage'] ?? $pdv['message']
            ], 400);
            
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'line' => $th->getLine(),
                'file' => $th->getFile(),
            ]);
            
        }
    }
}
