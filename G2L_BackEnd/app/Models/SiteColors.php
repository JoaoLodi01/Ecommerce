<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SiteColors extends Model
{
    protected $table = 'site_colors';

    protected $fillable = [
        'issuer_id',
        'color_code',
        'button_color',
        'painel_color',
        'text_color'
    ];
}
