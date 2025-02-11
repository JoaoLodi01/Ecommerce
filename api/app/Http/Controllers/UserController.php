<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\UserRequest;
use App\Services\UserService;

class UserController extends Controller
{
    protected $userService;

    public function __construct(UserService $userService){
        $this->userService = $userService;
    }

    public function getAll(){
        return $this->userService->getAll();
    }

    public function store(UserRequest $request){
        $data = $request->validated();
        return $this->userService->store($data);
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
