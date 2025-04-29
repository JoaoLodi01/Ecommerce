<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Registrations extends Model
{
    protected $table = 'registrations';

    protected $fillable = [
        'issuer_id',
        'complete_issuer',
        'complete_config_customer',
        'complete_config_pdv'
        
    ];
}
