<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ErrorsPDV extends Model
{
    protected $table = 'errors_pdvs';

    protected $fillable = [
        'title',
        'incorret_cfop',
        'incorret_csosn_cst',
        'completed',
        'pdv_id',

    ];
}
