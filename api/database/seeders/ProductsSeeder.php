<?php

namespace Database\Seeders;

use App\Models\EcommerceModels\Products;
use App\Models\EcommerceModels\Grupos;
use Illuminate\Database\Seeder;

class ProductsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $groups = [
            [
                "grupo" => "Grupo teste 1"
            ],
            [
                "grupo" => "Grupo teste 2"
            ]
        ];
        foreach ($groups as $group) {
            $id = Grupos::create($group);
            
        }

        $products = [
            [
                "produto" => "Jack Daniels Maça",
                "grupo_id" => $id->id,
                "grupo" => $id->grupo,
                "quantidade" => 10,
                "preco_custo" => 10.00,
                "preco_venda" => 120.00,
                "perc_lucro" => 100,
                "ncm" => 12345678,
                "cest" => 1234567,
                "csosn" => 102,
                "cfop" => 5102,
            ],
            [
                "produto" => "Jack Daniels Honey",
                "grupo_id" => $id->id,
                "grupo" => $id->grupo,
                "quantidade" => 10,
                "preco_custo" => 10.00,
                "preco_venda" => 130.00,
                "perc_lucro" => 100,
                "ncm" => 12345678,
                "cest" => 1234567,
                "csosn" => 102,
                "cfop" => 5102,
            ],
            [
                "produto" => "Jack Daniels Canela",
                "grupo_id" => $id->id,
                "grupo" => $id->grupo,
                "quantidade" => 10,
                "preco_custo" => 10.00,
                "preco_venda" => 140.00,
                "perc_lucro" => 100,
                "ncm" => "12345678",
                "cest" => "123456",
                "csosn" => "102",
                "cfop" => "5102",
            ],
        ];

        foreach($products as $product){
            Products::create($product);
        }
    }
}
