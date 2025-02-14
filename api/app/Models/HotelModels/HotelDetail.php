<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;

class HotelDetail extends Model
{
    use HasFactory, Notifiable;
    
    protected $table = 'hotel_details';

    protected $fillable = [
        'name',
        'cnpj',
        'email',
        'cep', 
        'address',
        'number',
        'number_of_rooms',
        'number_of_employees',
        'total_busy_rooms',
        'active',
        'reserved'
        
    ];
}
