<?php

namespace App\Repositories\Contracts;

interface CashRegister extends BaseInterface
{
    public function getAll();
    public function findByID(int $id);
    public function store(array $data);
    public function delete(int $id);
}
