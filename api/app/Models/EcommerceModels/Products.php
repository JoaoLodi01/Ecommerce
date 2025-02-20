<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    protected $table = 'Products';

    protected $fillable = [
        'produto',
        'quantidade',
        'grupo_id',
        'grupo',
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
