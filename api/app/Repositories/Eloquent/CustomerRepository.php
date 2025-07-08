<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use App\Models\Registers\FirstSteps;
use App\Models\Registers\Issuer;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class CustomerRepository
{
    protected $cacheKeyPrefix = 'customer';
    protected $cacheDurration = 10;

    public function getAll(int $issuer_id){
        $cacheKey = "{$this->cacheKeyPrefix}_{$issuer_id}";

        $customers = Cache::remember($cacheKey, $this->cacheDurration, function() use ($issuer_id) {
            return Customer::where('issuer_id', $issuer_id)->get();

        });
        
        return $customers;
    }
 
    public function search(array $data)
    {
        $customer = null;
        $search = $data['search'];

        switch ($data['filter']) {
            case 'Padrão (cód.cliente ou nome)':
                $customer = Customer::where('active', 1)
                        ->where('issuer_id', $data['issuer_id'])
                        ->where(function ($query) use ($search){
                            $query->where('customer_cod', $search)
                                  ->orWhere('company_name', 'like', '%' . $search . '%' )
                                  ->orWhere('trade_name', 'like', '%' . $search . '%' );
                        })
                        ->get();
                break;

            case 'CPF ou Cód cliente':
                $customer = Customer::where('active', 1)
                            ->where('issuer_id', $data['issuer_id'])
                            ->where(function($query) use ($search){
                                $query->where('customer_cod', $search)
                                    ->orWhere('cpf', 'like' . '%' . $search . '%');
                            })
                            ->get();
                break;

            case 'CNPJ ou Cód cliente':
                $customer = Customer::where('active', 1)
                            ->where(function($query) use ($search){
                            $query->where('customer_cod', $search)
                                    ->orWhere('cnpj', 'like', '%' . $search . '%');
                            })
                            ->get();
                break;
            
            case 'CNPJ, CPF ou Cód cliente':
                $customer = Customer::where('active', 1)
                           ->where(function($query) use ($search){
                             $query->where('customer_cod', $search)
                                   ->orWhere('cnpj', 'like', '%' . $search . '%')
                                   ->orWhere('cpf', 'like', '%' . $search . '%');
                           })
                           ->get();
                break;
        
            default:
                
                break;
        }

        return $customer;
    }

    public function findByID(int $id){
        return Customer::with('joinCredit')
                        ->where('customer_cod', $id)
                        ->first();
    }

    
    /*return CustomerCredit::join('customers', 'customers.id', 'customer_credits.customer_id')
                    ->where('customer_id', $id)
                    ->first();*/

    public function formatField(string|null $str): string|null
    {
        if(empty($str))
        {
            return null;
        }
        
        $words = array('-', '.', '/');
        return str_replace($words, "", $str);
    }

    public function create(array $data){
        $issuer = Issuer::where('id', $data['issuer_id'])->first();
        $maxCod = Customer::where('issuer_id', $issuer->id)->max('customer_cod');

        $customerCod = $maxCod ? $maxCod + 1 : 1;

        $stpes = FirstSteps::where('issuer_id', $issuer->id)->first();
        
        $stpes->update([
            'complete_customers' => 1
            
        ]);
        
        $stpes->save();

        return Customer::create([
            'customer_cod' => $customerCod,
            'issuer_id' => $issuer->id,
            'company_name' => $data['company_name'] ?? null,
            'trade_name' => $data['trade_name'] ?? null,
            'cpf' => null ?? $this->formatField($data['cpf']),
            'cnpj' => null ?? $this->formatField($data['cnpj']),
            'cep' => $this->formatField($data['cep']),
            'address' => $data['address'],
            'number' => $data['number'],
            'is_customer' => $data['is_customer'] ?? null,
            'is_driver' => $data['is_driver'] ?? null,
            'is_supplier' => $data['is_supplier'] ?? null,
            'phone' => $data['phone'],

        ]);
    }

    public function update(array $data, int $id)
    {
        $customer = Customer::where('customer_cod', $id)->where('issuer_id', $data['issuer_id'])->first();
        
        $customer->update([
            'company_name' => $data['company_name'] ?? null,
            'trade_name' => $data['trade_name'] ?? null,
            'cpf' => null ?? $this->formatField($data['cpf']),
            'cnpj' => null ?? $this->formatField($data['cnpj']),
            'cep' => $this->formatField($data['cep']),
            'address' => $data['address'],
            'number' => $data['number'],
            'is_customer' => $data['is_customer'] ?? null,
            'is_driver' => $data['is_driver'] ?? null,
            'is_supplier' => $data['is_supplier'] ?? null,
            'phone' => $data['phone'],

        ]);  
        
        return $customer;
    }

    public function delete(int $id){
        return Customer::where('customer_cod', $id)
                        ->update([
                            'active' => 0,
                        ]);
    }

    public function active(int $id){
        return Customer::where('customer_cod', $id)
                        ->update([
                            'active' => 1,
                        ]);
    }

    
}
