<?php

namespace App\Repositories\Eloquent;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserRepository
{
    public function getAll(){
        return User::where('active', 1)
                    ->get();
        
        
    }

    public function findByID(int $id)
    {
        return User::where('id', $id)->first();
        
    }

    public function create(array $data){
        return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'access' => $data['access']

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