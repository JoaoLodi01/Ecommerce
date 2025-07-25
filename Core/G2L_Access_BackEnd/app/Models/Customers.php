<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Customers extends Model
{
    protected $table = 'customers';

    protected $fillable = [
       'full_name',
       'email',
       'cpf',
       'pay',
       'active',
    ]; 
}
