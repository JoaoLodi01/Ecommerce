<?php

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\Owner;
use App\Repositories\Contracts\RegisterContract\RegisterOwnerContract;

class RegisterOwnerRepository implements RegisterOwnerContract
{
    public function create(array $data)
    {
        return Owner::create($data);
    }

    public function find(int $id)
    {
        return Owner::find('id', $id)->first();
    }
}