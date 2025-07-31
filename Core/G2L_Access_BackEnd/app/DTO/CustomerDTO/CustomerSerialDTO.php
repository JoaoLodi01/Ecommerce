<?php

namespace App\DTO\CustomerDTO;

readonly class CustomerSerialDTO
{
    public function __construct(
        public bool $hotel,
        public bool $ecommerce,
        public bool $site,
    ){}

}
