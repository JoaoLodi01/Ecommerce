<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CashRegister extends Model
{
    protected $table = 'cash_registers';

    protected $fillable = [
        'issuer_id',
        'description',
        'document',
        'pdv_id',
        'customer_id',
        'name',
        'especie_id',
        'especie',
        'date_register',
        'input_value',
        'output_value',
        'real_balance',
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
