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
            return $this->pdvRepository->saveSale($details, $productsArray);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage(),
                'line' => $th->getLine(),
                'file' => $th->getFile(),
            ]);
        }
    }

    public function finalizeSale(array $data)
    {
        try {
            return response()->json($this->pdvRepository->finalizeSale($data));
        } catch (\Throwable $th) {
            //throw $th;
        }

    }
}