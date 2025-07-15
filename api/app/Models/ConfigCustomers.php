<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfigCustomers extends Model
{
    protected $table = 'config_customers';

    protected $fillable = [ 
        'issuer_id',
        'config_customer_cod',
        'validate_cnpj',
        'validate_cpf',
        'validate_addres',
        'last_filter',

    ];
}
