<?php

namespace App\Repositories\Contracts\HotelContract;

interface HotelDetailContract
{
    public function checkAddress(object $hotel);
   
}