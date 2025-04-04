<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Grupos;

class GroupRepository
{

    public function findByID(int $id)
    {
        return Grupos::where('id', $id)->first();
    }

}