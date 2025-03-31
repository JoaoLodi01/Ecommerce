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

    public function store(array $data){
        try {
            $this->customerRepository->store($data);
            return response()->json(true);

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
        try {
            $this->customerRepository->delete($id);
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