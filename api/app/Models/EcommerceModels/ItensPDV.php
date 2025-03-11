<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ItensPDV extends Model
{
    protected $table = 'itens_pdvs';

    protected $fillable = [
        'pdvs_id',
        'products_id',
        'product',
        'amount_sold',
        'addition',
        'discount',
        'seller_id',
        'seller',
        'finished',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
