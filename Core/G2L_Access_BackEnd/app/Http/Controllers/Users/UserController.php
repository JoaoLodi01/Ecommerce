<?php
//Core
namespace App\Http\Controllers\Users;

use App\Http\Controllers\Controller;
use App\Http\Requests\Users\UserRequest;
use App\Services\Users\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function __construct(
        protected UserService $userService
    ) {}

    public function create(UserRequest $request)
    {
        return apiSuccess($this->userService->create($request->validated()), 200);
        
    }
    
    public function find(int $id)
    {
        return apiSuccess($this->userService->find($id), 200);
        
    }
}
