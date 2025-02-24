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
                "especie" => "Dinheiro",
                "tipo_lancamento" => "Caixa",
            ],
            [
                "especie" => "PIX",
                "tipo_lancamento" => "Caixa",
            ],
            [
                "especie" => "Boleto",
                "tipo_lancamento" => "Receber",
            ],
            [
                "especie" => "Cartão de Crédito",
                "tipo_lancamento" => "Caixa",
            ],
            [
                "especie" => "Cartão de Débito",
                "tipo_lancamento" => "Receber",
            ],
            
        ];

        foreach($payments as $payment){
            Payment::create($payment);
        }
    }
}
