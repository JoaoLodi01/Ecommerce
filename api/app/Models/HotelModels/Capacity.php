<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Capacity extends Model
{
    protected $table = 'capacities';
    protected $fillable = [
        'room_id',
        'capacity'
    ];
}
