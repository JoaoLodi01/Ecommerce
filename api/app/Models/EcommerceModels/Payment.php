<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    protected $table = 'payments_forms';

    protected $fillable = [
        'payment_cod',
        'issuer_id',
        'especie',
        'tipo_lancamento',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];

}
