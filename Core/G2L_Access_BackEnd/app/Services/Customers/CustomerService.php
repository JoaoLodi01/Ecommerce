<?php

namespace App\Services\Customers;

use App\Repositories\Eloquent\CustomerRepository\CustomerRepository;
use Exception;

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
}