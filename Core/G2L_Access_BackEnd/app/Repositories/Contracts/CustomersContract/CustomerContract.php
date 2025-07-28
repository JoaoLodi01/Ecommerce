<?php

namespace App\Repositories\Contracts\CustomersContract;

interface CustomerContract
{
    public function all();
    public function create(array $data);
    public function liberations(int $id);
    public function generateCustomerCode(int $id);
    public function update(array $data, int $id);
    public function updateMonthlyFee(float $newValue, int $id);
    public function updateSerial(array $data, int $id);
    public function find(int $id);    
}