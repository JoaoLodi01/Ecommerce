<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class ErrorsPDV extends Model
{
    protected $table = 'errors_pdvs';

    protected $fillable = [
        'issuer_id',
        'title',
        'incorret_cfop',
        'incorret_csosn_cst',
        'completed',
        'pdv_id',

    ];
}
