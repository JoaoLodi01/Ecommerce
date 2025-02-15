<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;

class DetailRooms extends Model
{
    use HasFactory, Notifiable;

    protected $table = 'detail_rooms';

    protected $fillable = [
        'capacity',
        'price_for_night',
        'busy',
        'hotel_id',
        'number_room',

    ];

    protected $hidden = [
        'hotel_id'
    ];
}
