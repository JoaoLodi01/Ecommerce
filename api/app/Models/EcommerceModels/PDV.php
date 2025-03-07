<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class PDV extends Model
{
    protected $table = 'pdvs';

    protected $fillable = [
        'descricao',
        'cliente_id',
        'cliente',
        'valor_bruto',
        'valor_liquido',
        'valor_desconto',
        'valor_acrescimo',
        'user_id',
        'seller',
        'finished',
        'canceled',
        'is_nfce_nm',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
