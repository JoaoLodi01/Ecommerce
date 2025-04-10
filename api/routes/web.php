<?php

use App\Models\User;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{
    Hash,
    Log,
    Route,
    Password
};

use Illuminate\Support\Str;

Route::post('/forgot-password', function(Request $request){
    $request->validate(['email' => 'required|email']);

    $status = Password::sendResetLink(
        $request->only('email')
    );
    Log::info('Vai enviar');
    return $status === Password::RESET_LINK_SENT
                    ? back()->with(['status' => __($status)])
                    : back()->withErrors(['status' => __($status)]);
});

Route::post('/reset-passowrd', function(Request $request){
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
                    ? redirect(env('FRONT_URL')) 
                    : back()->withErrors(['email' => [__($status)]]);
});
