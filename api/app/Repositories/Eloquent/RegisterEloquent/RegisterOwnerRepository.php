<?php

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\Registers\Owner;
use App\Models\Registers\User;

use Illuminate\Support\Str;
use Illuminate\Support\Facades\{
    Hash,
    Log
};

use App\Repositories\Contracts\RegisterContract\RegisterOwnerContract;
class RegisterOwnerRepository implements RegisterOwnerContract
{
    public function create(array $data)
    {
        $owner = Owner::create([
            'name' => $data['name'],
            'surname' => $data['surname'],
            'cpf' => $data['cpf'],
            'email' => strtolower($data['email']),
            'password' => Hash::make($data['password']),
            'uuse_id' => Str::random(10),
        
        ]);

        User::create([
            'name' => $owner->name,
            'login' => strtolower($data['email']),
            'password' => Hash::make($data['password']),
            'access' => 'Adminstrador'

        ]);
        
        return $owner;
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