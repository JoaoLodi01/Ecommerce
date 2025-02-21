<?php

namespace Database\Seeders;

use App\Models\EcommerceModels\Payment;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PaymentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $payments = [
            [
                "descricao" => "Dinheiro",
                "tipolancamento" => "Caixa",
            ],
            [
                "descricao" => "PIX",
                "tipolancamento" => "Caixa",
            ],
            [
                "descricao" => "Boleto",
                "tipolancamento" => "Receber",
            ],
            [
                "descricao" => "Cartão de Crédito",
                "tipolancamento" => "Caixa",
            ],
            [
                "descricao" => "Cartão de Débito",
                "tipolancamento" => "Receber",
            ],
            
        ];

        foreach($payments as $payment){
            Payment::create($payment);
        }
    }
}
