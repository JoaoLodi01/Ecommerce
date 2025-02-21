<?php

namespace Database\Seeders;

use App\Models\EcommerceModels\Customer;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ConsumerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $consumers = [
            [
                'cliente' => 'Teste 1',
                'cpf' => '12345678910',
                'cnpj' => null,
                'cep' => '89711226',
                'email' => 'teste1@teste.com',
                'phone' => '+55 4244-4444'
            ],
            [
                'cliente' => 'Teste 2',
                'cpf' => '12345678901',
                'cnpj' => null,
                'email' => 'teste2@teste.com',
                'phone' => '+55 4344-4444'
            ],
        ];

        foreach ($consumers as $consumer) {
            Customer::create($consumer);
        }
    }
}
