<?php

namespace App\Repositories\Eloquent\CustomerRepository;

use App\Repositories\Contracts\CustomersContract\CustomerContract;
use App\Models\Customer;
use Carbon\Carbon;
use Illuminate\Support\Str;

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
            'expire_license' => $date->addDays(30)->format('Y-m-d'),
            'cpf' => preg_replace('/[^a-zA-Z0-9]/', '', $data['cpf'])
            
        ]);

        return $customer;

    }

    public function liberations(int $id): array
    {
        $customer = $this->find($id);

        return [
            'hotel' => $customer->hotel,
            'ecommerce' => $customer->ecommerce,
            'site'  => $customer->site
        ];
    }

    public function generateCustomerCode(int $id)
    {        
        $customer = $this->find($id);

        do {
            $customerRandomCode = Str::random(10);

        } while ($customer === $customerRandomCode);

        $customer->code = $customerRandomCode;
        $customer->save();
        return $customerRandomCode;
    }

    public function update(array $data, int $id)
    {
        
    }
    
    public function updateMonthlyFee(float $newValue, int $id)
    {
        $customer = Customer::where('id', $id)->first();
        $customer->update([
            'monthly_fee' => $newValue
        ]);
        
        return $customer;
    }

    public function updateSerial(array $data, int $id)
    {
        $customer = $this->find($id);
        $customer->update([
            'hotel' => $data['hotel'],
            'ecommerce' => $data['ecommerce'],
            'site' => $data['site']
        ]);
        return $customer;
    }

    public function find(int $id)
    {
        $customer = Customer::where('id', $id)->first();
        return $customer;
    }
}