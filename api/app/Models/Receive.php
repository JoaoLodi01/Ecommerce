<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Receive extends Model
{
    protected $table = 'receives';

    protected $fillable = [
        'descricao',
        'cliente_id',
        'cliente',
        'especie_id',
        'especie',
        'data_vencimento',
        'qtde_parcela',
        'numero_parcela',
        'valor_parcela',
        'tipo_juros',
        'valor_juros',
        'valor_total',
        'origem',
        'cancelada',
        'user_id',
        'user',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
