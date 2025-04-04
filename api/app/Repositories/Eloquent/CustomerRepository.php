<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
class CustomerRepository
{
    public function getAll(){
        return Customer::paginate(10);

    }

    public function selectClient(array $search){
        $cusotmer = Customer::where('active', 1)
                        ->when(function ($query) use ($search){
                            $query->where('name', 'like', '%' . $search . '%');
                        })
                        ->get();

        Log::info($cusotmer);
        return $cusotmer;
    }

    public function findByID(int $id){
        return Customer::with('joinCredit')
                        ->where('id', $id)
                        ->first();
    }
    /*return CustomerCredit::join('customers', 'customers.id', 'customer_credits.customer_id')
                    ->where('customer_id', $id)
                    ->first();*/

    public function create(array $data){
        return Customer::create([
            'name' => $data['name'],
            'cpf' => $data['cpf'] ?? null,
            'cnpj' => $data['cnpj'] ?? null,
            'cep' => $data['cep'],
            'address' => $data['address'],
            'number' => $data['number'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'phone' => $data['phone'],
        ]);
    }

    public function update(array $data, int $id){
        return Customer::where('id', $id)
                        ->update($data, $id);
    }

    public function delete(int $id){
        return Customer::where('id', $id)
                        ->update([
                            'active' => 0,
        ]);
    }

    public function active(int $id){
        return Customer::where('id', $id)->update([
            'active' => 1
        ]);
    }

    
}
