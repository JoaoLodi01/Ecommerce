<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class PayMentMethod extends Model
{
    protected $table = 'pay_ment_methods';

    protected $fillable = [
        'payment_method',
        'amount_paid',
        'customer_id',
        'customer',
        'payment_period'

    ];
}
