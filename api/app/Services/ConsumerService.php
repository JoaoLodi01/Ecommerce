<?php

namespace App\Services;

use App\Repositories\Eloquent\CustomerRepository;

class CostumerService
{
    public function __construct(
        protected CustomerRepository $costumerRepository
    )
    {
        $this->costumerRepository = $costumerRepository;
    }

    public function getAll(){
        try {
            return $this->costumerRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findByID(int $id){
        try {
            return response()->json([
                'success' => true,
                'product' => $this->costumerRepository->findByID($id)
            ]);
            
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $this->costumerRepository->store($data);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->costumerRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete($id){
        try {
            $this->costumerRepository->delete($id);
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