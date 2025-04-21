<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class AuthController extends Controller
{
    public function auth(LoginRequest $request)
    {
        $data = $request->validated();
        $email = $data['email'];

        if(Auth::attempt($data))
        {
            Log::info('Acertou o login');
            Cache::forget("login_attempts_{$email}");

            $user = Auth::user();
                      
            $currenteDate = carbon::now('America/Sao_Paulo')->addHour(8);
            $token = $user->createToken('auth_token', ['*'], $currenteDate)->plainTextToken;
        
            return response()->json([
                'status' => true,
                'user' => $user,
                'token' => $token
                
            ]);

        } else {
            $attempts = Cache::get("login_attempts_{$email}", 0);
            $attempts++;
            Cache::put("login_attempts_{$email}", $attempts, now()->addMinutes(2));
            
            if($attempts >= 3)
            {
                return response()->json([
                    'success' => false,
                    'blocked' => true,
                    'message' => 'Muitas tentativas de login, tente novamente mais tarde.'
                ], 429);
            }
            return response()->json([
                'success' => false,
                'message' => 'Credenciais inválidas!',
                'attempts' => $attempts
            ]);
        }        
    }

    public function logout()
    {
        Auth::logout();
        return response()->json([
            'success' => true,
            'message' => 'Logout bem sucedido!'
        ]);
        
    }

    public function accessSupervisor()
    {
        
    }
}