<?php

use App\Http\Controllers\{
    CustomerController,
    HotelController,
    PayMentController,
    RoomController
    
};

use Illuminate\Support\Facades\Route;

Route::post('/', function (){
    return response()->json('Rota: /');
    
});

Route::prefix('v1')->group( function (){
    Route::prefix('hotel')->group( function (){
        Route::get('/all', [HotelController::class, 'allHotel']);
        Route::get('/find', [HotelController::class, 'findHotel']);
        Route::post('/create', [HotelController::class, 'create']);
        Route::get('/room', [RoomController::class, 'find']);
    });

    Route::prefix('customer')->group( function (){
        Route::get('/all', [CustomerController::class, 'allCustomers']);
        Route::get('/find', [CustomerController::class, 'findCustomer']);
        Route::post('/create', [CustomerController::class, 'create']);

    });

    Route::prefix('stay')->group(function () {
        Route::get('/rooms', [RoomController::class, 'allRooms']);
        Route::post('/room', [RoomController::class, 'create']);
        Route::put('/check-in', [RoomController::class, 'checkIn']);

    });

    Route::prefix('pay-ment')->group(function (){
        Route::post('/index', [PayMentController::class, 'payMent']);

    });
});