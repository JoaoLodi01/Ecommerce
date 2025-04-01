<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AccessProfile extends Model
{
    protected $table = 'access_profiles';

    protected $fillable = [ 
        'user_id',
        'user',
        'access'
    ]; 
}
