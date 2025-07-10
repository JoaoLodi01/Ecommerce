<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class ConfigProducts extends Model
{
    protected $table = 'config_products';

    protected $fillable = [
        'issuer_id',
        'config_product_cod',
        'default_profit_percentage',
        'validate_gtin',
        'reserve_dav_quantity',
        'allow_profit_zero',
        
    ];
}
