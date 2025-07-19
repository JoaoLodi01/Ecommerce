<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\HotelModels\ConfigHotel;
use App\Repositories\Contracts\ConfigContract\ConfigHotelContract;

class ConfigHotelRepository implements ConfigHotelContract
{
    public function getConfigs(int $id)
    {
        return ConfigHotel::all();
        
    }

    public function update(array $data, int $id)
    {
        ConfigHotel::where('active', 1)->update([
            'address_by_cep' => $data['address_by_cep'],
            'room_service_limit' => (float) $data['room_service_limit'],
            'partial_registration' => $data['partial_registration']
        
        ]);

        return $this->getConfigs($id);
    }
}