<?php

namespace App\Services;

use App\Repositories\Eloquent\PaymentRepository;

class PaymentService{
    
    protected $paymentRepository;

    public function __construct(PaymentRepository $paymentRepository){
        $this->paymentRepository = $paymentRepository;
    }

    public function getAll(){
        try {
            return $this->paymentRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findById(int $id){
        try {
            return response()->json([
                'success' => true,
                'especie' => $this->paymentRepository->findById($id)
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $this->paymentRepository->store($data);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->paymentRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->paymentRepository->delete($id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function returnResponse($th){
        return response()->json([
            'success' => false,
            'th' => $th->getMessage(),
            'line' => $th->getLise(),
            'file' => $th->getFile(),
        ]);
    }
}