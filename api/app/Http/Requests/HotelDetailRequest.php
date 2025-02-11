<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class HotelDetailRequest extends FormRequest
{
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
        
        $required = $this->isMethod('POST') ? 'required' : 'sometimes';
    
        return [
            'name' => [$required, 'string', 'max:120'],
            'cnpj' => [$required, 'string', 'max:14'],
            'email' => [$required, 'string', 'max:170'],
            'cep' => [$required, 'string', 'max:8'],
            'address' => [$required, 'string', 'max:120'],
            'number' => [$required],
            'number_of_rooms' => [$required],
            'number_of_employees' => [$required],
            
        ];
        
    }

    public function messages(): array
    {
        return [
            'name.required' => 'O campo nome é obrigátorio',
            'name.max' => 'O campo nome passou do seu limite: :max caracteres',
            'name.string' => 'O campo nome deve ser texto válido',

            'cnpj.required' => 'O campo CNPJ é obrigátorio',
            'cnpj.max' => 'O campo CNPJ passou do seu limite: :max caracteres',
            'cnpj.string' => 'O campo CNPJ deve ser texto válido',

            'email.required' => 'O campo email é obrigátorio',
            'email.max' => 'O campo email passou do seu limite: :max caracteres',
            'email.string' => 'O campo email deve ser texto válido',

            'cnpj.required' => 'O campo CEP é obrigátorio',
            'cnpj.string' => 'O campo CEP deve ser texto válido',

            'address.required' => 'O campo endereço é obrigátorio',
            'address.max' => 'O campo endereço passou do seu limite: :max caracteres',

            'number.required' => 'O campo numero do endereço é obrigátorio',
            'number_of_rooms.required' => 'O campo numero de quartos é obrigátorio',
            'number_of_employees.required' => 'O campo numero de funcionários é obrigátorio'

        ];
    }

}
 
