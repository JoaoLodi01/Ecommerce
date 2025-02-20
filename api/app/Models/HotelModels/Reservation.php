<?php

namespace App\Models\HotelModels;

use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
    protected $table = 'reservations';
    protected $fillable = [
        'user_id',
        'name',
        'room_id',
        'room_number',
        
    ];
}
