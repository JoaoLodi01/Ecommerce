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
                "group" => "Grupo teste 1"
            ],
            [
                "group" => "Grupo teste 2"
            ]
        ];
        foreach ($groups as $group) {
            $id = Grupos::create($group);
            
        }

        $products = [
            [
                "product" => "Jack Daniels Maça",
                "group_id" => $id->id,
                "group" => $id->group,
                "amount" => 10,
                "cost_price" => 10.00,
                "sale_price" => 120.00,
                "profit_percentage" => 100,
                "ncm" => 12345678,
                "cest" => 1234567,
                "csosncst" => 102,
                "cfop" => 5102,
            ],
            [
                "product" => "Jack Daniels Honey",
                "group_id" => $id->id,
                "group" => $id->group,
                "amount" => 10,
                "cost_price" => 10.00,
                "sale_price" => 130.00,
                "profit_percentage" => 100,
                "ncm" => 12345678,
                "cest" => 1234567,
                "csosncst" => 102,
                "cfop" => 5102,
            ],
            [
                "product" => "Jack Daniels Canela",
                "group_id" => $id->id,
                "group" => $id->group,
                "amount" => 10,
                "cost_price" => 10.00,
                "sale_price" => 140.00,
                "profit_percentage" => 100,
                "ncm" => "12345678",
                "cest" => "123456",
                "csosncst" => "102",
                "cfop" => "5102",
            ],
        ];

        foreach($products as $product){
            Products::create($product);
        }
    }
}
