<?php

namespace App;

interface Storage
{
    public function getAll();
    public function findByID(int $id);
    public function store(array $data);
    public function show(int $id);
    public function delete(int $id);
}
