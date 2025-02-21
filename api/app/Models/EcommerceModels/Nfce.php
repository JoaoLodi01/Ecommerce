<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Nfce extends Model
{
    protected $table = 'nfces';

    protected $fillable = [
        'descricao',
        'documento',
        'valor_bruto',
        'valor_liquido',
        'valor_desconto',
        'forma_pagamento',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
