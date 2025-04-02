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
                'password' => Hash::make(1)  
            ],
           
        ];

        foreach ($users as $user) {
            User::create($user);
            
        }
    }
}
