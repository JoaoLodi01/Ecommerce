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

    public function returnResponse($th){
        return response()->json([
            'success' => false,
            'th' => $th->getMessage(),
            'line' => $th->getLine(),
            'file' => $th->getFile(),
        ]);
    }

    public function saveSale(array $details, array $productsArray)
    {
        try {
            $saveSale = $this->pdvRepository->saveSale($details, $productsArray);
            if($saveSale['success'])
            {
                return $saveSale;

            }
            
            return 400;

        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'line' => $th->getLine(),
                'file' => $th->getFile(),
            ]);
        }
    }

    public function finalizeSale(array $paymentsValues, string $typeOperation, int $id)
    {
        try {
            $total = 0;
            $forms = [];

            foreach ($paymentsValues as $value) {
                $total += $value;

            }
            for ($i=0; $i < count($paymentsValues); $i++) { 
                // posição do array com o valor > 0
                // Vai ser o ID da espécie
                if($paymentsValues[$i] > 0)
                {
                    $forms[] = $i + 1; 
                    
                }
            }    

            return response()->json($this->pdvRepository->finalizeSale($typeOperation, $id, $paymentsValues, $forms, $total));

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
