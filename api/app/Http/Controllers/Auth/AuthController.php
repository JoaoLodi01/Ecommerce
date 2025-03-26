<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Laravel\Sanctum\Sanctum;
use App\Models\User;
class AuthController extends Controller
{
    public function auth(LoginRequest $request)
    {
        $data = $request->validated();

        if(Auth::attempt($data))
        {
            Log::info('Acertou o login');
            $user = Auth::user();            
            $token = $user->createToken('auth_token')->plainTextToken;
        
            return response()->json([
                'status' => true,
                'user' => $user,
                'token' => $token
            ]);

        }

        Log::info('Errou o login');
        return redirect()->route('php.info');
    }
}