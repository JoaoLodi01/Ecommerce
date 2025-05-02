<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ConfigPDV extends Model
{
    protected $table = 'config_pdvs';
    protected $fillable = [
        'issuer_id',
        'filter_search',
        'filter_search_customer',
        'nm_finaly',
        'sale_negative_or_reset',
        
        
    ];
}
