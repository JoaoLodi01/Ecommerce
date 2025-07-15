<?php

namespace App\Services;

use App\Exceptions\ExceptionCreateCustomer;
use App\Repositories\Eloquent\CustomerRepository;
use Illuminate\Support\Facades\Log;

class CustomerService
{
    
    public function __construct(
        protected CustomerRepository $customerRepository
    )
    {}

    public function getAll(int $issuer_id){
        return response()->json([
            'success' => true,
            'all' => $this->customerRepository->getAll($issuer_id)
        ], 200);
    }

    public function search(array $searchData){
        $customer = $this->customerRepository->search($searchData);
        
        if($customer)
        {
            throw new \App\Exceptions\CustomerNotFound("Cliente não encontrado", 1);
            
        }

        return $customer;
    }

    public function findByID(int $id){
        return response()->json([
            'success' => true,
            'customer' => $this->customerRepository->findByID($id)
        ], 200);
        
    }

    public function create(array $data){
        $customer = $this->customerRepository->create($data);
        
        return $customer;

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
