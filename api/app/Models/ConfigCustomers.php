<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfigCustomers extends Model
{
    protected $table = 'config_customers';

    protected $fillable = [ 
        'issuer_id',
        'config_customer_cod',
        'allow_addres_null',
        'allow_cnpj_null',
        'allow_cpf_null',
        'default_register',

    ];
}
