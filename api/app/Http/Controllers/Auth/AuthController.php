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

    public function authOwner(LoginRequest $request)
    {
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

    public function accessSupervisor()
    {
        
    }
}