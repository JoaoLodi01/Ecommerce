<?php

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\Registers\User;

use Illuminate\Support\Str;
use Illuminate\Support\Facades\{
    Hash,
    Log
};

use App\Repositories\Contracts\RegisterContract\RegisterUserContract;

class RegisterUserRepository implements RegisterUserContract
{
    public function create(array $data)
    {
        // Se mantem Owner para 
        $lastCod = User::max('user_code');
        $owner = User::create([
            'user_code' => $lastCod ? $lastCod + 1 : 1,
            'name' => $data['name'],
            'surname' => $data['surname'],
            'cpf' => $data['cpf'],
            'email' => strtolower($data['email']),
            'password' => Hash::make($data['password']),

            'uuse_id' => Str::random(10),
        
        ]);
        
        return $owner;
    }

    public function find(int $id)
    {
        return User::find('id', $id)->first();
    }

    public function findByEmail(string $email)
    {
        return User::where('email', $email)->first();
    }

    public function existsCPF(int $cpf): bool
    {
        $exists = User::where('cpf', $cpf)->first();
        return $exists ? true : false;

    }
}