<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use Illuminate\Support\Facades\Log;
class CustomerRepository
{
    public function getAll(){
        return Customer::paginate(10);

    }

    public function search(array $data)
    {
        Log::info('data - customer');
        Log::info($data);
        
        $customer = null;
        $search = $data['search'];
        switch ($data['fillter']) {
            case 'Padrão (cód.cliente ou nome)':
                $customer = Customer::where('active', 1)
                        ->where(function ($query) use ($search){
                            $query->where('id', $search)
                                  ->orWhere('name', 'like', '%' . $search . '%');
                        })
                        ->get();
                break;

            case 'CPF ou Cód cliente':
                $customer = Customer::where('active', 1)
                           ->where(function($query) use ($search){
                             $query->where('cpf', 'like', '%' . $search . '%')
                                   ->orWhere('id', $search);
                           })
                           ->get();
                break;

            case 'CNPJ ou Cód cliente':
                $customer = Customer::where('active', 1)
                            ->where(function($query) use ($search){
                            $query->where('cnpj', 'like', '%' . $search . '%')
                                    ->orWhere('id', $search);
                            })
                            ->get();
                break;
            
            case 'CNPJ, CPF ou Cód cliente':
                $customer = Customer::where('active', 1)
                           ->where(function($query) use ($search){
                             $query->where('cpf', 'like', '%' . $search . '%')
                                   ->orWhere('cnpj', 'like', '%' . $search . '%')
                                   ->orWhere('id', $search);
                           })
                           ->get();
                break;
        
            default:
                
                break;
        }

        Log::info('cusotmer');
        return $customer;
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
            'type_1' => $data['type'][0] ?? null,
            'type_2' => $data['type'][1] ?? null,
            'type_3' => $data['type'][2] ?? null,
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
