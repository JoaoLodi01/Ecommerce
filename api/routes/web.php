<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\{
    Log,
    Route,
    Password
};

Route::get('/reset-passowrd/{token}', function(string $token){
    return view('auth.reset-password',['token' => $token]);
})->name('password.reset');


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