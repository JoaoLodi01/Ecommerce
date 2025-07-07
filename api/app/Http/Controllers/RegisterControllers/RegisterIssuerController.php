<?php

namespace App\Http\Controllers\RegisterControllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\Register\RegisterIssuerRequest;
use App\Services\RegisterService\RegisterIssuerService;

use Illuminate\Http\Request;

class RegisterIssuerController extends Controller
{
    public function __construct(
        protected RegisterIssuerService $registerIssuerService
    ){}

    public function getAll(string $ownerID)
    {
        return apiSuccess('Todas as empresas', $this->registerIssuerService->getAll($ownerID));
    }

    public function create(RegisterIssuerRequest $request)
    {
        return apiSuccess('Empresa cadastrada com sucesso', $this->registerIssuerService->create($request->validated()));
    }

    public function find(int $id)
    {
        return $this->registerIssuerService->find($id);
    }
    
    public function completeRegister(Request $request, int $id)
    {        
        return apiSuccess('Emitente alterado com sucesso!', $this->registerIssuerService->update($request->all(), $id));
    }

    public function disableCompany(int $issuerID)
    {
        return apiSuccess('Empresa desativado com sucesso', $this->registerIssuerService->disableCompany($issuerID));

    }
}