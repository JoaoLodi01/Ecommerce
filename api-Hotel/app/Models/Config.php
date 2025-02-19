<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Config extends Model
{
<<<<<<< HEAD
    protected $table = 'config';
=======
    protected $table = 'configs';
>>>>>>> 725be6fcf3bd5ddc2292c3271fcf35145ffd3ca8
    protected $fillable = [
        'address_by_cep',
        'room_service_limit',
        'partial_registration', 
        'active'
    ];
}
