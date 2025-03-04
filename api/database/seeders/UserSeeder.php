<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\EcommerceModels\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            [
                'name' => 'Kochem',
                'email' => 'gabikochem55@gmail.com',
                'password' => Hash::make('k')
            ],
            [
                'name' => 'Lodi',
                'email' => 'joao.lodi@gmail.com',
                'password' => Hash::make('l')

            ]
        ];

        foreach ($users as $user) {
            User::create($user);
            
        }
    }
}
