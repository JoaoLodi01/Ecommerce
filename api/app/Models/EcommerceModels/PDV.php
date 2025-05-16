<?php

namespace App\Models\EcommerceModels;

use Illuminate\Database\Eloquent\Model;

class PDV extends Model
{
    protected $table = 'pdvs';

    protected $fillable = [
        'pdv_cod',
        'issuer_id',
        'description',
        'issue_date',
        'n_nfce',
        'customer_id',
        'customer',
        'gross_value',
        'net_value',
        'discount',
        'addition',
        'user_id',
        'user',
        'finished',
        'canceled',
        'is_nfce_nm',
        'status'
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
    ];

    public function getItens()
    {
        return $this->hasMany(ItensPDV::class, 'pdv_cod');
    }
}
