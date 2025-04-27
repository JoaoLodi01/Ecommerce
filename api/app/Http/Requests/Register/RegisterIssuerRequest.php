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
            'cep' => ['required', 'integer'],
            'cod_cnae' => ['required', 'integer'],
            'cnae' => ['required', 'string'],
            'cod_crt' => ['required', 'integer'],
            'crt' => ['required', 'string'],
            'date_of_foundation' => ['required', 'date'],
            'uuse_id' => ['required']
            
        ];
    }
}