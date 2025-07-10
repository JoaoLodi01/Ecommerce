<?php

namespace App\DTO\Products;

readonly class ProductsDTO
{
    public function __construct(
        public int $issuer_id,
        public string $product,
        public float $cost_price,
        public float $profit_percentage,
        public float $sale_price,
        public float $amount,
        public string $cfop,
        public string $unit,
        public string $csosncst
        
    ) {}
}