<?php

namespace App\Http\Requests\Customers\Config;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ConfigCustomerRequest extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [    
            'validateCNPJ' => ['sometimes'],
            'validateCPF' => ['sometimes'],
            'validateAddres' => ['sometimes'],
            'validateTradeName' => ['sometimes'],
            'validatePhone' => ['sometimes'],
            'editByButton' => ['sometimes'],
            'lastFilter' => ['sometimes'],
            
        ];
    }

    public function messages(): array
    {
        return [
        ];
    }
}
