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

    public function getAll(){
        return $this->userService->getAll();
    }

    public function create(UserRequest $request){
        $data = $request->validated();
        Log::info($data);
        return $this->userService->create($data);
    }

    public function findByID(int $id){
        return $this->userService->findByID($id);
    }

    public function update(UserRequest $request, int $id){
        $data = $request->validated();
        return $this->userService->update($data, $id);
    }

    public function delete(int $id){
        return $this->userService->delete($id);
    }
}
