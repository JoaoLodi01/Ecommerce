<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Receive extends Model
{
    protected $table = 'receives';

    protected $fillable = [
        'receive_code',
        'issuer_id',
        'document',
        'description',
        'customer_code',
        'especie_code',
        'dav_code',
        'pdv_code',
        'chart_of_account_code',
        'cost_center_code',
        'name',
        'status',
        'especie',
        'due_date',
        'installment_amount',   // Quantidade de parcelas
        'installment_number',   // Número da parcela
        'installment_value',    // Valor original
        'installment_paid',     // Valor pago
        'date_paid',
        'installment_cod',
        'type_interest',
        'interest_value',
        'origem',
        'user_id',
        'user',
        'canceled',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
