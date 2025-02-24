<?php

namespace Database\Seeders;

use App\Models\Customer;
use App\Models\CustomerCredit;
use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class CostumerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $current = new Carbon();
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
            $customer = Customer::create($consumer);
            
            CustomerCredit::create([
                'customer_id' => $customer->id,
                'name' => $customer->name,
                'current_credit' => 0,
                'validate' => $current->addDays(30)

            ]);
        }        
    }
}
