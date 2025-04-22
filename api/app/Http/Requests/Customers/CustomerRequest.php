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
        $required = $this->isMethod('POST') ? 'required' : 'sometimes';
        return [
            'name' => [$required, 'string', 'max:120'],
            'cpf' => ['nullable', 'required_without:cnpj'],
            'cnpj' => ['nullable', 'required_without:cpf'],
            'cep' => [$required],
            'address' => [$required],
            'number' => [$required],
            'email' => [$required, 'email', 'max:120'],
            'phone' => [$required, 'max:120'],
            'is_customer' => [$required],
            'is_driver' => [$required],
            'is_supplier' => [$required]

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
