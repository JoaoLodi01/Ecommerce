<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Consumer extends Model
{
    protected $table = 'consumers';

    protected $fillable = [
        'cliente',
        'CPF',
        'CNPJ',
        'email',
        'active',
        'phone',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
