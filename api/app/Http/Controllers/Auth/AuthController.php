<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Services\EcommerceService\UserService;
use App\Services\RegisterService\RegisterUserService;

use Illuminate\Support\Facades\{
    Auth,
    Log,
    Hash
};
class AuthController extends Controller
{
    public function __construct(
        protected RegisterUserService $registerUserService,
        protected UserService $userService
        
    ) {}

    public function authOwner(LoginRequest $request)
    {
        $data = $request->validated();
        
        $user = $this->registerUserService->findByEmail($data['email']);

        Log::channel('auth')->info('data ' . $data['email']);
        Log::channel('auth')->info('user ' . $user);
        
        if($user && Hash::check($data['password'], $user->password))
        {
            Auth::login($user);
            
            $token = $user->createToken('auth_token')->plainTextToken;

            Log::channel('auth')->info("Passou o login, token: $token");
            
            return response()->json([
                'success' => true,
                'message' => 'Login bem sucedido!',
                'user' => $user,
                'token' => $token,
                'uuse_id' => $user->uuse_id
                
            ], 200);

        } else if (empty($user)) {
            return response()->json([
                'success' => false,
                'message' => 'O usuário não existe',
                
            ], 400);

        } else {
            return response()->json([
                'success' => false,
                'message' => 'Credencias incorretas',
                
            ], 400);
        }
    }

    public function logout()
    {
        Auth::logout();
        return response()->json([
            'success' => true,
            'message' => 'Logout bem sucedido!',
            'route' => '/login'
        ]);
    }

    /*public function checkLogin(Request $request)
    {       
        Log::channel('auth')->info("-- checkLogin --"); 
        $header = $request->header('Authorization');
        
        $user = $request->user();
        
        if(empty($header) && empty($user))
        {
            Log::channel('auth')->error("Erro no login");
            return apiError('Usuário não logado (1)', $header, false, 401);
                
        };
        Log::channel('auth')->info("Estava logado"); 
        return apiSuccess('Usuário logado', $user, true, 200);
    }*/ 
}