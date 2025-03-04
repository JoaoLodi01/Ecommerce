<?php

namespace App\Repositories\Eloquent\HotelEloquent;

use App\Models\HotelModels\Reservation;

class ReservationRepository
{
    public function create(object $customer, object $room)
    {
        Reservation::create([
            'customer_id' => $customer->id,
            'name' => $customer->name,
            'room_id' => $room->number_room
            
        ]);
    }
}