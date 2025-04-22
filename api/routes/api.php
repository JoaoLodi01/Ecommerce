<?php

use App\Http\Controllers\EcommerceController\{
    ProductsController,
    CashRegisterController,
    ErrorsPDVController,
    UserController,
    PDVController,
    PaymentsController,
    ReceiveController
};

use App\Http\Controllers\HotelController\{
    HotelController,
    RoomController,

};

use App\Http\Controllers\{
    IPController,
    CustomerController

};

use App\Http\Controllers\Config\ConfigController;

use App\Http\Controllers\Reports\ReportCustomersController;

use App\Http\Controllers\Auth\{
    AuthController,
    ForgotPasswordController
};

use Illuminate\Support\Facades\{
    Route,
 
};
use Illuminate\Http\Request;

Route::prefix('v1')->group( function (){
    Route::prefix('auth')->group( function (){
        Route::post('/auth', [AuthController::class, 'auth']);
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::post('');

        Route::get('/me', function (Request $request) {
            return response()->json([
                'success' => $request->header('Authorization') ? true : false,
                'user' => $request->user(),
                'token_received' => $request->header('Authorization'),
    
            ]);
        })->middleware('auth:sanctum');
    }); 
    
    Route::middleware('auth:sanctum')->group(function (){        
        Route::prefix('ecommerce')->group( function (){
            Route::prefix('products')->group( function(){
                Route::get('/all', [ProductsController::class, 'getAll']);
                Route::get('/all-groups', [ProductsController::class, 'allGroup']);
                Route::post('/search', [ProductsController::class, 'search']);
                Route::post('/create', [ProductsController::class, 'create']);
                Route::get('/{id}', [ProductsController::class, 'findByID']);
                Route::get('/imagem/{id}', [ProductsController::class, 'findImage']);
                Route::put('/{id}', [ProductsController::class, 'update']);
                Route::put('/{id}/deactivate', [ProductsController::class, 'delete']);
        
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
            
            // Receive routes
            Route::prefix('receive')->group( function(){
                Route::get('/all', [ReceiveController::class, 'getAll']);
                Route::post('/create', [ReceiveController::class, 'store']);
                Route::get('/{id}', [ReceiveController::class, 'findByID']);
                Route::put('/{id}', [ReceiveController::class, 'update']);
                Route::delete('/{id}/deactivate', [ReceiveController::class, 'delete']);
            });

            // Pay routes
            Route::prefix('pay')->group( function(){
                Route::get('/all', [ReceiveController::class, 'getAll']);
                Route::post('/create', [ReceiveController::class, 'store']);
                Route::get('/{id}', [ReceiveController::class, 'findByID']);
                Route::put('/{id}', [ReceiveController::class, 'update']);
                Route::delete('/{id}/deactivate', [ReceiveController::class, 'delete']);
            });
        
            // NFC-e routes
            Route::prefix('pdv')->group( function(){
                Route::post('/save-sale', [PDVController::class, 'saveSale']);
                Route::put('/finalize-sale/{id}', [PDVController::class, 'finalizeSale']);

                Route::get('/all', [PDVController::class, 'getAll']);
                Route::get('/get-saved-sales', [PDVController::class, 'findSavePDV']);
                Route::get('/get-saved-sale/{id}', [PDVController::class, 'findSavePDVByID']);

                Route::get('/get-all-errors', [ErrorsPDVController::class, 'all']);

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
            Route::get('/all-configs', [ConfigController::class, 'getConfigs']);

            Route::prefix('config-pdv')->group( function() {
                Route::put('/update-config', [ConfigController::class, 'updatePDV']);
            });
        });

        // Customers Routes
        Route::prefix('customers')->group( function(){
            Route::get('/all', [CustomerController::class, 'getAll']);
            Route::post('/search', [CustomerController::class, 'search']);
            Route::post('/create', [CustomerController::class, 'create']);
            Route::get('/{id}', [CustomerController::class, 'findByID']);
            Route::put('/{id}', [CustomerController::class, 'update']);
            Route::delete('/{id}/deactivate', [CustomerController::class, 'delete']); // desactive
            Route::put('/{id}/active', [CustomerController::class, 'active']);

        });

        // User routes
        Route::prefix('users')->group( function(){
            Route::get('/all', [UserController::class, 'getAll']);
            Route::post('/create', [UserController::class, 'create']);
            Route::get('/{id}', [UserController::class, 'findByID']);
            Route::put('/{id}', [UserController::class, 'update']);
            Route::delete('/{id}/deactivate', [UserController::class, 'delete']);
        
        });

        Route::prefix('report')->group(function(){
            Route::prefix('customers')->group(function(){
                Route::get('/all', [ReportCustomersController::class, 'exportAllClients']);
                Route::get('/all-disabled', [ReportCustomersController::class, 'exportAllDisabledClients']);
            });

            Route::prefix('products')->group(function(){
                Route::get('/all', [ReportCustomersController::class, 'exportAllClients']);
                Route::get('/all-disabled', [ReportCustomersController::class, 'exportAllDisabledClients']);
            });
        });
    });

    Route::prefix('users')->group( function(){
        Route::post('/create', [UserController::class, 'create']);
        
    });

    Route::get('/get-ip', [IPController::class, 'create']); 

    Route::post('/forgot-password', [ForgotPasswordController::class, 'forgotPassword'])->name('password.email');
    
    Route::post('/reset-passowrd', [ForgotPasswordController::class, 'resetPassowrd'])->name('password.update');    
});
