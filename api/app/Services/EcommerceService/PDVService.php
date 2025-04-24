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
        try {
            $saveSale = $this->pdvRepository->saveSale($details, $productsArray);
            Log::info('Save sale', ['data' => $saveSale]);
            if($saveSale['success'])
            {
                return $saveSale;

            }
                        
            return $saveSale;

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'line' => $th->getLine(),
                'file' => $th->getFile(),
            ]);
        }
    }

    public function finalizeSale(array $paymentsValues, string $typeOperation, int $id, int $pdvID)
    {
        try {
            $total = 0;
            $forms = [];

            foreach ($paymentsValues as $value) {
                Log::info('Dentro');
                $total += (float) $value;

            }
            for ($i=0; $i < count($paymentsValues); $i++) { 
                // posição do array com o valor > 0
                // Vai ser o ID da espécie
                if($paymentsValues[$i] > 0)
                {
                    $forms[] = $i + 1; 
                    
                }
            }    
            Log::info('PDVService.php, class:finalizeSale, $total: ' . $total);
            $pdv = $this->pdvRepository->finalizeSale($typeOperation, $id, $paymentsValues, $forms, $total);

            if ($pdv['success']) {
                return response()->json([
                    'success' => $pdv['success'],
                    'pdv' => $pdv['pdv'],
                    'message' => 'Venda finalizada'
                ], 200);
            } else {
                return response()->json([
                    'success' => $pdv['success'],
                    'message' => 'Erro ao finalizar'
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
