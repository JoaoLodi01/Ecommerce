<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\ConfigCustomers;
use App\Repositories\Contracts\ConfigContract\ConfigCustomersContract;

class ConfigCustomersRepository implements ConfigCustomersContract
{
    public function getConfigs(int $id)
    {
        return ConfigCustomers::where('issuer_id', $id)->get();
        
    }

    public function update(array $data, int $id)
    {
        ConfigCustomers::where('issuer_id', $id)
                    ->update([
                        'validate_cnpj' => $data['validateCNPJ'] ?? null,
                        'validate_cpf' => $data['validateCPF'] ?? null,
                        'validate_addres' => $data['validateAddres'] ?? null,
                        'last_filter' => $data['lastFilter'] ?? null
                        
                    ]);

        return $this->getConfigs($id);
    }
}