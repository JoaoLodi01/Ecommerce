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
        'cfop',
        'csosn',
        'ncm',
        'cest',
        'unit',
        'amount_sold',
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
