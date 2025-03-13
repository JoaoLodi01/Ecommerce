<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ItensPDV extends Model
{
    protected $table = 'itens_pdvs';

    protected $fillable = [
        'pdv_id',
        'product_id',
        'product',
        'amount_sold',
        'addition',
        'discount',
        'user_id',
        'user',
        'finished',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
