<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ConsumerRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
<<<<<<< HEAD
        return false;
=======
        return true;
>>>>>>> 96658b47bb8627f52fbbf805dfd9c6069f9312d0
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
<<<<<<< HEAD
        return [
            //
        ];
    }
=======
        $required = $this->isMethod('post') ? 'required' : 'sometimes';

        return [
            'cliente' => "$required|string|max:255",
            'CPF' => "nullable|cpf|unique:consumers,cpf|required_without:CNPJ",
            'CNPJ' => "nullable|cnpj|unique:consumers,cnpj|required_without:CPF",
            'email' => "$required|email|max:255|unique:consumers,email",
        ];
    }

    public function messages(): array{

        return[
            'cliente.required' => 'O campo cliente é obrigatório.',
            'CPF.required_without' => 'O campo CPF é obrigatório quando o CNPJ não for informado.',
            'CPF.cpf' => 'O CPF fornecido não é válido.',
            'CPF.unique' => 'O CPF fornecido já está cadastrado.',
            'CNPJ.required_without' => 'O campo CNPJ é obrigatório quando o CPF não for informado.',
            'CNPJ.cnpj' => 'O CNPJ fornecido não é válido.',
            'CNPJ.unique' => 'O CNPJ fornecido já está cadastrado.',
            'email.required' => 'O campo email é obrigatório.',
            'email.email' => 'O email fornecido não é válido.',
            'email.unique' => 'O email fornecido já está cadastrado.',   
        ];}
>>>>>>> 96658b47bb8627f52fbbf805dfd9c6069f9312d0
}
