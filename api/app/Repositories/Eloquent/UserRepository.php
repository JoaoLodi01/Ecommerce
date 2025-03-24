<?php

namespace App\Repositories\Eloquent;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserRepository
{
    public function getAll(int $active){
        return User::where('active', $active)
                    ->get();
    }

    public function selectSeller(array $search){
        return User::where('active', 1)
                    ->when(isset($search['id']), function ($query) use ($search){
                        return $query->where('id', $search['id']);
                    })
                    ->when(isset($search['name']), function ($query) use ($search){
                        return $query->where('name', 'like', "%{$search['name']}%");
                    })
                    ->get();
    }

    public function findByID(int $id)
    {
        return User::where('id', $id)->first();
        
    }

    public function store(array $data){
        return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password'])
        ]);
    }

    public function update(array $data, int $id){
        return User::where('id', $id)
                    ->update($data, $id);
    }

    public function delete(int $id){
        return User::where('id', $id)
                    ->update([
                        'active' => 0,
                    ]);
    }
}