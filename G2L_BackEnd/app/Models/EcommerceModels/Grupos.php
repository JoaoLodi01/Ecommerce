<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class Grupos extends Model
{
    protected $table = 'groups';

    protected $fillable = [
        'group_code',
        'group'
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
