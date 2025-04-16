<?php

namespace App\Models;

use App\Models\HotelModels\Reservation;
use App\Models\CustomerCredit;
use App\Models\EcommerceModels\PDV;
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
        'type',
    ];

    public function joinCredit()
    {
        return $this->hasMany(CustomerCredit::class, 'customer_id');

    }
}
