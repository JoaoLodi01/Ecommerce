<?php

use Illuminate\Support\Facades\{
    Log,
    Route
};

Route::get('/reset-password/{token}', function (string $token) {
    Log::info('Bateu no: /reset-passowrd/{token}');
    //return redirect()->away("$url/reset-password/$token");
    return redirect()->away("http://192.168.1.104:9000/reset-password/$token");

})->name('password.reset');