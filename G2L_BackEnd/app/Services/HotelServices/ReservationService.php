<?php

namespace App\Services\HotelServices;

use App\Repositories\Eloquent\HotelEloquent\ReservationRepository;

use Illuminate\Support\Facades\Log;

class ReservationService
{
    public function __construct(
        protected ReservationRepository $reservationRepository
    ){
        Log::info('Memória usada ReservationService::class, __construct: ' . memory_get_usage(true));
    }
    
    public function create(object $customer)
    {
        try {
            return $this->reservationRepository->create($customer);

        } catch (\Throwable $th) {
            throw $th;
    }
    }
}