<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\{
    ConfigHotel,
    ConfigPDV
};

class ConfigSeeder extends Seeder
{
    public function run(): void
    {
        ConfigHotel::create();
        ConfigPDV::create([
            'filter_search' => 'Cód barras interno'
        ]);
    }
}
