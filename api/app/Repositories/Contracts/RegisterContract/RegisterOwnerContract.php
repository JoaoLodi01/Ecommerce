<?php

namespace App\Repositories\Contracts\RegisterContract;

interface RegisterOwnerContract
{
    public function create(array $data);
    public function find(int $id);
    public function findByEmail(string $email);

}