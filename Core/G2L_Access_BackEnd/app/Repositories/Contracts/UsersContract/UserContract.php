<?php

namespace App\Repositories\Contracts\UsersContract;

interface UserContract
{
    public function create(array $data);
    public function find(int $id);
    public function findEmail(string $email);
}