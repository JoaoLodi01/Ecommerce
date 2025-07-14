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
        'pdv_code',
        'receive_cod',
        'receive_document',
        'customer_code',
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
}
