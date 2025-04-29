<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Services\RegisterService\RegisterOwnerService;
use Carbon\Carbon;

use Illuminate\Support\Facades\{
    Auth,
    Cache,
    Log,
    Hash
};
class AuthController extends Controller
{
    public function __construct(
        protected RegisterOwnerService $registerOwnerService
    ) {}

    /*public function auth(LoginRequest $request)
    {
        $data = $request->validated();
        Log::info('Data');
        Log::info($data);
        $email = $data['email'];

        if(Auth::guard('user')->attempt($data))
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
            Log::info('Errou o login');
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

        if(Auth::guard('owner')->attempt($data))
        {
            Log::info('Acertou o login');

        }
    }*/

    public function authOwner(LoginRequest $request)
    {
        try {
            $data = $request->validated();
    
            $owner = $this->registerOwnerService->findByEmail($data['email']);

            Log::info('owner ' . $owner);
            if($owner && Hash::check($data['password'], $owner->password))
            {
                Auth::login($owner);
                $token = $owner->createToken('auth_token')->plainTextToken;
                Log::info("Passou o login, token: $token");
                return response()->json([
                    'success' => true,
                    'message' => 'Login bem sucedido!',
                    'owner' => $owner,
                    'token' => $token,
                    'uuse_id' => $owner->uuse_id
                    
                ], 200);

            } else if (empty($owner))
            {
                return response()->json([
                    'success' => false,
                    'message' => 'O usuário não existe',
                    
                ], 400);

            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Erro no login',
                    
                ], 400);


            }

            
        } catch (\Throwable $th) {
            //throw $th;
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