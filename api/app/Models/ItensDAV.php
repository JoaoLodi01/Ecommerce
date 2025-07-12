<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ItensDAV extends Model
{
    protected $table = 'itens_davs';

    protected $fillable = [
        'iten_dav_code',
        'issuer_id',
        'dav_code',
        'product_code',
        'product',
        'cost_price',
        'sale_price',
        'unit',     
        'amount',
        'addition',
        'discount',
        'gross_value',
        'net_value', 
        'status',
        'finished',
        'canceled',
        'type',
    ];
}