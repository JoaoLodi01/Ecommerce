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
            'uf' => ['sometimes', 'string'],
            'address' => ['sometimes', 'string'],
            'number' => ['sometimes', 'string'],
            'cep' => ['sometimes', 'integer'],
            'ie' => ['sometimes', 'string'],
            'im' => ['sometimes', 'string'],
            'date_of_foundation' => ['sometimes', 'date'],
            'main_activity' => ['sometimes', 'string'],
            'cod_cnae' => ['sometimes', 'integer'],
            'cnae' => ['sometimes', 'string'],
            'cod_crt' => ['sometimes', 'integer'],
            'crt' => ['sometimes', 'string'],
            'date_of_foundation' => ['sometimes', 'date'],
            'uuse_id' => ['required']
            
        ];
    }
}