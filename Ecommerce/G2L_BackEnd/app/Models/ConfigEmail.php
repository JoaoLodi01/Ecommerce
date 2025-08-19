<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ConfigEmail extends Model
{
    protected $table = 'configs_email';

    protected $fillable = [
        'issuer_id',
        'config_email_code',
        'host',
        'port',
        'user_name',
        'password',
        'use_tls',
        'use_ssl'
    ];    

    public function additionalEmails() {
        return $this->hasMany(AditionalEmail::class);
    }
}
