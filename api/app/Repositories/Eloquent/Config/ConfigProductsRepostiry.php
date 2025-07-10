<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\ConfigProducts;

class ConfigProductsRepostiry
{
    public function getConfigs(int $id)
    {
        $configProducts = ConfigProducts::where('issuer_id', $id)->first();
        $configCode = ConfigProducts::where('issuer_id', $id)->max('config_product_cod');

        if(!$configProducts)
        {
            ConfigProducts::create([
                'issuer_id' => $id,
                'config_product_cod' => $configCode ? $configCode + 1 : 1
            ]);

            return ConfigProducts::where('issuer_id', $id)->first();

        } else {
            return $configProducts;

        }
    }
}