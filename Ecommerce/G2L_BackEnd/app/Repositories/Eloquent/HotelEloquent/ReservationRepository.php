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
        Log::info('customer ' . $customer);
        $room = Room::where('customer_id', $customer->id)->first();
        Log::info('room ' . $room);

        Reservation::create([
            'customer_id' => $customer->id,
            'name' => $customer->company_name,
            'room_id' => $room->id
            
        ]);

        return;
    }
}
