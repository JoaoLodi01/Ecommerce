<?php

namespace App\Repositories\Eloquent\CustomerRepository;

use App\Repositories\Contracts\CustomersContract\CustomerContract;
use App\Models\Customer;
use Carbon\Carbon;

class CustomerRepository implements CustomerContract
{
    public function all()
    {
        return Customer::all();
    }

    public function create(array $data)
    {
        $date = new Carbon();

        $customer = Customer::create([
            'full_name' => $data['fullName'],
            'email' => $data['email'],
            'active_license' => $date->format('Y-m-d'),
            'cpf' => preg_replace('/[^a-zA-Z0-9]/', '', $data['cpf'])
            
        ]);

        return $customer;

    }

    public function update(array $data, int $id)
    {
        
    }

    public function updateSerial(array $data, int $id)
    {
        
    }

    public function find(int $id)
    {
        $customer = Customer::where('id', $id)->first();
        
    }
}