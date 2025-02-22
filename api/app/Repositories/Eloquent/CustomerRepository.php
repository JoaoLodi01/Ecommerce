<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use App\Models\CustomerCredit;
use Illuminate\Support\Facades\Hash;

class CustomerRepository
{
    public function getAll(int $active){
        return Customer::where('active', $active)->get();

    }

    public function findByID(int $id){
        return CustomerCredit::join('customers', 'customers.id', 'customer_credits.customer_id')->where('customer_id', $id)->first();
    }

    public function store(array $data){
        return Customer::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password'])
        ]);
    }

    public function update(array $data, int $id){
        return Customer::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Customer::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}