<?php

namespace App\Repositories\Eloquent\HotelEloquent;

use App\Models\HotelModels\Reservation;
use Illuminate\Support\Facades\Log;

class ReservationRepository
{
    public function __construct(
        //protected RoomRepository $roomRepository
    ){
        Log::info('Memória usada ReservationRepository::class, __construct: ' . memory_get_usage(true));
    }

    public function create(object $customer)
    {
        Log::info('Memória usada ReservationRepository::class, create: ' . memory_get_usage(true));
        //$room = $this->roomRepository->findByCustomerID($customer->id);
        Reservation::create([
            'customer_id' => $customer->id,
            'name' => $customer->name,
            'room_id' => 1
            
        ]);

        return;
    }
}
