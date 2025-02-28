<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Receive extends Model
{
    protected $table = 'receives';

    protected $fillable = [
        'description',
        'customer_id',
        'name',
        'especie_id',
        'especie',
        'date_register',
        'due_date',
        'installment_amount',
        'installment_number',
        'installment_value',
        'type_interest',
        'interest_value',
        'total_amount',
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
