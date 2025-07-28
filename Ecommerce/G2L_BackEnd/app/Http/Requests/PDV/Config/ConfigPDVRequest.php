<?php

namespace App\Http\Requests\PDV\Config;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ConfigPDVRequest extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check();;
    }

    public function rules(): array
    {
        return [
            'issuer_id' => ['required'],
            'searchOptionProduct' => ['required'],
            'searchOptionCustomers' => ['required'],
            'nmFinaly' => ['required'],
            'saleNegativeorReset' => ['required'],
            'supervisorPasswordCancelSale' => ['required'],
            'supervisorPasswordDeleteItem' => ['required']
            
        ];
    }
}