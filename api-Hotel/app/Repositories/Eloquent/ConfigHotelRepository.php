<?php

namespace App\Repositories\Eloquent;

use App\Models\ConfigHotel;

class ConfigHotelRepository
{
    public function create(array $data)
    {
        return ConfigHotel::create($data);

    }

    public function update(array $data, int $id)
    {
        return ConfigHotel::where('id', $id)->update($data);

    }

}