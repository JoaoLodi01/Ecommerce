<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\PDVRepository;

class PDVService{

    protected $pdvRepository;

    public function __construct(PDVRepository $pdvRepository){
        $this->pdvRepository = $pdvRepository;
    }

    public function getAll(){
        try {
            return $this->pdvRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $total = $this->calculateTotal($data);
            $data['valor_liquido'] = $total;

            $this->pdvRepository->store($data);
            return response()->json([
                'success' => true,
                'message' => 'Venda realizada com sucesso!',
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->pdvRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function calculateTotal(array $data){
        $total = 0;

        foreach ($data as $item){
            $total += $item['preco_unitario'] * $item['qtde'];
        }
        return $total;
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
