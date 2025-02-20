<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\User;
use Illuminate\Support\Facades\Hash;

class UserRepository
{
    public function getAll(int $active)
    {
        return User::where('active', $active)->get();
        
    }

    public function findByID(string $params){
        return User::where('id', $params)->first();
    }

    public function store(array $data){
        return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password'])
        ]);
    }

    public function update(array $data, int $id){
        return User::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return User::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}