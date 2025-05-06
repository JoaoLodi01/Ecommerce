<?php

namespace App\Models\Registers\Tributs;

use Illuminate\Database\Eloquent\Model;

class NCM extends Model
{
    protected $table = 'ncms';

    protected $fillable = [
        'issuer_id',
        'ncm',
        'description',
        'nacional_federal',
        'importados_federal',
        'estadual',
        'municipal',
        'inicio',
        'fim',
        'chave',
        'versao',
    ];
}
