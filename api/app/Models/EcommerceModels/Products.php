<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    protected $table = 'Products';
    
    protected $fillable = [
        'product',
        'amount',
        'group_id',
        'group',
        'price_cost',
        'sale_price',
        'ncm',
        'cest',
        'csosn',
        'cfop',
        'unit',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
