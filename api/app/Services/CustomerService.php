<?php

namespace App\Services;

use App\Repositories\Eloquent\CustomerRepository;

class CustomerService
{
    
    public function __construct(
        protected CustomerRepository $customerRepository
    )
    {}

    public function getAll(){
        return $this->customerRepository->getAll();
    }

    public function search(array $search){
        return $this->customerRepository->search($search);
    }

    public function findByID(int $id){
        return response()->json([
            'success' => true,
            'customer' => $this->customerRepository->findByID($id)
        ], 200);
        
    }

    public function create(array $data){
        try {
            $customer = $this->customerRepository->create($data);
            return response()->json([
                'success' => true,
                'customer' => $customer
                
            ], 201);

        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function update(array $data, int $id){
        try {
            $customer = $this->customerRepository->update($data, $id);
            return response()->json([
                'success' => true,
                'customer' => $customer
                
            ], 201);

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
