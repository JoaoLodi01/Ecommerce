<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Grupos extends Model
{
    protected $table = 'payments';

    protected $fillable = [
        'descricao',
        'tipolancamento',
        'active',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];
}
