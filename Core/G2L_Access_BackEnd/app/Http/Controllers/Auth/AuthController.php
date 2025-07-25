<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Services\Users\UserService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function __construct(
        protected UserService $userService
    ) {}

    public function login(LoginRequest $request)
    {
        $email = $request->input('email');
        $password = $request->input('password');

        $user = $this->userService->findEmail($email);
        if($user && Hash::check($password, $user->password))
        {
            Auth::login($user);

            $token = $user->createToken('auth_token')->plainTextToken;
            
            return apiSuccess('Login bem sucedido!', [
                'token' => $token,
                'user' => $user
            ]);
        }
    }
}