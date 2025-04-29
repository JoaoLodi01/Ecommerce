<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ItensPDV extends Model
{
    protected $table = 'itens_pdvs';

    protected $fillable = [
        'issuer_id',
        'pdv_id',
        'product_id',    
        'product',
        'cost_price',
        'sale_price',
        'cfop',
        'csosn',
        'ncm',
        'cest',
        'unit',
        'amount',
        'addition',
        'discount',
        'user_id',
        'seller',
        'is_nfce_nm',
        'finished',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
