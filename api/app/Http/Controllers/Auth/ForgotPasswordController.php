<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Registers\User;
use Illuminate\Http\Request;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\{
    Hash,
    Log,
    Route,
    Password
};

class ForgotPasswordController extends Controller
{
    public function forgotPassword(Request $request)
    {
        Log::info('ForgotPasswordController:class, forgotPassword');
        $request->validate(['email' => 'required|email']);
    
        try {
            $status = Password::sendResetLink(
                $request->only('email')
    
            ); 
    
            return $status === Password::RESET_LINK_SENT
                                        ? response()->json([
                                            'success' => true, 
                                            'message' => 'Enviando e-mail',
                                            'status' => $status
                                        ], 200)
                                        : response()->json([
                                            'success' => false, 
                                            'message' => 'Erro ao enviar e-mail',
                                            'status' => $status
                                        ], 500);
        
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'th' => $th->getMessage()
            ], 500);
        }
        
    }

    public function resetPassowrd(Request $request)
    {
        Log::info('ForgotPasswordController:class, resetPassowrd');
        $request->validate([
            'token' => ['required'],
            'email' => ['required', 'email'],
            'password' => ['required', 'confirmed']
    
        ]);
    
        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function (User $user, string $password)
            {
                $user->forceFill([
                    'password' => Hash::make($password)
    
                ])->setRememberToken(Str::random(60));
    
                $user->save();
    
                event(new PasswordReset($user));
            }
        );

        return $status === Password::PASSWORD_RESET
                        ? response()->json([
                            'success' => true, 
                            'message' => 'Senha redefinida',
                            'status' => $status
                        ], 200)
                        
                        : response()->json([
                            'success' => false, 
                            'message' => 'Erro ao redefinir a senha',
                            'status' => $status
                        ], 500);
    }
}