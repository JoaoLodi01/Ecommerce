<?php

namespace App\Services;

use App\Repositories\Eloquent\CashRegisterRepository;

class CashRegisterService 
{
    protected $cashRegisterRepository;

    public function __construct(CashRegisterRepository $cashRegisterRepository)
    {
        $this->cashRegisterRepository = $cashRegisterRepository;
    }

    public function getAll(){
        try {
            return $this->cashRegisterRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
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

    public function store(array $data){
        try {
            $this->cashRegisterRepository->store($data);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->cashRegisterRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->cashRegisterRepository->delete($id);
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
}