<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Http\Requests\UserRequest;
use App\Http\Controllers\Controller;
use App\Services\EcommerceService\UserService;
use Illuminate\Support\Facades\Log;

class UserController extends Controller
{
   
    public function __construct(
        protected UserService $userService

    )
    {}

    public function getAll(int $issuer_id){
        return apiSuccess('Todos os usuários', $this->userService->getAll($issuer_id));
    }

    public function create(UserRequest $request){
        return apiSuccess('Usuário criado com sucesso!', $this->userService->create($request->validated()));

    }

    public function findByID(int $id){
        return $this->userService->findByID($id);
    }

    public function update(UserRequest $request, int $id){
        return apiSuccess('Usuário alterado com sucesso!', $this->userService->update($request->validated(), $id));
        
    }

    public function delete(int $id){
        return $this->userService->delete($id);
    }
}
