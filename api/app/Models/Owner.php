<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Contracts\Auth\CanResetPassword;

class Owner extends Authenticatable implements CanResetPassword 
{

    use HasApiTokens, Notifiable, HasFactory;
    
    protected $table = 'owners';

    protected $fillable = [
        'name',
        'surname',
        'cpf',
        'email',
        'password',
        'active',
        'uuse_id',
        
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];
}
