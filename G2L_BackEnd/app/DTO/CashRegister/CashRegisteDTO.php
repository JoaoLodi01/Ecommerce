<?php

namespace App\DTO\CashRegister;

readonly class CashRegisteDTO
{
    public function __construct(
        public int $cash_register_code,
        public int $issuer_id,
        public string $description,
        public int $document,
        public int $pdv_code,
        public int|null $receive_code,
        public int|null $receive_document,
        public int $customer_code,
        public string $name,
        public int $especie_code,
        public string $especie,
        public string $date_register,
        public float|int $input_value,
        public float|int $output_value,
        public string $origem,
        public int $user_id,
        public string $seller
        
    ){}
}