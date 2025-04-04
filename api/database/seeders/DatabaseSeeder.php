<?php

namespace Database\Seeders;

use App\Models\EcommerceModels\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            PaymentsSeeder::class,
            ProductsSeeder::class,
            CostumerSeeder::class,
            UserSeeder::class,
            HotelSeeder::class,
            ConfigSeeder::class
            
        ]);

    }
}
