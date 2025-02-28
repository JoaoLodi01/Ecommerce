<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CashRegister extends Model
{
    protected $table = 'cash_registers';

    protected $fillable = [
        'description',
        'cliente_id',
        'cliente',
        'especie_id',
        'especie',
        'data_hora_cadastro',
        'valor_entrada',
        'valor_saida',
        'saldo_real',
        'origem',
        'user_id',
        'seller',
        'canceled',
        
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
