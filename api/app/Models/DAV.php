<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DAV extends Model
{
    protected $table = 'davs';
    
    protected $fillable = [
        'issuer_id',
        'dav_cod',
        'dav_number',
        'product',
        'cost_price',
        'sale_price',
        'unit',        
        'amount',
        'addition',
        'discount',
        'gross_value',
        'net_value',
        'discount',
        'addition',
        'status',
        'finished',
        'canceled',
        'type', 
        'title',
        'description', 
        
    ];
}
