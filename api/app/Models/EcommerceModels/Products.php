<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    protected $table = 'Products';
    
    protected $fillable = [
        'product_cod',
        'issuer_id',
        'product',
        'image',
        'barcode',
        'barcode_internal',
        'amount',
        'group_id',
        'group',
        'cost_price',
        'sale_price',
        'profit_percentage',
        'ncm',
        'csosncst',
        'cest',
        'cfop',
        'unit',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}