<?php

namespace App\Repositories\Contracts;

interface HotelDetailContract
{
    public function checkAddress(object $hotel);
   
}