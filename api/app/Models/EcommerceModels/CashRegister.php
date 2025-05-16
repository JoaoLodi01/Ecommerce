<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class CashRegister extends Model
{
    protected $table = 'cash_registers';

    protected $fillable = [
        'cash_register_cod',
        'issuer_id',
        'description',
        'document',
        'pdv_cod',
        'customer_cod',
        'name',
        'especie_cod',
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
