<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Grupos;

class GroupRepository
{
    public function all()
    {
        return Grupos::paginate(10);
    }

    public function findByID(int $id)
    {
        return Grupos::where('id', $id)->first();
    }

}