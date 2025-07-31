<?php

namespace App\Repositories\Eloquent\UserRepository;

use App\Models\User;
use App\Repositories\Contracts\UsersContract\UserContract;

class UserRepository implements UserContract
{
    public function create(array $data)
    {
        $newUser = User::create($data);
        return $newUser;
    }

    public function find(int $id)
    {
        return User::where('id', $id)->first();
    
    }
    
    public function findEmail(string $email)
    {
        return User::where('email', $email)->first();
    }
}