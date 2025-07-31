<?php

namespace App\Models\Registers;

use Illuminate\Database\Eloquent\Model;

class Issuer extends Model
{
    protected $table = 'issuers';

    protected $fillable = [
        'company_name',
        'trade_name',
        'cnpj',
        'cpf',
        'uf',
        'cod_ibge',
        'city',
        'address',
        'number',
        'cep',
        'ie',
        'im',
        'main_activity',
        'cod_cnae',
        'cnae',
        'cod_crt',
        'crt',
        'date_of_foundation',
        'user_code',
        'active',
        
    ];
}
