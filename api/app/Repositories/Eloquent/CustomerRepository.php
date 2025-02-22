<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use Illuminate\Support\Facades\Hash;

class CustomerRepository
{
    public function __construct(
        protected Customer $customerModel)
    {
        $this->customerModel = $customerModel;

    }
    public function getAll(int $active){

        
        return Customer::where('active', $active)->get();

    }

    public function findByID(string $params){
        return Customer::where('id', $params)->first();
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