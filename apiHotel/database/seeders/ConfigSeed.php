<?php

namespace Database\Seeders;

use App\Models\ConfigHotel;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ConfigSeed extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $configs = [
            'address_by_cep' => 1,
            'room_service_limit' => 2000

        ];

        ConfigHotel::create($configs);
    }
}
