<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class CashRegister extends Model
{
    protected $table = 'cash_registers';

    protected $fillable = [
        'cash_register_code',
        'issuer_id',
        'description',
        'status',
        'document',
        'pdv_code',
        'receive_code',
        'receive_document',
        'customer_code',
        'name',
        'especie_code',
        'especie',
        'chart_of_account_code',
        'cost_center_code',
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
