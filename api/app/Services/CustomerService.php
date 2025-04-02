<?php

namespace App\Services;

use App\Repositories\Eloquent\CustomerRepository;

class CustomerService
{
    public function __construct(
        protected CustomerRepository $customerRepository
    )
    {
        $this->customerRepository = $customerRepository;
    }

    public function getAll(){
        try {
            return $this->customerRepository->getAll();
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function selectClient(array $search){
        try {
            return $this->customerRepository->selectClient($search);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findByID(int $id){
        try {
            return response()->json([
                'success' => true,
                'customer' => $this->customerRepository->findByID($id)
            ]);
            
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
            
        }
    }

    public function create(array $data){
        try {
            $customer = $this->customerRepository->create($data);
            return response()->json([
                'success' => 'true',
                'customer' => $customer
                
            ], 201);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $this->customerRepository->update($data, $id);
            return response()->json(true);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function delete($id){
        $this->customerRepository->delete($id);
        return response()->json([
            'success' => true,
        ], 200);
    }

    public function active($id)
    {
        $this->customerRepository->active($id);
        return response()->json([
            'success' => true
        ], 200);
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