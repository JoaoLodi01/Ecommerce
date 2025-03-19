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
                "product" => "Jack Daniels Maça",
                "grupo_id" => $id->id,
                "grupo" => $id->grupo,
                "amount" => 10,
                "price_cost" => 10.00,
                "sale_price" => 120.00,
                "perc_lucro" => 100,
                "ncm" => 12345678,
                "cest" => 1234567,
                "csosn" => 102,
                "cfop" => 5102,
            ],
            [
                "product" => "Jack Daniels Honey",
                "grupo_id" => $id->id,
                "grupo" => $id->grupo,
                "amount" => 10,
                "price_cost" => 10.00,
                "sale_price" => 130.00,
                "perc_lucro" => 100,
                "ncm" => 12345678,
                "cest" => 1234567,
                "csosn" => 102,
                "cfop" => 5102,
            ],
            [
                "product" => "Jack Daniels Canela",
                "grupo_id" => $id->id,
                "grupo" => $id->grupo,
                "amount" => 10,
                "price_cost" => 10.00,
                "sale_price" => 140.00,
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
