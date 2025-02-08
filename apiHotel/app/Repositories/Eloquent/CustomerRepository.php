<?php

namespace App\Repositories\Eloquent;

use App\Repositories\Interface\CustomerContract;
use App\Models\Customer;

class CustomerRepository implements CustomerContract
{
    public function all(int $active)
    {
        return Customer::where('active', $active)->get();

    }

    public function create(array $data)
    {
        return Customer::create($data);
        
    }

    public function update(array $data, int $id)
    {
        return Customer::where('id', $id)->update($data);

    }
    
    public function find(string $param)
    {
        return Customer::where('id', $param)
                        ->orWhere('name', 'like', '%' . $param . '%')
                        ->first();
        
    }

    public function delete(int $id)
    {
        return Customer::where('id', $id)->update([
            'active' => 0
            
        ]);
        
    }
}