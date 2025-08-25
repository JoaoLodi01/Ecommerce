<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MailHistory extends Model
{
    protected $table = 'mail_histories';

    protected $fillable = [
        'issuer_id',
        'mail_histories_code',
        'mail_used',
        'to',
        'from',
        'shipping_date',
        'success',
    ];
}
