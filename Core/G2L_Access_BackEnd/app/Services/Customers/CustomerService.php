<?php

namespace App\Services\Customers;

use App\Repositories\Eloquent\CustomerRepository\CustomerRepository;
use Exception;
use App\DTO\CustomerDTO\CustomerSerialDTO;
use Illuminate\Support\Facades\Log;

class CustomerService
{
    public function __construct(
        protected CustomerRepository $customerRepository
    )
    {}

    public function all()
    {
        $customers = $this->customerRepository->all();
        if(!$customers)
        {
            throw new Exception('Erro ao puxar todos os clientes!', 1);

        }
        return $customers;
    }

    public function create(array $data)
    {
        $customer = $this->customerRepository->create($data);

        if(!$customer)
        {
            throw new Exception('Erro criar o cliente!', 1);

        }

        return $customer;
    }

    public function liberations(int $id)
    {
        $customer = $this->customerRepository->liberations($id);

        if(!$customer)
        {
            throw new Exception('Erro ao achar o cliente!', 1);

        }

        return $customer;
    }
    
    public function update(array $data, int $id)
    {
        
    }
    
    public function updateMonthlyFee(float $newValue, int $id)
    {
        if($newValue <= 0.01)
        {
            throw new Exception('Valor informado menor do que o permitido', 1);

        }

        $valueChanged = $this->customerRepository->updateMonthlyFee($newValue, $id);

        if(!$valueChanged)
        {
            throw new Exception('Erro ao alterar o valor da mensalidade', 1);
        }
        
        return $valueChanged;
    }

    public function updateSerial(array $data, int $id)
    {
        $customer = $this->find($id);
        $filed = $data['liberation'];

        if(!$customer)
        {
            throw new Exception('Erro encontrar o cliente!', 1);

        }

        $modules = [
            'hotel' => $customer->hotel,
            'ecommerce' => $customer->ecommerce,
            'site' => $customer->site
        ];

        $modules[$data['liberation']] = !$customer->$filed;

        $changedCustomer = $this->customerRepository->updateSerial($modules, $id);

        if(!$changedCustomer)
        {
            throw new Exception('Erro alter as liberações do cliente!', 1);

        }
        return $changedCustomer;
    }

    public function find(int $id)
    {
        $customer = $this->customerRepository->find($id);

        if(!$customer)
        {
            throw new Exception('Erro procurar o cliente!', 1);

        }

        return $customer;
    }
}