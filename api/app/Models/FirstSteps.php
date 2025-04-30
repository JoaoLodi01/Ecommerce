<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FirstSteps extends Model
{
    protected $table = 'first_steps';
    protected $fillable = [
        'issuer_id',
        'complete_issuer',
        'complete_pdv',
        'complete_customers',
        'complete_products',
        'ignore_first_steps',
    ];
}
