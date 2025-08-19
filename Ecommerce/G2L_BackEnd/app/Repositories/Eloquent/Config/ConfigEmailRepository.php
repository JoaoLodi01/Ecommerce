<?php

namespace App\Repositories\Eloquent\Config;

use App\Models\ConfigEmail;

class ConfigEmailRepository
{
    public function getConfigs(int $id)
    {
        $configEmail = ConfigEmail::where('issuer_id', $id)->first();
        if (!$configEmail)
        {
            $max = ConfigEmail::where('issuer_id', $id)->max('issuer_id');
            ConfigEmail::create([
                'issuer_id' => $id,
                'config_email_code' => $max ? $max + 1 : 1
            ]);
        }

        return $configEmail;
    }

    public function update(array $data, int $id)
    {
        $config = ConfigEmail::where('issuer_id', $id)->update([
            'host' => $data['host'],
            'port' => $data['port'],
            'user_name' => $data['userName'],
            'password' => $data['password'],
            'use_tls' => $data['useTLS'],
            'use_ssl' => $data['useSSL']
        ]);
        
        return $config;
    }
}