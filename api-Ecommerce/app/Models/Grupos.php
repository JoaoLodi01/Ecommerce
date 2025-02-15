<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Grupos extends Model
{
    protected $table = 'grupos';

    protected $fillable = [
        'grupo'
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
