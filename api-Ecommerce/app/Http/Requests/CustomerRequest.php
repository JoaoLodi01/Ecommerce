<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CustomerRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {

        $required = $this->isMethod('post') ? 'required' : 'sometimes';
        return [
            'name' => [$required, 'string', 'max:120'],
            'cnpj' => 'nullable|required_without:cpf',
            'cpf' => 'nullable|required_without:cnpj',
            'address' => [$required, 'string', 'max:120'],
            'number' => [$required, 'max:20'],
            'account' => [$required, 'string', 'max:120'],
            'password' => [$required, 'string', 'max:120'],
        ];
    }

    public function messages(): array
    {
        return [
            'name.required' => 'O campo nome é obrigátorio',
            'name.max' => 'O campo nome passou do seu limite: :max caracteres',
            'name.string' => 'O campo nome deve ser texto válido',

            'cnpj.required_without:cpf' => 'O campo CNPJ é obrigátorio se não informado um CPF',
            'cnpj.max' => 'O campo CNPJ passou do seu limite: :max caracteres',
            'cnpj.string' => 'O campo CNPJ deve ser texto válido',

            'cpf.required_without:cnpj' => 'O campo CPF é obrigátorio se não informado um CNPJ',
            'cpf.max' => 'O campo CPF passou do seu limite: :max caracteres',
            'cpf.string' => 'O campo CPF deve ser texto válido',

            'address.required' => 'O campo endereço é obrigátorio',
            'address.max' => 'O campo endereço passou do seu limite: :max caracteres',

            'number.required' => 'O campo numéro do endereço é obrigátorio',
            'number.max' => 'O campo numéro do endereço passou do seu limite: :max caracteres',
            
            'account.required' => 'O campo conta é obrigátorio',
            'account.max' => 'O campo conta passou do seu limite: :max caracteres',

            'password.required' => 'O campo senha é obrigátorio',
            'password.max' => 'O campo senha passou do seu limite: :max caracteres',

        ];
    }

}
