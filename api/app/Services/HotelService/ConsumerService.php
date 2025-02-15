<?php

namespace App\Services;

use App\Repositories\Eloquent\ConsumerRepository;

class ConsumerService{

    protected $consumerRepository;

    public function __construct(ConsumerRepository $consumerRepository)
    {
        $this->consumerRepository = $consumerRepository;
    }

    public function getAll(){
        try {
            return $this->consumerRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findByID(int $id){
        try {
            return response()->json([
                'success' => true,
                'product' => $this->consumerRepository->findByID($id)
            ]);
            
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $this->consumerRepository->store($data);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->consumerRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete($id){
        try {
            $this->consumerRepository->delete($id);
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