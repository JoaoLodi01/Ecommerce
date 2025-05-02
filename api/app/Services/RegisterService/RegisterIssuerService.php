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
        return response()->json([
            'success' => true,
            'companies' => $this->registerIssuerRepository->getAll($ownerID)

        ]);

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
        $issuer = $this->registerIssuerRepository->update($data, $id);
        return response()->json([
            'success' => true,
            'issuer' => $issuer
        ], 200);
    }
}