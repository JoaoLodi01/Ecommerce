<?php

namespace App\Http\Controllers\RegisterControllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\Register\RegisterOwnerRequest;
use App\Services\RegisterService\RegisterOwnerService;

class RegisterOwnerController extends Controller
{
    public function __construct(
        protected RegisterOwnerService $registerOwnerService
    ){}

    public function create(RegisterOwnerRequest $request)
    {
        return apiSuccess('Usuário cadastrado com sucesso!', $this->registerOwnerService->create($request->validated()));
        
    }

    public function find(int $id)
    {
        return $this->registerOwnerService->find($id);
    }
}