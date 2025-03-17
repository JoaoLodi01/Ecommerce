<?php

namespace App\Repositories\Eloquent\HotelEloquent;

use App\Models\HotelModels\{
    Reservation,
    Room
};
use Illuminate\Support\Facades\Log;

class ReservationRepository
{
    public function create(object $customer)
    {
        Log::info('Memória usada ReservationRepository::class, create: ' . memory_get_usage(true));
        $room = Room::where('customer_id', $customer->id)->first();
        Reservation::create([
            'customer_id' => $customer->id,
            'name' => $customer->name,
            'room_id' => 1
            
        ]);

        return;
    }
}
