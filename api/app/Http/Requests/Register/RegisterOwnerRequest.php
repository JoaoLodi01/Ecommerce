<?php

use Illuminate\Foundation\Http\FormRequest;

class RegisterOwnerRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['required', 'string'],
            'surname' => ['required', 'string'],
            'cpf' => ['required', 'string'],
            'phone' => ['required', 'string'],
            'email' => ['required', 'email'],
            'forgot_email' => ['required', 'email'],
            'password' => ['required', 'string'],
            'address' => ['required', 'string'],
            'number' => ['required', 'string'],
            'cep' => ['required', 'string'],
        ];

    }
}