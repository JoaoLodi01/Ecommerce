<?php

namespace App\Repositories\Eloquent;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserRepository extends BaseRepository
{
    
    protected $userModel;
    protected $baseRepository;
    public function __construct(User $userModel, BaseRepository $baseRepository)
    {
        $this->userModel = $userModel;
        $this->baseRepository = $baseRepository;

    }
    public function getAll(int $active){

        
        //return User::where('active', $active)->get();
        return $this->baseRepository->getAll($active);

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