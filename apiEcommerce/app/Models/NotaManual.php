<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class NotaManual extends Model
{
    protected $table = 'nota_manuais';

    protected $fillable = [
        'descricao',
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
