<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Owner extends Model
{
    protected $table = 'owners';

    protected $fillable = [
        'name',
        'surname',
        'cpf',
        'phone',
        'email',
        'forgot_email',
        'password',
        'address',
        'number',
        'cep',
        'active',
        
    ];
}
