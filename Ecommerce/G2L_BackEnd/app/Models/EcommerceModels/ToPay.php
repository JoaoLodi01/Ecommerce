<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ToPay extends Model
{
    protected $table = 'to_pays';

    protected $fillable = [
        'to_pay_code',
        'issuer_id',
        'document',
        'description',
        'chart_of_account_code',
        'cost_center_code',
        'customer_code',
        'name',
        'dav_code',
        'especie_code',
        'especie',
        'due_date',
        'installment_amount', // qtde parcelas
        'installment_number', // nmr parcela
        'installment_value', // valor parcela
        'type_interest', // Tipo de juros
        'interest_value', // valor de juros
        'total_amount', // Valor total
        'addition',
        'discount',
        'value_entry', 
        'value_to_pay', 
        'value_original', 
        'origem',
        'canceled',
        'user_id',
        'user',

    ];
}
