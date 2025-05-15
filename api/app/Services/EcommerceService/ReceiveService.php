<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\ReceiveRepository;

class ReceiveService
{
    public function __construct(
        protected ReceiveRepository $receiveRepository
    ){}

    public function getAll(int $issuer_id){
        try {
            return response()->json([
                'success' => true,
                'all' => $this->receiveRepository->getAll($issuer_id)
            ], 200);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findByID(){
        try {
            return response()->json([
                'success' => true,
                'receive' => $this->receiveRepository->findByID($id)
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store($data){
        try {
            return $this->receiveRepository->store($data);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->receiveRepository->update($data, $id);
            return response()->json([
                'success' => true,
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->receiveRepository->delete($id);
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
