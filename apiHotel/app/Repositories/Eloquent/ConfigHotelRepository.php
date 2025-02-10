<?php

namespace App\Repositories\Eloquent;

use App\Models\ConfigHotel;

class ConfigHotelRepository
{
    public function create(array $data)
    {
        return ConfigHotel::create($data);

    }

}