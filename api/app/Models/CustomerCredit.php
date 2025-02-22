<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerCredit extends Model
{
    protected $table = 'customer_credits';

    protected $fillable = [
        'customer_id',
        'name',
        'current_credit',
        'validate'
    ];
}
