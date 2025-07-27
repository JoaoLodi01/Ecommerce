<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Customers\CustomerController;
use App\Http\Controllers\Users\UserController;

Route::prefix('v1/access')->group(function() {
    Route::prefix('/auth')->group(function() { 
        Route::post('/login', [AuthController::class, 'login']);
    });

    Route::post('/user/create', [UserController::class, 'create']); 

    Route::post('/customers/create', [CustomerController::class, 'create']);
    
    Route::middleware('auth:sanctum')->group(function () { 
        Route::prefix('/user')->group(function() {
            Route::get('/find/user/{id}', [UserController::class, 'find']);
            
        });    

        Route::prefix('/customers')->group(function() {
            Route::get('/all', [CustomerController::class, 'all']);

        });
    });
});