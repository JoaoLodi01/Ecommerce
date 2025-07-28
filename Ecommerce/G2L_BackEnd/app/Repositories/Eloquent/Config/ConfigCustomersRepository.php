<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\ConfigCustomers;
use App\Repositories\Contracts\ConfigContract\ConfigCustomersContract;

class ConfigCustomersRepository implements ConfigCustomersContract
{
    public function getConfigs(int $id)
    {
        $configCustomers = ConfigCustomers::where('issuer_id', $id)->first();
        $configCode = ConfigCustomers::where('issuer_id', $id)->max('config_customer_code');

        if(!$configCustomers)
        {
            ConfigCustomers::create([
                'issuer_id' => $id,
                'config_customer_code' => $configCode ? $configCode + 1 : 1
            ]);

            return ConfigCustomers::where('issuer_id', $id)->first();

        } else {
            return $configCustomers;

        }
    }

    public function update(array $data, int $id)
    {
        ConfigCustomers::where('issuer_id', $id)
                    ->update([
                        'validate_cnpj' => $data['validateCNPJ'] ?? null,
                        'validate_cpf' => $data['validateCPF'] ?? null,
                        'validate_addres' => $data['validateAddres'] ?? null,
                        'validate_trade_name' => $data['validateTradeName'] ?? null,
                        'validate_phone' => $data['validatePhone'] ?? null,
                        'edit_by_button' => $data['editByButton'] ?? null,
                        'last_filter' => $data['lastFilter'] ?? null
                        
                    ]);

        return $this->getConfigs($id);
    }
}