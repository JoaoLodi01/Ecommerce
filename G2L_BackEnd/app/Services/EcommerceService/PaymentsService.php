<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\PaymentsRepository;

class PaymentsService
{
    public function __construct(
        protected PaymentsRepository $paymentsRepository
    ) {}

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

    public function findKey(int $issuer_id)
    {
        $key = $this->paymentsRepository->findKey($issuer_id);
        if($key['success'])
        {
            return response()->json([
                'success' => $key['success'],
                'key' => $key['key']
                
            ]);

        } else {
            return response()->json([
                'success' => false,
                'message' => 'Graxa',
                'key' => $key
                
            ]);
        }
    }

    public function create(array $data){
        try {
            $paymentForm = $this->paymentsRepository->create($data);
            if($paymentForm['status'] === 201 && $paymentForm['success'])
            {
                return response()->json([
                    'success' => $paymentForm['success'],
                    'payMentForm' => $paymentForm

                ], $paymentForm['status']);

            }

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