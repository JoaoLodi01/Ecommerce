<?php

namespace App\Services\Users;

use App\Repositories\Eloquent\UserRepository\UserRepository;
use Exception;

class UserService
{
    public function __construct(
        protected UserRepository $userRepository
    ) {}

    public function create(array $data)
    {
        $newUser = $this->userRepository->create($data);
        if(!$newUser)
        {
            throw new Exception('Erro ao criar usuário!', 1);
        }

        return $newUser;
    }

    public function find(int $id)
    {
        $user = $this->userRepository->find($id);
        if(!$user)
        {
            throw new Exception('Erro ao encontrar usuário!', 1);
        }

        return $user;
        
    }
    
    public function findEmail(string $email)
    {
        $user = $this->userRepository->findEmail($email);
        if(!$user)
        {
            throw new Exception('Erro ao encontrar usuário!', 1);
        }

        return $user;
        
    }
}