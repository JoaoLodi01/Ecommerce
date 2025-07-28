<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class Customer extends Model
{
    protected $table = 'customers';

    protected $fillable = [
        'code',
        'full_name',
        'email',
        'cpf',
        'active_license',
        'expire_license',
        'monthly_fee',
        'pay',
        'active',
        'hotel',
        'ecommerce',
        'site'

    ]; 
}
