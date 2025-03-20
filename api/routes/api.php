<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EcommerceController\{
    ProductsController,
    CashRegisterController,
    UserController,
    PDVController,
    PaymentsController,

};

use App\Http\Controllers\HotelController\{
    HotelController,
    RoomController,

};

use App\Http\Controllers\{
    IPController,
    ConfigController,
    CustomerController

};
use App\Http\Controllers\Auth\AuthController;

Route::get('/', function () {
    return response()->json(['message' => 'API funcionando!']);
});

Route::group(['prefix' => 'admin'], function() {
    Route::post('/auth', [AuthController::class, 'auth']);
});

Route::prefix('v1')->group( function (){
    Route::prefix('ecommerce')->group( function (){
        // Products routes
        Route::prefix('products')->group( function(){
            Route::get('/all', [ProductsController::class, 'getAll']);
            Route::post('/search', [ProductsController::class, 'search']);
            Route::post('/create', [ProductsController::class, 'store']);
            Route::get('/{id}', [ProductsController::class, 'findByID']);
            Route::put('/{id}', [ProductsController::class, 'update']);
            Route::put('/{id}/deactivate', [ProductsController::class, 'delete']);
    
        });
    
        // Consumer routes
        Route::prefix('consumers')->group( function(){
            Route::get('/all', [CustomerController::class, 'getAll']);
            Route::post('/create', [CustomerController::class, 'store']);
            Route::get('/{id}', [CustomerController::class, 'findByID']);
            Route::put('/{id}', [CustomerController::class, 'update']);
            Route::delete('/{id}/deactivate', [CustomerController::class, 'delete']);
            
        });
    
        // CashRegister routes
        Route::prefix('cash-register')->group( function(){
            Route::get('/all', [CashRegisterController::class, 'getAll']);
            Route::get('/all/receive', [CashRegisterController::class, 'getAllReceive']);
            Route::post('/create', [CashRegisterController::class, 'store']);
            Route::get('/{id}', [CashRegisterController::class, 'findByID']);
            Route::put('/{id}', [CashRegisterController::class, 'update']);
            Route::delete('/{id}/deactivate', [CashRegisterController::class, 'delete']);
            
        });
    
        // User routes
        Route::prefix('users')->group( function(){
            Route::get('/all', [UserController::class, 'getAll']);
            Route::post('/create', [UserController::class, 'store']);
            Route::get('/{id}', [UserController::class, 'findByID']);
            Route::put('/{id}', [UserController::class, 'update']);
            Route::delete('/{id}/deactivate', [UserController::class, 'delete']);
            
        });        
    
        // NFC-e routes
        Route::prefix('pdv')->group( function(){
            Route::post('/save-sale', [PDVController::class, 'saveSale']);
            Route::put('/finalize-sale/{id}', [PDVController::class, 'finalizeSale']);

            Route::get('/all', [PDVController::class, 'getAll']);
            Route::get('/get-saved-sales', [PDVController::class, 'findSavePDV']);
            Route::get('/get-saved-sale/{id}', [PDVController::class, 'findSavePDVByID']);

        });
    
        Route::prefix('payments')->group( function(){
            Route::get('/all', [PaymentsController::class, 'getAll']);
            Route::post('/create', [PaymentsController::class, 'store']);
            Route::get('/{id}', [PaymentsController::class, 'findByID']);
            Route::put('/{id}', [PaymentsController::class, 'update']);
            Route::put('/{id}/deactivate', [PaymentsController::class, 'delete']);
    
        });
    });
    
    Route::prefix('hotel')->group( function (){
        Route::get('/all', [HotelController::class, 'allHotel']);
        Route::get('/find', [HotelController::class, 'findHotel']);
        Route::post('/create', [HotelController::class, 'create']);
        Route::get('/room', [RoomController::class, 'find']);
    
        Route::prefix('stay')->group(function () {
            Route::get('/rooms', [RoomController::class, 'allRooms']);
            Route::post('/room', [RoomController::class, 'create']);
            Route::put('/check-in', [RoomController::class, 'checkIn']);
            Route::post('/reservation', [RoomController::class, 'reservation']);
            Route::post('/check-reservation', [RoomController::class, 'checkReservation']);
            
        });
    });
    
    Route::prefix('config')->group( function () {
        Route::prefix('config-hotel')->group( function () {
            Route::put('/set-config', [ConfigController::class, 'update']);
            Route::get('/get-config', [ConfigController::class, 'getConfigs']);
    
        });
    });
    
Route::prefix('customers')->group( function(){
    Route::get('/all', [CustomerController::class, 'getAll']);
    Route::post('/create', [CustomerController::class, 'store']);
    Route::get('/{id}', [CustomerController::class, 'findByID']);
    Route::put('/{id}', [CustomerController::class, 'update']);
    Route::delete('/{id}/deactivate', [CustomerController::class, 'delete']);
    
});

Route::get('/get-ip', [IPController::class, 'create']);
});



Route::get('/page-401', function (){
    return response()->json([
        'status' => 'error',
        'success' => false,
        'message' => 'Acesso negado',
        
    ]);
});

Route::get('/php-info', function (){
    return phpinfo();
});