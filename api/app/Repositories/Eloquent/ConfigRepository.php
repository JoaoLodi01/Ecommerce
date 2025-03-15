<?php

namespace App\Repositories\Eloquent;

use App\Models\Config;

class ConfigRepository
{
    public function getConfigs()
    {
        return Config::paginate(20);
        
    }

    public function update(array $data)
    {
        $configUpdate = Config::where('active', 1)->update([
            'address_by_cep' => $data['address_by_cep'],
            'room_service_limit' => (float) $data['room_service_limit'],
            'partial_registration' => $data['partial_registration']
        
        ]);

        return $this->getConfigs();
    }
}