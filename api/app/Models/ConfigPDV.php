<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfigPDV extends Model
{
    protected $table = 'config_pdvs';
    protected $fillable = [
        'nm_finaly',
        'sale_negative_or_reset',
        'filter_search'
        
    ];
}
