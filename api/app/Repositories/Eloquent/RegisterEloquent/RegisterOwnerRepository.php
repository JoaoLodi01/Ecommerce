<?php

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\Registers\Owner;
use App\Models\Registers\User;

use Illuminate\Support\Str;
use Illuminate\Support\Facades\{
    Hash
    
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

        $user_cod = User::where('owner_id', $owner->id)->max('user_cod');
        
        User::create([
            'user_cod' => $user_cod ? $user_cod + 1 : 1,
            'owner_id' => $owner->id,
            'name' => strtolower($owner->name),
            'login' => strtolower($data['email']),
            'password' => Hash::make($data['password']),
            'access' => 'Adminstrador',
            'is_owner' => 1
            
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