<?php

namespace App\Models\HotelModels;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;

class HotelDetail extends Model
{
    use HasFactory, Notifiable;
    
    protected $table = 'hotel_details';

    protected $fillable = [
        'number_of_rooms',
        'number_of_employees',
        'total_busy_rooms',
        'active',
        'end_date'
        
    ];
}
