<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ReceiveRequest extends FormRequest
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
            'description' => [$required, 'string', 'max:255'],
            'customer_id' => [$required],
            'name' => [$required, 'string', 'max:255'],
            'especie_id' => [$required],
            'especie' => [$required, 'string', 'max:255'],
            'date_register' => [$required],
            'due_date' => [$required],
            'installment_number' => [$required, 'integer'],
            'installment_value' => [$required, 'numeric'],
            'type_interest' => [$required],
            'interest_value' => [$required, 'numeric'],
            'total_amount' => [$required, 'numeric'],
            'origem' => ['nullable'],
            'user_id' => [$required, 'integer'],
            'user' => [$required, 'string', 'max:255']

        ];
    }

    public function messages(): array
    {
        return [
            'description.required' => 'A descrição é obrigatória.',
            'description.string' => 'A descrição deve estar em um formato válido.',
            'description.max' => 'A descrição não pode ter mais de :max caracteres.',
            'customer_id.required' => 'O ID do cliente é obrigatório.',
            'name.required' => 'O nome do cliente é obrigatório.',
            'name.string' => 'O nome do cliente deve estar em um formato válido.',
            'name.max' => 'O nome do cliente não pode ter mais de :max caracteres.',
            'especie_id.required' => 'O ID da espécie é obrigatório.',
            'especie.required' => 'A espécie é obrigatória.',
            'especie.string' => 'A espécie deve estar em um formato válido.',
            'especie.max' => 'A espécie não pode ter mais de :max caracteres.',
            'date_register.required' => 'A data de registro é obrigatória.',
            'due_date.required' => 'A data de vencimento é obrigatória.',
            'installment_number.required' => 'O número de parcelas é obrigatório.',
            'installment_number.integer' => 'O número de parcelas deve ser um número inteiro.',
            'installment_value.required' => 'O valor da parcela é obrigatório.',
            'installment_value.numeric' => 'O valor da parcela deve ser um número válido.',
            'type_interest.required' => 'O tipo de juros é obrigatório.',
            'interest_value.required' => 'O valor dos juros é obrigatório.',
            'interest_value.numeric' => 'O valor dos juros deve ser um número válido.',
            'total_amount.required' => 'O valor total é obrigatório.',
            'total_amount.numeric' => 'O valor total deve ser um número válido.',
            'user_id.required' => 'O ID do usuário é obrigatório.',
            'user_id.integer' => 'O ID do usuário deve ser um número inteiro.',
            'user.required' => 'O nome do usuário é obrigatório.',
            'user.string' => 'O nome do usuário deve estar em um formato válido.',
            'user.max' => 'O nome do usuário não pode ter mais de :max caracteres.',
        ];
    }
}