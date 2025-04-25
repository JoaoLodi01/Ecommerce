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
        return response()->json([
            'success' => true,
            'issuer' => $this->registerIssuerRepository->create($data)
        ], 201);
    }

    public function find(int $id)
    {
        return response()->json([
            'success' => true,
            'issuer' => $this->registerIssuerRepository->find($id)
        ], 200);
    }
}