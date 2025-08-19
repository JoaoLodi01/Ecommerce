<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AditionalEmail extends Model
{
    protected $table = 'aditional_emails';
    protected $fillable = [
        'issuer_id',
        'aditional_email_code',
        'mail'
    ];
}
