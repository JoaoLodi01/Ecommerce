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
            'paymentsValues' => ['required'],
            'typeOperation' => ['required', 'string'],
            'pdvID' => ['required']

        ];
    }
}