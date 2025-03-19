<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\HotelModels\HotelDetail as Hotel;

class HotelSeeder extends Seeder
{
    public function run(): void
    {
        $hotel = [
            'name' => 'Hotel Exemplo',
            'cnpj' => '12345678000195',
            'email' => 'contato@hotelexemplo.com',
            'cep' => '01001000',
            'address' => 'Rua Exemplo, Centro',
            'number' => 100,
            'number_of_rooms' => 50,
            'number_of_employees' => 30,
            'cod_cnae' => 1,
            'cnae' => '5510801',
            'cod_crt' => 1,
            'crt' => 'Simples Nacional',
        ];

        Hotel::create($hotel);
    }
}
