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
        'customer_cod',
        'issuer_id',
        'name',
        'cnpj',
        'cpf',
        'cep',
        'address',
        'number',
        'email',
        'phone',
        'active',
        'is_customer',
        'is_driver',
        'is_supplier',
    ];

    public function joinCredit()
    {
        return $this->hasMany(CustomerCredit::class, 'customer_id');

    }
}
