<?php

namespace App\Models\HotelModels;

use Illuminate\Database\Eloquent\Model;

class ConfigHotel extends Model
{
    protected $table = 'configs_hotel';
    protected $fillable = [
        'issuer_id',
        'address_by_cep',
        'room_service_limit',
        'partial_registration', 
        'active'
    ];
}
