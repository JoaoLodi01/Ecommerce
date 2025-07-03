<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;

class CashRegisterService 
{
    public function __construct(
        protected CashRegisterRepository $cashRegisterRepository
    ) {}

    public function getAll(int $issuer_id)
    {
        $cash = $this->cashRegisterRepository->getAll($issuer_id);
        if(!$cash)
        {
            apiError('Cash não encontrado');

        }
        return $cash;
    }

    public function findByID(int $id){
        try {
            return response()->json([
                'success' => true,
                'cash' => $this->cashRegisterRepository->findByID($id)
            ]);
            
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function create(array $data){
        try {
            $this->cashRegisterRepository->create($data);
            return response()->json([
                'success' => true
            ], 201);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->cashRegisterRepository->update($data, $id);
            return response()->json([
                'success' => true
            ], 200);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->cashRegisterRepository->delete($id);
            return response()->json([
                'success' => true
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