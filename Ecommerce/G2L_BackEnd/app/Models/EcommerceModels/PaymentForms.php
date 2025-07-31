<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class PaymentForms extends Model
{
    protected $table = 'payments_forms';

    protected $fillable = [
        'payment_code',
        'issuer_id',
        'especie',
        'tipo_lancamento',
        'payments_form_type',
        'pix_key',
        'bank_key',
        'other_key',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];

}
