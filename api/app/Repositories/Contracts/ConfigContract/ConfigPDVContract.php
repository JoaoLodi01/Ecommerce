<?php

namespace App\Repositories\Contracts\ConfigContract;

interface ConfigPDVContract
{
    public function getConfigs(int $id);
    public function update(array $data, int $id);

}