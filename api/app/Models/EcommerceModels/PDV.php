<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class PDV extends Model
{
    protected $table = 'pdvs';

    protected $fillable = [
        'descricao',
<<<<<<< HEAD:api/app/Models/EcommerceModels/Nfce.php
        'documento',
=======
        'cliente_id',
        'cliente',
>>>>>>> 802d3bb03fc86b4e442dcac5d0aa85d99a734f11:api/app/Models/EcommerceModels/PDV.php
        'valor_bruto',
        'valor_liquido',
        'valor_desconto',
        'valor_acrescimo',
        'user_id',
        'seller',
        'cancelada',
        'is_nfce_nm',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
