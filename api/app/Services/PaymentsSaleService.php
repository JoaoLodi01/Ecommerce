<?php

namespace App\Services;

use App\Repositories\Eloquent\PaymentsSaleRepository;

class PaymentsSaleService{
    
    protected $paymentsSaleRepository;

    public function __construct(PaymentsSaleRepository $paymentsSaleRepository){
        $this->paymentsSaleRepository = $paymentsSaleRepository;
    }

    public function getAll(){
        try {
            return $this->paymentsSaleRepository->getAll(1);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findById(int $id){
        try {
            return response()->json([
                'success' => true,
                'especie' => $this->paymentsSaleRepository->findById($id)
            ]);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function store(array $data){
        try {
            $this->paymentsSaleRepository->store($data);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->paymentsSaleRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->paymentsSaleRepository->delete($id);
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