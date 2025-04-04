<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\ConfigPDV;
use Illuminate\Support\Facades\Log;

class ConfigPDVRepository
{
    public function getConfigs()
    {
        return ConfigPDV::all(); 
        
    }

    public function update(array $data)
    {
        Log::info('data no repository');
        Log::info($data);
        ConfigPDV::where('active', 1)->update([
            'nm_finaly' => $data['nmFinaly'],
            'sale_negative_or_reset' => (float) $data['saleNegativeorReset'],
            'filter_search' => $data['searchOption'] ? $data['searchOption'] : $data['model']
        
        ]);

        return $this->getConfigs();
    }
}