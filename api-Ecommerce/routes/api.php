 <?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{
    ProductsController,
    ConsumerController,
    CashRegisterController,
    UserController,
    NfceController,
    PaymentsController,
};

Route::get('/', function () {
    return response()->json(['message' => 'API funcionando!']);
});

// products routes
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
    
    Route::get('/all', [ConsumerController::class, 'getAll']);
    Route::post('/create', [ConsumerController::class, 'store']);
    Route::get('/{id}', [ConsumerController::class, 'findByID']);
    Route::put('/{id}', [ConsumerController::class, 'update']);
    Route::delete('/{id}/deactivate', [ConsumerController::class, 'delete']);
    
});

// CashRegister routes
Route::prefix('cashRegister')->group( function(){

    Route::get('/all', [CashRegisterController::class, 'getAll']);
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
Route::prefix('nfce')->group( function(){
    
    Route::get('/all', [NfceController::class, 'getAll']);
    Route::post('/create', [NfceController::class, 'store']);
    Route::get('/{id}', [NfceController::class, 'findByID']);
    Route::put('/{id}', [NfceController::class, 'update']);
    Route::delete('/{id}/deactivate', [NfceController::class, 'delete']);
});

Route::prefix('payments')->group( function(){

    Route::get('/all', [PaymentsController::class, 'getAll']);
    Route::post('/create', [PaymentsController::class, 'store']);
    Route::get('/{id}', [PaymentsController::class, 'findByID']);
    Route::put('/{id}', [PaymentsController::class, 'update']);
    Route::put('/{id}/deactivate', [PaymentsController::class, 'delete']);

});


/*Route::prefix('config-hotel')->group( function () {
    Route::post('/set-config', [ConfigController::class, 'create']);
});*/