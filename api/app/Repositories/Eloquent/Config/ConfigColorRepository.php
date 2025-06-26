<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\SiteColors;
use App\Repositories\Contracts\ConfigContract\ConfigColorContract;

class ConfigColorRepository implements ConfigColorContract
{
    public function getConfigs(int $id)
    {
        return SiteColors::where('issuer_id', $id)->get();
        
    }

    public function update(array $data, int $id)
    {
        SiteColors::where('issuer_id', $id)
                    ->update([
                        'color' => $data['validateCNPJ'] ?? null,
                        
                    ]);

        return $this->getConfigs($id);
    }
}