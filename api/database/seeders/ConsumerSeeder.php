<?php

namespace Database\Seeders;

use App\Models\Customer;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class ConsumerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $consumers = [
            [
                'name' => 'Teste 1',
                'cpf' => '12345678910',
                'cnpj' => null,
                'cep' => '89711226',
                'address' => 'aaaaaa',
                'number' => 'aaaaaaaa',
                'email' => 'teste1@teste.com',
                'password' => Hash::make('1'),
                'phone' => '+55 4244-4444'
            ],
            [
                'name' => 'Teste 2',
                'cpf' => '12345678911',
                'cnpj' => null,
                'cep' => '89711225',
                'address' => 'aaaaa',
                'number' => 'aaaaa',
                'email' => 'teste2@teste.com',
                'password' => Hash::make('1'),
                'phone' => '+55 4244-4444'
            ],
        ];

        foreach ($consumers as $consumer) {
            Customer::create($consumer);
        }
    }
}
