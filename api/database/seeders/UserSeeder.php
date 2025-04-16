<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            [
                'name' => 'admin',
                'email' => 1,
                'password' => Hash::make(1),
                'access' => 'Adminstrador'
            ],
            [
                'name' => 'Gabriel Kochem - Roxo',
                'email' => 'roxosgbr@gmail.com',
                'password' => Hash::make(2),
                'access' => 'Supervisor'
            ],
            [
                'name' => 'Gabriel Kochem',
                'email' => 'gabikochem55@gmail.com',
                'password' => Hash::make(2),
                'access' => 'Limitado'
            ],
           
        ];

        foreach ($users as $user) {
            User::create($user);
            
        }
    }
}
