<?php

namespace App\Repositories\Eloquent;

use App\Models\Registers\Issuer;
use App\Models\Registers\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class UserRepository
{
    public function getAll(int $issuer_id)
    {
        $issuer = Issuer::where('id', $issuer_id)->first();
        $users = User::where('owner_id', $issuer->owner_id)->get();

        return $users;
    }

    public function findByID(int $id)
    {
        return User::where('owner_id', $id)->first();
        
    }

    public function create(array $data){
        return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'access' => $data['access'],
            'is_owner' => 0,

        ]);
    }

    public function update(array $data, int $id){
        return User::where('id', $id)
                    ->update($data);
    }

    public function delete(int $id){
        return User::where('id', $id)
                    ->update([
                        'active' => 0,
                    ]);
    }

    // public function getAccessProfile(int $id)
    // {
    //     $user = $this->findByID($id);

    //     return $user->accessProfile()->get();
        
    // }
}