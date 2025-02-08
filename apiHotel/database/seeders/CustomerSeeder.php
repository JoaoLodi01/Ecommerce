<?php

namespace Database\Seeders;

use App\Models\Customer;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class CustomerSeeder extends Seeder
{
    public function run(): void
    {
        $customers = [
            [
                "name" => "Laura Refosco",
                "cnpj" => "3",
                "cpf" => null,
                "address" => "Rua das Flores",
                "number" => "21",
                "account" => "laura.refosco3008@gmail",
                "password" => Hash::make("Teste")

            ],
            [
                "name" => "Gabriel Refosco",
                "cnpj" => "08805166901",
                "cpf" => null,
                "address" => "Rua das Flores",
                "number" => "21",
                "account" => "gabikochem55@gmail",
                "password" => Hash::make("Teste")

            ],
            [
                "name" => "João Lodi",
                "cnpj" => "5678534543",
                "cpf" => null,
                "address" => "Rua Teste",
                "number" => "21",
                "account" => "teste3@gmail",
                "password" => Hash::make("Teste")

            ],
            [
                "name" => "João Lodi",
                "cnpj" => "5678534563",
                "cpf" => null,
                "address" => "Rua Teste",
                "number" => "21",
                "account" => "teste422@gmail",
                "password" => Hash::make("Teste")

            ]
        ];

        foreach ($customers as $customer) {
            Customer::create($customer);
            
        }
    }
}
