<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ConfigPDV extends Model
{
    protected $table = 'config_pdvs';
    protected $fillable = [
        'issuer_id',
        'config_pdv_code',
        'n_nfce',
        'filter_search',
        'filter_search_customer',
        'nm_finaly',
        'sale_negative_or_reset',
        'validate_gtin',
        'supervisor_password_cancel_sale',
        'supervisor_password_delete_item',
        'img'
        
    ];
}
