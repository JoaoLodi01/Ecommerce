<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CashRegister extends Model
{
    protected $table = 'cash_registers';

    protected $fillable = [
        'description',
        'valor_entrada',
        'valor_saida',
        'saldo_real',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
