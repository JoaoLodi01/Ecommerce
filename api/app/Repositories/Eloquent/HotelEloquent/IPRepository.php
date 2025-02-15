<?php

namespace App\Repositories\Eloquent;

use App\Models\IP;

class IPRepository
{
    public function create(string $ip = '')
    {
        $ips = IP::where('ip', $ip)->first();
        
        if($ips)
        {
            return array(
                'message' => 'IP já cadastrado',
                'ip' => $ip
            );

        }

        return IP::create([
            'ip' => $ip
        ]);

    }
}