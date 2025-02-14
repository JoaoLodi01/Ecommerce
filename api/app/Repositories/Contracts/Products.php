<?php

namespace App\Repositories\Contracts;

interface Products
{
    public function getAll();
    public function search();
    public function findByID(int $id);
    public function store(array $data);
    public function delete(int $id);
}
