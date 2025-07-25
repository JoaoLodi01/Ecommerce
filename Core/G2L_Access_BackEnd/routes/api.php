<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Users\UserController;

Route::prefix('v1/access')->group(function() {

    Route::prefix('/auth')->group(function() { 
        Route::post('/login', [AuthController::class, 'login']);
    });

    Route::middleware('auth:sanctum')->group(function () { 
        Route::get('/teste', [AuthController::class, 'all']);

        Route::prefix('/user')->group(function() {
            Route::post('/create', [UserController::class, 'create']);
            Route::get('/find/user/{id}', [UserController::class, 'find']);
            
        });    
    });
});