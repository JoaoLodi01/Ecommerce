<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ItensPDV extends Model
{
<<<<<<< HEAD:api/app/Models/EcommerceModels/FormaPagamentoNfce.php
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
=======
    protected $table = '';
    
>>>>>>> 802d3bb03fc86b4e442dcac5d0aa85d99a734f11:api/app/Models/EcommerceModels/ItensPDV.php
}
