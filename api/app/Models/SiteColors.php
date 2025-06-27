<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SiteColors extends Model
{
    protected $table = 'site_colors';

    protected $fillable = [
        'issuer_id',
        'color_cod',
        'button_color',
        'painel_color'
    ];
}
