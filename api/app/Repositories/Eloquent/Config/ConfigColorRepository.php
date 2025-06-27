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
                        'button_color' => $data['button_color'] ?? null,
                        'painel_color' => $data['painel_color'] ?? null,
                        
                    ]);

        return $this->getConfigs($id);
    }
}