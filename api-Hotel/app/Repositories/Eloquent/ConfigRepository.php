<?php

namespace App\Repositories\Eloquent;

use App\Models\Config;

class ConfigRepository
{
    public function create(array $data)
    {

        //Cria config
        return Config::create($data);

    }

    public function update(array $data, int $id)
    {
        return Config::where('id', $id)->update($data);

    }

}