<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Receive extends Model
{
    protected $table = 'receives';

    protected $fillable = [
        'receive_cod',
        'issuer_id',
        'document',
        'description',
        'customer_cod',
        'name',
        'especie_cod',
        'especie',
        'due_date',
        'installment_amount', // qtde parcelas
        'installment_number', // nmr parcela
        'installment_value', // valor parcela
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
