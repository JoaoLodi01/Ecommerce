<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\ConfigPDV;
use Illuminate\Support\Facades\Log;

class ConfigPDVRepository
{
    public function getConfigs(int $issuer_id)
    {
        return ConfigPDV::where('issuer_id', $issuer_id)->get();
        
    }

    public function update(array $data)
    {
        Log::info('data no repository');
        Log::info($data);
        ConfigPDV::where('active', 1)
                    ->where('issuer_id', $data['issuer_id'])
                    ->update([
                        'filter_search' => $data['searchOptionProduct'],
                        'filter_search_customer' => $data['searchOptionCustomers'],
                        'nm_finaly' => $data['nmFinaly'],
                        'sale_negative_or_reset' => $data['saleNegativeorReset'],
                        'supervisor_password_delete_item' => $data['supervisorPasswordCancelSale'],
                        'supervisor_password_delete_item' => $data['supervisorPasswordDeleteItem'],
                        
                    ]);

        return $this->getConfigs($data['issuer_id']);
    }
}