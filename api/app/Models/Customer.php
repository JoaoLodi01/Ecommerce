<?php

namespace App\Models;

use App\Models\HotelModels\Reservation;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;

class Customer extends Model
{
    use HasFactory, Notifiable;

    protected $table = 'customers';
    
    protected $fillable = [
        'name',
        'cnpj',
        'cpf',
        'cep',
        'address',
        'number',
        'email',
        'phone',
        'active',
    ];

    public function reservation()
    {
        return $this->hasOne(Reservation::class, 'customer_id');
    }
}
