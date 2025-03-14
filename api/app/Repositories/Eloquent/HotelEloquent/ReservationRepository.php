<?php

namespace App\Repositories\Eloquent\HotelEloquent;

use App\Models\HotelModels\Reservation;

class ReservationRepository
{
    public function __construct(
        protected RoomRepository $roomRepository
    )
    {
        
    }

    public function create(object $customer)
    {
        $room = $this->roomRepository->findByCustomerID($customer->id);
        Reservation::create([
            'customer_id' => $customer->id,
            'name' => $customer->name,
            'room_id' => $room->number_room
            
        ]);
    }
}