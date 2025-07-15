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
        $required = $this->isMethod('PUT') ? 'required' : 'sometimes';

        return [
            'company_name' => ['required', 'string'],
            'trade_name' => ['required', 'string'],
            'cnpj' => ['nullable', 'string', 'required_without:cpf'],
            'cpf' => ['nullable', 'string', 'required_without:cnpj'],
            'uf' => [$required, 'string'],
            'cod_ibg' => [$required, 'string'],
            'city' => [$required, 'string'],
            'address' => [$required, 'string'],
            'number' => [$required, 'string'],
            'cep' => [$required, 'integer'],
            'ie' => ['sometimes', 'string'],
            'im' => ['sometimes', 'string'],
            'main_activity' => ['sometimes'],
            'cod_cnae' => [$required],
            'cnae' => [$required, 'string'],
            'cod_crt' => [$required],
            'crt' => [$required, 'string'],
            'date_of_foundation' => ['sometimes', 'date'],
            'uuse_id' => ['required']
            
        ];
    }
}