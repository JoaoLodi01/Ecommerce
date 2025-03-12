<?php

namespace App\Repositories\Eloquent;

use App\Models\EcommerceModels\User;

class UserRepository
{
    public function findByID(int $id)
    {
        return User::where('id', $id)->first();
        
    }
}