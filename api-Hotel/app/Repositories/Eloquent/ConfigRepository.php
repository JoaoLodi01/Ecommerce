<?php

namespace App\Repositories\Eloquent;

use App\Models\Config;

class ConfigRepository
{
    public function update(array $data, int $id)
    {
        $config = Config::where('id', $id)->update($data);
        
    }

}