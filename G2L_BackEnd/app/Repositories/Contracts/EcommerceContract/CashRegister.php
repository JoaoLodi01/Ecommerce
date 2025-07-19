<?php

namespace App\Repositories\Contracts;

interface CashRegister
{
    public function getAll();
    public function findByID(string $params);
    public function create(array $data);
    public function delete(int $id);
    public function updateCurrentCash();
}
