<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\SiteColors;
use App\Repositories\Contracts\ConfigContract\ConfigColorContract;

class ConfigColorRepository implements ConfigColorContract
{
    public function getConfigs(int $id)
    {
        return SiteColors::where('issuer_id', $id)->first();
        
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

    public function exportColors(int $issuerID)
    {
        $configs = SiteColors::where('issuer_id', $issuerID)->first();
        $data = [
            'button_color' => $configs->button_color,
            'painel_color' => $configs->painel_color

        ];

        $json = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);

        $filePath = storage_path("files/{$issuerID}/export/color.json");

        file_put_contents($filePath, $json);

        return $filePath;
    }   
}