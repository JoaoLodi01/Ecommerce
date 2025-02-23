<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Nfce extends Model
{
    protected $table = 'nfces';

    protected $fillable = [
        'descricao',
        'cliente_id',
        'cliente',
        'valor_bruto',
        'valor_liquido',
        'valor_desconto',
        'user_id',
        'user',
        'cancelada',
        'is_nfce_nm',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
