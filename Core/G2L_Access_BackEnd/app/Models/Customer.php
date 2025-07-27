<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    protected $table = 'customers';

    protected $fillable = [
       'full_name',
       'email',
       'cpf',
       'active_license',
       'pay',
       'active',
    ]; 
}
