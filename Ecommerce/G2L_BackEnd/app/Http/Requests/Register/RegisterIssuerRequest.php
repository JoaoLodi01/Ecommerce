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
            'companyName' => ['required', 'string'],
            'tradeName' => ['required', 'string'],
            'cnpj' => ['nullable', 'string', 'required_without:cpf'],
            'cpf' => ['nullable', 'string', 'required_without:cnpj'],
            'uf' => ['sometimes'],
            'codIbge' => ['sometimes'],
            'city' => ['sometimes'],
            'address' => ['sometimes'],
            'number' => ['sometimes'],
            'cep' => ['sometimes'],
            'ie' => ['sometimes'],
            'im' => ['sometimes'],
            'mainActivity' => ['sometimes'],
            'codCnae' => ['sometimes'],
            'cnae' => ['sometimes'],
            'codCrt' => ['sometimes'],
            'crt' => ['sometimes'],
            'dateOfFoundation' => ['sometimes', 'date'],
            'uuse_id' => ['required']
            
        ];
    }
}