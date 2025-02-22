<?php

namespace App\Models\HotelModels;

use Illuminate\Database\Eloquent\Model;

class CustomerCredit extends Model
{
    protected $table = '';

    protected $fillable = [
        'customer_id',
        'name',
        'current_credit',
        'validate'
    ];
}
