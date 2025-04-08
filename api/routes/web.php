<?php

use Illuminate\Support\Facades\Route;

Route::get('/reset-passowrd/{token}', function(string $token){
    return view('auth.reset-password',['token' => $token]);
})->name('password.reset');