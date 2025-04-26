<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Issuer extends Model
{
    protected $table = 'issuers';

    protected $fillable = [
        'company_name',
        'trade_name',
        'cnpj',
        'cpf',
        'address',
        'number',
        'cep',
        'owner_id',
        'active',
        
    ];
}
