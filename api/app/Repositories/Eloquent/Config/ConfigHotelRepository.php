<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\ConfigHotel;

class ConfigHotelRepository
{
    public function getConfigs()
    {
        return ConfigHotel::all();
        
    }

    public function update(array $data)
    {
        ConfigHotel::where('active', 1)->update([
            'address_by_cep' => $data['address_by_cep'],
            'room_service_limit' => (float) $data['room_service_limit'],
            'partial_registration' => $data['partial_registration']
        
        ]);

        return $this->getConfigs();
    }


}