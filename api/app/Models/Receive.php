<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Receive extends Model
{
    protected $table = 'receives';

    protected $fillable = [
        'receive_cod',
        'issuer_id',
        'description',
        'customer_id',
        'name',
        'especie_id',
        'especie',
        'date_register',
        'due_date',
        'installment_number', // nmr parcela
        'installment_value', // valor da parcela
        'type_interest', // Tipo de juros
        'interest_value', // valor de juros
        'total_amount', // Valor total
        'origem',
        'canceled',
        'user_id',
        'user',
        
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
