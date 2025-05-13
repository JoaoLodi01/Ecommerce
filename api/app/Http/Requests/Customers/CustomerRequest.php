<?php

namespace App\Http\Requests\Customers;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class CustomerRequest extends FormRequest
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
            'issuer_id' => ['required'],
            'company_name' => ['nullable', 'required_without:trade_name', 'string', 'max:120'],
            'trade_name' => ['nullable', 'required_without:company_name', 'string', 'max:120'],
            'cpf' => ['sometimes', 'unique:customers,cpf'],
            'cnpj' => ['sometimes', 'unique:customers,cnpj'],
            'cep' => ['required'],
            'address' => ['required'],
            'number' => ['required'],
            'email' => ['sometimes', 'email', 'max:120'],
            'phone' => ['sometimes', 'max:120'],
            'is_customer' => ['required'],
            'is_driver' => ['required'],
            'is_supplier' => ['required']

        ];
    }

    public function messages(): array
    {
        return [
            'name.required' => 'O nome é obrigatório',
            'name.string' => 'O nome deve estar em um formato válido',
            'name.max' => 'O nome passou do limite do campo, :max',

            'cpf.required' => 'O CPF é obrigatório',
            'cnpj.required' => 'O CNPJ é obrigatório',

            'cep.required' => 'O CEP é obrigatório',
            'address.required' => 'O endereço é obrigatório',
            'number.required' => 'O número do endereço é obrigatório',

            'email.required' => 'O e-mail é obrigatório',
            'email.email' => 'O e-mail deve estar em um formato válido',
            'email.max' => 'O e-mail passou do limite do campo, :max',

            'phone.required' => 'O telefone é obrigatório',
            'phone.max' => 'O telefone passou do limite do campo, :max'
        ];
    }
}
