<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ChartofAccounts extends Model
{
    protected $table = 'chart_of_accounts';

    protected $fillable = [
        'chart_of_account_code',
        'issuer_id',
        'code',
        'name',
        'type',
        'level',
        'is_analytic',
        'is_active'
    ];
}
