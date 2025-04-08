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
    CustomerController

};

use App\Http\Controllers\Config\ConfigController;

use App\Http\Controllers\Reports\ReportCustomersController;

use App\Http\Controllers\Auth\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Password;

Route::prefix('v1')->group( function (){
    Route::prefix('auth')->group( function (){
        Route::post('/auth', [AuthController::class, 'auth']);
        Route::post('/logout', [AuthController::class, 'logout']);

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
            // Products routes
            Route::prefix('products')->group( function(){
                Route::get('/all', [ProductsController::class, 'getAll']);
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
        Route::get('/report/all', [ReportCustomersController::class, 'exportAllClients']);
        Route::get('/report/all-disabled', [ReportCustomersController::class, 'exportAllDisabledClients']);
        
    });

    // User routes
    Route::prefix('users')->group( function(){
        //Route::get('/all', [UserController::class, 'getAll']);
        Route::get('/selectSeller', [UserController::class, 'selectSeller']);
        Route::post('/create', [UserController::class, 'create']);
        Route::get('/{id}', [UserController::class, 'findByID']);
        Route::put('/{id}', [UserController::class, 'update']);
        Route::delete('/{id}/deactivate', [UserController::class, 'delete']);
        
    });
});
    Route::prefix('users')->group( function(){
        Route::post('/create', [UserController::class, 'create']);
        
    });

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
   
    Route::get('/reset-passowrd/{token}', function(string $token){
        Log::info('token', $token);
        return view('auth.reset-password',['token' => $token]);
    })->name('password.reset');

    Route::get('/get-ip', [IPController::class, 'create']);
});

Route::get('/php-info', function (){
    return phpinfo();
})->name('php.info');