<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Config extends Model
{
    protected $table = 'config_hotels';
    protected $fillable = [
        'address_by_cep',
        'room_service_limit',
        'partial_registration', 
        'active'
    ];
}
