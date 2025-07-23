<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfigCustomers extends Model
{
    protected $table = 'config_customers';

    protected $fillable = [ 
        'issuer_id',
        'config_customer_code',
        'validate_cnpj',
        'validate_cpf',
        'validate_addres',
        'validate_trade_name',
        'validate_phone',
        'edit_by_button',
        'last_filter',

    ];
}
