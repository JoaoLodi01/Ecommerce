<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class CashRegisterRequest extends FormRequest
{
    public function authorize(): bool
    {
        // Verifica se o usuário está autenticado
        return Auth::check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        // Condicional para definir o campo 'required' ou 'sometimes' com base no método da requisição
        $required = $this->isMethod('POST') ? 'required' : 'sometimes';

        return [
            'issuer_id' => ['required'],
            'description' => [$required, 'string', 'max:255'],
            'document' => [$required, 'integer'],
            'customer_code' => [$required, 'integer'],
            'especie_code' => [$required, 'integer'],
            'user_id' => ['required'],
            'origem' =>  ['required'],
            'input_value' => [$required, 'numeric'],
            'output_value' => [$required, 'numeric'],
        ];
    }

    public function messages(): array
    {
        return [
            'issuer_id.required' => 'O ID do emissor é obrigatório.',
            
            'description.required' => 'A descrição é obrigatória.',
            'description.string' => 'A descrição deve estar em um formato válido.',
            'description.max' => 'A descrição não pode ter mais de :max caracteres.',
            
            'document.required' => 'O documento é obrigatório.',
            'document.integer' => 'O documento deve ser um número inteiro.',
            
            'pdv_id.required' => 'O ID do PDV é obrigatório.',
            'pdv_id.integer' => 'O ID do PDV deve ser um número inteiro.',
            
            'customer_id.required' => 'O ID do cliente é obrigatório.',
            'customer_id.integer' => 'O ID do cliente deve ser um número inteiro.',
            
            'especie_id.required' => 'O ID da espécie é obrigatório.',
            'especie_id.integer' => 'O ID da espécie deve ser um número inteiro.',
            
            'especie.required' => 'A espécie é obrigatória.',
            'especie.string' => 'A espécie deve estar em um formato válido.',
            'especie.max' => 'A espécie não pode ter mais de :max caracteres.',

            'input_value.required' => 'O valor de entrada é obrigatório.',
            'input_value.numeric' => 'O valor de entrada deve ser um número válido.',
            
            'output_value.required' => 'O valor de saída é obrigatório.',
            'output_value.numeric' => 'O valor de saída deve ser um número válido.',
            
            'user_id.required' => 'O ID do usuário é obrigatório.',
            'user_id.integer' => 'O ID do usuário deve ser um número inteiro.',
        
        ];
    }
}
