<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;

class Customer extends Model
{
    use HasFactory, Notifiable;

    protected $table = 'customers';
    
    protected $fillable = [
        'name',
        'cnpj',
        'cpf',
        'address',
        'number',
        'account',
        'password',
        'active',
    ];
}
