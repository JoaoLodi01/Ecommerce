<?php

namespace App\Services\RegisterService;

use App\Repositories\Eloquent\RegisterEloquent\RegisterIssuerRepository;

class RegisterIssuerService
{

    public function __construct(
        protected RegisterIssuerRepository $registerIssuerRepository
    ){}

    public function getAll(string $ownerID)
    {
        return $this->registerIssuerRepository->getAll($ownerID);

    }

    public function create(array $data)
    {
        $issuer = $this->registerIssuerRepository->create($data);
        if($issuer['success'])
        {
            return response()->json([
                'success' => true,
                'issuer' => $issuer
                
            ], 201);
            
        } else {
            return response()->json([
                'success' => false,
                'issuer' => $issuer
            ], 400);
            
        }
    }

    public function find(int $id)
    {
        return response()->json([
            'success' => true,
            'issuer' => $this->registerIssuerRepository->find($id)
        ], 200);
    }

    public function update(array $data, int $id) 
    {
        try {
            $issuer = $this->registerIssuerRepository->update($data, $id);
            return response()->json([
                'success' => true,
                'issuer' => $issuer
            ], 200);
            
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => $th->getMessage()
                
            ]);
        }
    }
}