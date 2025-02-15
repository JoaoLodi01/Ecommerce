 <?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{
    ConfigController,
    HotelController,
    IPController,
    RoomController
    
};
Route::get('/', function () {
    return response()->json(['message' => 'API funcionando!']);
});

Route::prefix('v1')->group( function (){
    Route::prefix('hotel')->group( function (){
        Route::get('/all', [HotelController::class, 'allHotel']);
        Route::get('/find', [HotelController::class, 'findHotel']);
        Route::post('/create', [HotelController::class, 'create']);
        Route::get('/room', [RoomController::class, 'find']);
    });

    Route::prefix('stay')->group(function () {
        Route::get('/rooms', [RoomController::class, 'allRooms']);
        Route::post('/room', [RoomController::class, 'create']);
        Route::put('/check-in', [RoomController::class, 'checkIn']);

    });

    Route::get('/get-ip', [IPController::class, 'create']);
});

Route::prefix('config-hotel')->group( function () {
    Route::post('/set-config', [ConfigController::class, 'create']);
});