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
            'filter_search' => $data['searchOptionProduct'],
            'filter_search_customer' => $data['searchOptionCustomers'],
            'nm_finaly' => $data['nmFinaly'],
            'sale_negative_or_reset' => $data['saleNegativeorReset'],
            'supervisor_password_delete_item' => $data['supervisorPasswordCancelSale'],
            'supervisor_password_delete_item' => $data['supervisorPasswordDeleteItem'],
            
        ]);

        return $this->getConfigs();
    }
}