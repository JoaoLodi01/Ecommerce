<?php

namespace App\Models\HotelModels;

use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    protected $table = 'rooms';
    protected $fillable = [
        'customer_id',
        'customer',
        'room_id',
        'number_room',
        'start_period',
        'end_period',
        'active',

    ];

    protected $hidden = [
        'room_id',
    ];

    public function checkAllActive()
    {
        return $this->where('active', 1)->get();

    }
}
