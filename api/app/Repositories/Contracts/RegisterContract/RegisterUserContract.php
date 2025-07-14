<?php

namespace App\Repositories\Contracts\RegisterContract;

interface RegisterUserContract
{
    public function create(array $data);
    public function find(int $id);
    public function findByEmail(string $email);

}