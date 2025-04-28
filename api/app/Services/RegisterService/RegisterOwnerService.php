<?php

namespace App\Services\RegisterService;

use App\Repositories\Eloquent\RegisterEloquent\RegisterOwnerRepository;

class RegisterOwnerService
{
    public function __construct(
        protected RegisterOwnerRepository $registerOwnerRepository
    ){}

    public function create(array $data)
    {
        try {
            return response()->json([
                'success' => true,
                'owner' => $this->registerOwnerRepository->create($data)
            ], 201);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage(),
                'code' => $th->getCode()
            ], 500);
        }
        
    }

    public function find(int $id)
    {
        return response()->json([
            'success' => true,
            'owner' => $this->registerOwnerRepository->find($id)
        ], 200);
    }   

    public function findByEmail(string $email)
    {
        return $this->registerOwnerRepository->findByEmail($email);
    }   
}