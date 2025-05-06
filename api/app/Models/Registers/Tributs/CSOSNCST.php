<?php

namespace App\Models\Registers\Tributs;

use Illuminate\Database\Eloquent\Model;

class CSOSNCST extends Model
{
    protected $table = 'csosn_csts';

    protected $fillable = [
        'issuer_id',
        'cod',
        'decription',
    ];
}
