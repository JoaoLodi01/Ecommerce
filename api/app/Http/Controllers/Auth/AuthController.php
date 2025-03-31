<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class AuthController extends Controller
{
    public function auth(LoginRequest $request)
    {
        $data = $request->validated();

        if(Auth::attempt($data))
        {
            Log::info('Acertou o login');

            $user = Auth::user();
                      
            $currenteDate = carbon::now('America/Sao_Paulo')->addHour(8);
            $token = $user->createToken('auth_token', ['*'], $currenteDate)->plainTextToken;
        
            return response()->json([
                'status' => true,
                'user' => $user,
                'token' => $token
            ]);

        }

        Log::info('Errou o login');
        
    }

    public function logout()
    {
        Auth::logout();
        return response()->json([
            'success' => true,
            'message' => 'Logout bem sucedido!'
        ]);
        
    }
}