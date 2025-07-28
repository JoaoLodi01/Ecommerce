<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CostCenter extends Model
{
    protected $table = 'cost_centers';

    protected $fillable = [
        'cost_center_code',
        'issuer_id',
        'code',
        'name',
        'level',
        'is_active',
        'is_analytic',
    ];
}
