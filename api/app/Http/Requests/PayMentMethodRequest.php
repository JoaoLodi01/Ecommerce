<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PayMentMethodRequest extends FormRequest
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
            'payment_method' => [$required, 'string', 'max:100'],
            'amount_paid' => [$required, 'number'],
            'customer_id' => [$required],
            'payment_period' => [$required]

        ];
    }

    public function messages(): array
    {
        return [
            'payment_method.required' => 'A forma de pagamento deve ser informada!',
            'payment_method.string' => 'A forma de pagamento deve ser um texto válido!',
            'payment_method.max' => 'A forma de pagamento deve contar no máximo 100 caracteres!',

            'amount_paid.required' => 'O valor deve ser informado!',
            'amount_paid.number' => 'O valor pego deve ser um número!',

            'customer_id.required' => 'O identificador do usuário deve ser informado!',
            'payment_period' => 'A data da transação deve ser informada!'
        ];
    }
}
