<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\PaymentsRepository;

class PaymentsService
{
    public function __construct(
        protected PaymentsRepository $paymentsRepository
    )
    {}

    public function getAll(int $issuer_id){
        try {
            return response()->json([
                'success' => true,
                'all' => $this->paymentsRepository->getAll($issuer_id)
            ]);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findById(array $id){
        try {
            return response()->json([
                'success' => true,
                'especie' => $this->paymentsRepository->findById($id)
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $this->paymentsRepository->store($data);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->paymentsRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->paymentsRepository->delete($id);
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