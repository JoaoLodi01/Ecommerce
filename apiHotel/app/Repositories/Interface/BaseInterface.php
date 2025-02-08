<?php

namespace App\Repositories\Interface;

interface BaseInterface
{
    public function all(int $active);
    public function create(array $data);
    public function update(array $data, int $id);
    public function find(string $param);
    public function delete(int $id);
}