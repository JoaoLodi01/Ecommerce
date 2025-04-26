<?php

namespace App\Http\Requests\Register;

use Illuminate\Foundation\Http\FormRequest;

class RegisterIssuerRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'company_name' => ['required', 'string'],
            'trade_name' => ['required', 'string'],
            'cnpj' => ['nullable', 'string', 'required_without:cpf'],
            'cpf' => ['nullable', 'string', 'required_without:cnpj'],
            'address' => ['required', 'string'],
            'number' => ['required', 'string'],
            'cep' => ['required', 'string'],
            'uuse_id' => ['required']
            
        ];
    }
}