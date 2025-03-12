<?php

namespace App\Http\Requests\EcommerceRequest;

use Illuminate\Foundation\Http\FormRequest;

class PDVSaleRequest extends FormRequest
{

    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'description' => ['required', 'string' , 'max:120'],
            'products' => ['required', 'array'],
            'user_id' => ['required'], // 'exists:users,id' add depois
            'customer_id' => ['required'], // , 'exists:customer,id' 
            'total' => ['required', 'numeric'],
            'sub_total' => ['required', 'numeric'],
            'addition' => ['required', 'numeric'],
            'discount' => ['required', 'numeric'],
            'is_nfce_nm' => ['required'],

        ];
    }
}