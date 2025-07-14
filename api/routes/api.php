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

use App\Http\Controllers\CustomerController;

use App\Http\Controllers\Config\ConfigController;

use App\Http\Controllers\Reports\ReportCustomersController;

use App\Http\Controllers\Auth\{
    AuthController,
    ForgotPasswordController
};

use App\Http\Controllers\FirstSteps\FirstStepsController;
use App\Http\Controllers\TributsController\TributsController;

use App\Http\Controllers\RegisterControllers\{
    RegisterUserController,
    RegisterIssuerController
};

use App\Http\Controllers\Reports\PDV\ReportCashClosingPeriodController;

use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group( function (){
    Route::prefix('auth')->group( function (){
        Route::post('/owner', [AuthController::class, 'authOwner']);
        Route::post('/auth', [AuthController::class, 'auth']);
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/check', [AuthController::class, 'checkLogin'])->middleware('auth:sanctum');;
    }); 
    
    Route::middleware('auth:sanctum')->group(function (){        
        Route::prefix('ecommerce')->group( function (){
            Route::prefix('products')->group( function(){
                Route::get('/download/default-file', [ProductsController::class , 'downloadDefaultFile']);
                Route::get('/last-bar_cod/{id}/{barCode}', [ProductsController::class, 'findLastCode']);
                Route::get('/all/{issuer_id}', [ProductsController::class, 'getAll']);
                Route::get('/all-groups/{issuer_id}', [ProductsController::class, 'allGroup']);
                Route::post('/search', [ProductsController::class, 'search']);
                Route::post('/create', [ProductsController::class, 'create']);
                Route::get('/{id}/{productCod}', [ProductsController::class, 'findByID']);
                Route::get('/imagem/{id}', [ProductsController::class, 'findImage']);
                Route::put('/update/{id}', [ProductsController::class, 'update']);
                Route::put('/active/{id}/{productCod}', [ProductsController::class, 'active']);
                Route::put('/disable/{id}/{productCod}', [ProductsController::class, 'delete']);
                Route::post('/import-products/{id}', [ProductsController::class, 'importProducts']);
                
            });

            Route::prefix('last-document')->group(function(){
                Route::get('/cash/{issuer_id}');
                Route::get('/receive/{issuer_id}');
                Route::get('/pay/{issuer_id}');
                Route::get('/bank/{issuer_id}');
            });

            Route::prefix('tributs')->group( function (){
                Route::get('/all/{id}', [TributsController::class, 'getAllNCMs']);
                Route::post('/search', [TributsController::class, 'searchNCM']);

            });

            // CashRegister routes
            Route::prefix('cash-register')->group( function(){
                Route::get('/all/{issuer_id}', [CashRegisterController::class, 'getAll']);
                Route::post('/create', [CashRegisterController::class, 'store']);
                Route::get('/{id}', [CashRegisterController::class, 'findByID']);
                Route::put('/{id}', [CashRegisterController::class, 'update']);
                Route::delete('/{id}/deactivate', [CashRegisterController::class, 'delete']);
                
            });
            
            // Receive routes
            Route::prefix('receive')->group( function(){
                Route::get('/all/{issuer_id}', [ReceiveController::class, 'getAll']);
                Route::post('/create', [ReceiveController::class, 'create']);
                Route::get('/{id}/{receiveCod}', [ReceiveController::class, 'findByID']);
                Route::put('/{id}', [ReceiveController::class, 'update']);
                Route::delete('/{id}/deactivate', [ReceiveController::class, 'delete']);
            });

            // Pay routes
            Route::prefix('pay')->group( function(){
                Route::get('/all/{issuer_id}', [ReceiveController::class, 'getAll']);
                Route::post('/create', [ReceiveController::class, 'store']);
                Route::get('/{id}', [ReceiveController::class, 'findByID']);
                Route::put('/{id}', [ReceiveController::class, 'update']);
                Route::delete('/{id}/deactivate', [ReceiveController::class, 'delete']);

            });
        
            // PDVs routes
            Route::prefix('pdv')->group( function(){
                Route::get('/all/{issuer_id}', [PDVController::class, 'getAll']);
                Route::post('/save-sale', [PDVController::class, 'saveSale']);
                Route::put('/finalize-sale', [PDVController::class, 'finalizeSale']);

                Route::get('/get-saved-sales', [PDVController::class, 'findSavePDV']);
                Route::post('/get-saved-sale', [PDVController::class, 'findSavePDVByID']);

                Route::get('/get-all-errors', [ErrorsPDVController::class, 'all']);

            });
        });

        Route::prefix('species')->group( function(){
            Route::get('/all/{issuer_id}', [PaymentsController::class, 'getAll']);
            Route::post('/create', [PaymentsController::class, 'create']);
            Route::get('/{id}', [PaymentsController::class, 'findByID']);
            Route::put('/{id}', [PaymentsController::class, 'update']);
            Route::put('/{id}/deactivate', [PaymentsController::class, 'delete']);
            Route::get('/find-key/{issuer_id}', [PaymentsController::class, 'findKey']);
    
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
            
        Route::prefix('configs')->group(function () {
            Route::get('/all-configs/{issuer_id}', [ConfigController::class, 'getConfigs']);

            Route::prefix('pdv')->group(function() {
                Route::put('/update-config/{issuer_id}', [ConfigController::class, 'updatePDV']);
            });

            Route::prefix('customer')->group(function() {
                Route::put('/update-config/{issuer_id}', [ConfigController::class, 'updateCustomer']);
            });

            Route::prefix('color')->group(function() {
                Route::get('/export/{issuer_id}', [ConfigController::class, 'exportColors']);
                
                Route::post('/import-color/{issuer_id}', [ConfigController::class, 'importColors']);

                Route::put('/update-config/{issuer_id}', [ConfigController::class, 'updateColor']);

            });
        });

        // Customers Routes
        Route::prefix('customers')->group( function(){
            Route::get('/all/{issuer_id}', [CustomerController::class, 'getAll']);
            Route::post('/search', [CustomerController::class, 'search']);
            Route::post('/create', [CustomerController::class, 'create']);
            Route::get('/{id}', [CustomerController::class, 'findByID']);
            Route::put('/update/{id}', [CustomerController::class, 'update']);
            Route::put('/{id}/disable', [CustomerController::class, 'delete']); // desactive
            Route::put('/{id}/active', [CustomerController::class, 'active']);

        });

        // User routes
        Route::prefix('users')->group( function(){
            Route::get('/all/{issuer_id}', [UserController::class, 'getAll']);
            Route::post('/create', [UserController::class, 'create']);
            Route::get('/{id}', [UserController::class, 'findByID']);
            Route::put('/{id}', [UserController::class, 'update']);
            Route::delete('/{id}/deactivate', [UserController::class, 'delete']);
        
        });

        Route::prefix('report')->group(function(){
            Route::prefix('customers')->group(function(){
                Route::get('/all/{issuer_id}', [ReportCustomersController::class, 'exportAllClients']);
                Route::get('/all-disabled/{issuer_id}', [ReportCustomersController::class, 'exportAllDisabledClients']);
            });

            Route::prefix('products')->group(function(){
                Route::get('/all/{issuer_id}', [ReportCustomersController::class, 'exportAllClients']);
                Route::get('/all-disabled/{issuer_id}', [ReportCustomersController::class, 'exportAllDisabledClients']);
            });

            Route::prefix('pdv')->group(function(){
                Route::post('/closing-period/{issuer_id}', [ReportCashClosingPeriodController::class, 'getData']);
            });
        });

        Route::prefix('issuer')->group(function(){
            Route::get('/all/companies/{id}', [RegisterIssuerController::class, 'getAll']);
            Route::get('/{id}', [RegisterIssuerController::class, 'findByID']);
            Route::get('/companie/{id}', [RegisterIssuerController::class, 'find']);
            Route::put('/complete-register/{id}', [RegisterIssuerController::class, 'completeRegister']);
            Route::put('/disable-company/{id}', [RegisterIssuerController::class, 'disableCompany']);
            Route::put('/active-company/{id}', [RegisterIssuerController::class, 'activeCompany']);

        });
        
        Route::prefix('first-steps')->group(function (){
            Route::get('/{id}', [FirstStepsController::class, 'getAll']);
            Route::put('/{id}', [FirstStepsController::class, 'ignoreFirstSteps']);

        });
    });

    Route::prefix('registers')->group( function(){
        Route::post('owner/create', [RegisterUserController::class, 'create']);
        Route::post('issuer/create', [RegisterIssuerController::class, 'create']);
        Route::post('users/create', [UserController::class, 'create']);
    });

    Route::post('/forgot-password', [ForgotPasswordController::class, 'forgotPassword'])->name('password.email');
    
    Route::post('/reset-passowrd', [ForgotPasswordController::class, 'resetPassowrd'])->name('password.update');    
});

Route::get('/info', function(){
    return phpinfo();
});