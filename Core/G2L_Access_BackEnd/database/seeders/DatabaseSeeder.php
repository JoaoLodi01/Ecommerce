<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();
        $users = [
            [
                'name' => 'Gabriel Kochem',
                'email' => 'gabikochem55@gmail.com',
                'password' => 'Lego.0912@'
            ],
            [
                'name' => 'João Lodi',
                'email' => 'joaolodi01@gmail.com',
                'password' => '11505315921@'
                
            ],
        ];

        foreach($users as $user){
            User::create($user);

        }   
    }
}
