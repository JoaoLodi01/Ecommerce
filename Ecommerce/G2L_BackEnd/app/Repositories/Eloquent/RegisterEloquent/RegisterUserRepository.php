<?php

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\Registers\User;

use Illuminate\Support\Str;
use Illuminate\Support\Facades\{
    DB,
    Hash,
    Log
};

use App\Repositories\Contracts\RegisterContract\RegisterUserContract;

class RegisterUserRepository implements RegisterUserContract
{
    public function create(array $data)
    {
        // Se mantem Owner para 
        $owner = DB::transaction(function() use($data) {
            do {
                $uuseID = (string) Str::random(10);
                Log::channel('register')->debug("Dentro do do while");

            } while (User::where('uuse_id', $uuseID)->exists());

            $lastCod = User::max('user_code');

            return User::create([
                'user_code' => $lastCod ? $lastCod + 1 : 1,
                'name'      => $data['name'],
                'surname'   => $data['surname'],
                'cpf'       => $data['cpf'],
                'email'     => $data['email'],
                'password'  => Hash::make($data['password']),
                'uuse_id'   => $uuseID,
            
            ]);
        });
        
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
        return is_null(User::where('cpf', $cpf)->first());

    }
}