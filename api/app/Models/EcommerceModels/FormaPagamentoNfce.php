<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class FormaPagamentoNfce extends Model
{
    protected $table = 'formas_pagamento_nfces';

    protected $fillable = [
        'cod_especie',
        'especie',
        'documento',
        'valor_bruto',
        'valor_liquido',
        'valor_desconto',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
