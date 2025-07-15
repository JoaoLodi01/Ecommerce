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
        $all = $this->registerIssuerRepository->getAll($ownerID);
        
        return $all;
    }

    public function create(array $data)
    {
        $issuer = $this->registerIssuerRepository->create($data);
        
        if(!$issuer)
        {
            throw new \App\Exceptions\IssuerExceptions\IssuerCreateException("Erro na criação do emitente");

        };

        return $issuer;
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

        if(!$issuer)
        {
            throw new \App\Exceptions\IssuerExceptions\IssuerCompleteRegisterException('Erro ao alterar cadastro do emitente');

        }

        return $issuer;
    }

    public function disableCompany(int $issuerID)
    {
        $company = $this->registerIssuerRepository->disableCompany($issuerID);
        return $company;
    }
    
    public function activeCompany(int $issuerID)
    {
        $company = $this->registerIssuerRepository->activeCompany($issuerID);
        return $company;
    }
}