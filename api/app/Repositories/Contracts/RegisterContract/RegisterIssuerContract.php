<?php

namespace App\Repositories\Contracts\RegisterContract;

interface RegisterIssuerContract
{
    public function create(array $data);
    public function find(int $id);

}