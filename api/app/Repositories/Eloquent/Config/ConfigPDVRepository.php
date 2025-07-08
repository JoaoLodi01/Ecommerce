<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\EcommerceModels\ConfigPDV;
use App\Repositories\Contracts\ConfigContract\ConfigPDVContract;
use Illuminate\Support\Facades\Log;

class ConfigPDVRepository implements ConfigPDVContract
{
    public function getConfigs(int $id)
    {
        $configPDV = ConfigPDV::where('issuer_id', $id)->first();
        $configCode = ConfigPDV::where('issuer_id', $id)->max('config_pdv_cod');

        if(!$configPDV)
        {
            ConfigPDV::create([
                'issuer_id' => $id,
                'config_pdv_cod' => $configCode ? $configCode + 1 : 1
            ]);

            return ConfigPDV::where('issuer_id', $id)->first();

        } else {
            return $configPDV;

        }
    }

    public function update(array $data, int $id)
    {
        Log::info('data no repository');
        Log::info($data);
        ConfigPDV::where('issuer_id', $data['issuer_id'])
                    ->update([
                        'filter_search' => $data['searchOptionProduct'],
                        'filter_search_customer' => $data['searchOptionCustomers'],
                        'nm_finaly' => $data['nmFinaly'],
                        'sale_negative_or_reset' => $data['saleNegativeorReset'],
                        'supervisor_password_cancel_sale' => $data['supervisorPasswordCancelSale'],
                        'supervisor_password_delete_item' => $data['supervisorPasswordDeleteItem'],
                        
                    ]);

        return $this->getConfigs($data['issuer_id']);
    }
}