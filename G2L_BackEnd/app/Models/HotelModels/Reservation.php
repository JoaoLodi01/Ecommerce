<?php

namespace App\Models\HotelModels;

use App\Models\Customer;
use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
    protected $table = 'reservations';
    protected $fillable = [
        'customer_id',
        'name',
        'room_id'
        
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
}
