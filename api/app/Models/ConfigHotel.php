<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfigHotel extends Model
{
    protected $table = 'configs_hotel';
    protected $fillable = [
        'address_by_cep',
        'room_service_limit',
        'partial_registration', 
        'active'
    ];
}
