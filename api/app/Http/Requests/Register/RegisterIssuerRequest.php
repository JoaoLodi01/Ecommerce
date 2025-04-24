<?php

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
            'name' => ['required', 'string'],
            'cnpj' => ['required', 'string'],
            'cpf' => ['required', 'string'],
            'address' => ['required', 'string'],
            'number' => ['required', 'string'],
            'cep' => ['required', 'string'],
            'email' => ['required', 'email'],
            'phone' => ['required', 'string']
        ];
    }
}