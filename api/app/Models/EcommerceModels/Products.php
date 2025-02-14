<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    protected $table = 'Products';

    protected $fillable = [
        'produto',
        'quantidade',
        'preco_custo',
        'preco_venda',
        'NCM',
        'CEST',
        'CSOSN',
        'CFOP',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
