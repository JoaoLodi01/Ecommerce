<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ItensPDV extends Model
{
    protected $table = 'itens_pdvs';

    protected $fillable = [
        'iten_pdv_code',
        'issuer_id',
        'pdv_code',
        'product_code',    
        'product',
        'cost_price',
        'sale_price',
        'cfop',
        'csosncst',
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
