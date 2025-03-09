<?php

namespace App\Http\Requests\EcommerceRequest;

use Illuminate\Foundation\Http\FormRequest;

class PDVSaveSaleRequest extends FormRequest
{

    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'products' => ['required', 'array'],
            'seller_id' => ['required'], // 'exists:users,id' add depois
            'customer_id' => ['required'], // , 'exists:customer,id' 
            'sub_total' => ['required', 'numeric'],
            'addition' => ['required', 'numeric'],
            'discount' => ['required', 'numeric'],
            'is_nfce_nm' => ['sometimes'],

        ];
    }
}