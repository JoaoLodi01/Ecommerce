<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\ToPayRepository;

class ToPayService
{
    public function __construct(
        protected ToPayRepository $toPayRepository
    ){}

    public function getAll(int $issuer_id){
        $all = $this->toPayRepository->getAll($issuer_id);
        if(!$all)
        {
            throw new \App\Exceptions\EcommerceExceptions\ReceiveException("Erro ao buscar todas as parcelas do receber");

        }

        return $all;
    }

    public function findByID(int $id){
        try {
            return response()->json([
                'success' => true,
                'receive' => $this->toPayRepository->findByID($id)
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function create(array $data){
        try {
            return $this->toPayRepository->create($data);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->toPayRepository->update($data, $id);
            return response()->json([
                'success' => true,
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->toPayRepository->delete($id);
            return response()->json([
                'success' => true,
            ]);

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
}
