<?php

namespace App\Repositories\Contracts\RegisterContract;

interface RegisterIssuerContract
{
    public function getAll(string $ownerID);
    public function create(array $data);
    public function find(int $id);
    public function update(array $data, int $id);

}