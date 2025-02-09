<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class CashRegisterRequest extends FormRequest
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
            'description' => "$required|string|max:255",
            'valor_entrada' => "nullable|numeric|min:0|required_without:valor_saida",
            'valor_saida' => "nullable|numeric|min:0|required_without:valor_entrada",
            'saldo_real' => "nullable|numeric|min:0",
        ];
    }

    public function messages(): array{

        return[
            'description.required' => 'A descrição é obrigatória.',
            'valor_entrada.required' => 'Valor de entrada é requerido quando não tiver valor de saída',
            'valor_saida.required' => 'Valor de saída é requerido quando não tiver valor de entrada',
        ];
    }
}
