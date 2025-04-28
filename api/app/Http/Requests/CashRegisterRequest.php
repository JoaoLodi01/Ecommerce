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
            'issuer_id' => [$required, 'integer'],
            'description' => [$required, 'string', 'max:255'],
            'document' => [$required, 'integer'],
            'pdv_id' => [$required, 'integer'],
            'customer_id' => [$required, 'integer'],
            'name' => [$required, 'string', 'max:255'],
            'especie_id' => [$required, 'integer'],
            'especie' => [$required, 'string', 'max:255'],
            'date_register' => [$required, 'date'],
            'input_value' => [$required, 'numeric'],
            'output_value' => [$required, 'numeric'],
            'real_balance' => [$required, 'numeric'],
            'origem' => [$required, 'string'],
            'user_id' => [$required, 'integer'],
            'seller' => [$required, 'string', 'max:255'],
            'canceled' => ['nullable', 'boolean'],
        ];
    }

    public function messages(): array
    {
        return [
            'issuer_id.required' => 'O ID do emissor é obrigatório.',
            'issuer_id.integer' => 'O ID do emissor deve ser um número inteiro.',
            
            'description.required' => 'A descrição é obrigatória.',
            'description.string' => 'A descrição deve estar em um formato válido.',
            'description.max' => 'A descrição não pode ter mais de :max caracteres.',
            
            'document.required' => 'O documento é obrigatório.',
            'document.integer' => 'O documento deve ser um número inteiro.',
            
            'pdv_id.required' => 'O ID do PDV é obrigatório.',
            'pdv_id.integer' => 'O ID do PDV deve ser um número inteiro.',
            
            'customer_id.required' => 'O ID do cliente é obrigatório.',
            'customer_id.integer' => 'O ID do cliente deve ser um número inteiro.',
            
            'name.required' => 'O nome é obrigatório.',
            'name.string' => 'O nome deve estar em um formato válido.',
            'name.max' => 'O nome não pode ter mais de :max caracteres.',
            
            'especie_id.required' => 'O ID da espécie é obrigatório.',
            'especie_id.integer' => 'O ID da espécie deve ser um número inteiro.',
            
            'especie.required' => 'A espécie é obrigatória.',
            'especie.string' => 'A espécie deve estar em um formato válido.',
            'especie.max' => 'A espécie não pode ter mais de :max caracteres.',
            
            'date_register.required' => 'A data de registro é obrigatória.',
            'date_register.date' => 'A data de registro deve estar em um formato válido.',
            
            'input_value.required' => 'O valor de entrada é obrigatório.',
            'input_value.numeric' => 'O valor de entrada deve ser um número válido.',
            
            'output_value.required' => 'O valor de saída é obrigatório.',
            'output_value.numeric' => 'O valor de saída deve ser um número válido.',
            
            'real_balance.required' => 'O saldo real é obrigatório.',
            'real_balance.numeric' => 'O saldo real deve ser um número válido.',
            
            'origem.string' => 'A origem deve estar em um formato válido.',
            
            'user_id.required' => 'O ID do usuário é obrigatório.',
            'user_id.integer' => 'O ID do usuário deve ser um número inteiro.',
            
            'seller.required' => 'O nome do vendedor é obrigatório.',
            'seller.string' => 'O nome do vendedor deve estar em um formato válido.',
            'seller.max' => 'O nome do vendedor não pode ter mais de :max caracteres.',
            
            'canceled.boolean' => 'O campo "cancelado" deve ser verdadeiro ou falso.',
        ];
    }
}
