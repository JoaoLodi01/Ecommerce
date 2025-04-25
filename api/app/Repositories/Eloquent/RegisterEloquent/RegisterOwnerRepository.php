<?php

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\Owner;
use App\Repositories\Contracts\RegisterContract\RegisterOwnerContract;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;

class RegisterOwnerRepository implements RegisterOwnerContract
{
    public function create(array $data)
    {
        return Owner::create([
            'name' => $data['name'],
            'surname' => $data['surname'],
            'cpf' => $data['cpf'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'uuse_id' => Str::random(10),
        
        ]);
        
    }

    public function find(int $id)
    {
        return Owner::find('id', $id)->first();
    }

    public function findByEmail(string $email)
    {
        return Owner::where('email', $email)->first();
    }
}