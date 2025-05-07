<?php

namespace App\Models\Registers\Tributs;

use Illuminate\Database\Eloquent\Model;

class CFOP extends Model
{
    protected $table = 'cfops';

    protected $fillable = [
        'issuer_id',
        'cod',
        'decription',
    ];
}
