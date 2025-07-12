<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    protected $table = 'Products';
    
    protected $fillable = [
        'product_code',
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
        'cest',
        'cfop',
        'unit',
        'csosncst',
        'active',
        'cod_origem_icms',
        'origem_icms',
        'icms_ecf',
        'taxable_amount',
        'taxable_unit',
        'tax_benefit',
        'cod_ipi',
        'aliquot_ipi',
        'cod_pis',
        'aliquot_pis',
        'cod_cofins',
        'aliquot_cofins',
        'cod_use_type',
        'use_type',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}