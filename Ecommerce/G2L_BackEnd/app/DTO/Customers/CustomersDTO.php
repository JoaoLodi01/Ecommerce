<?php

namespace App\DTO\Customers;
readonly class CustomersDTO
{
    public function __construct(
        public int $issuer_id,
        public string $company_name,
        public string $trade_name,
        public string $cnpj,
        public string $cpf,
    ) {}
}