<?php

namespace App\Services;

use App\Repositories\Eloquent\NfceRepository;

class NfceService{

    protected $nfceRepository;

    public function __construct(NfceRepository $nfceRepository){
        $this->nfceRepository = $nfceRepository;
    }

    public function getAll(){
        try {
            return $this->nfceRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findByID(int $id){
        try {
            return response()->json([
                'success' => true,
                'nfce' => $this->nfceRepository->findByID($id)
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $total = $this->calculateTotal($data);
            $data['valor_liquido'] = $total;

            $this->nfceRepository->store($data);
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
            $this->nfceRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->nfceRepository->delete($id);
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
}