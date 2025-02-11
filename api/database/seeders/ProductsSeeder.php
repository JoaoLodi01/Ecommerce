<?php

namespace Database\Seeders;

use App\Models\Products;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $products = [
            [
                "produto" => "Jack Daniels Maça",
                "quantidade" => 10,
                "preco_custo" => 10.00,
                "preco_venda" => 20.00,
                "perc_lucro" => 100,
                "ncm" => 12345678,
                "CEST" => 12345678,
                "CSOSN" => 102,
                "CFOP" => 5102,
            ],
            [
                "produto" => "Jack Daniels Honey",
                "quantidade" => 10,
                "preco_custo" => 10.00,
                "preco_venda" => 20.00,
                "perc_lucro" => 100,
                "ncm" => 12345678,
                "CEST" => 12345678,
                "CSOSN" => 102,
                "CFOP" => 5102,
            ],
            [
                "produto" => "Jack Daniels Canela",
                "quantidade" => 10,
                "preco_custo" => 10.00,
                "preco_venda" => 20.00,
                "perc_lucro" => 100,
                "ncm" => 12345678,
                "CEST" => 12345678,
                "CSOSN" => 102,
                "CFOP" => 5102,
            ],
        ];

        foreach($products as $product){
            Products::create($product);
        }
    }
}
