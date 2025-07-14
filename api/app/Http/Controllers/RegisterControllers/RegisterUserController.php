<?php

namespace App\Http\Controllers\RegisterControllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\Register\RegisterUserRequest;
use App\Services\RegisterService\RegisterUserService;

class RegisterUserController extends Controller
{
    public function __construct(
        protected RegisterUserService $registerUserService
    ){}

    public function create(RegisterUserRequest $request)
    {
        return apiSuccess('Usuário cadastrado com sucesso!', $this->registerUserService->create($request->validated()));
        
    }

    public function find(int $id)
    {
        return $this->registerUserService->find($id);
    }
}