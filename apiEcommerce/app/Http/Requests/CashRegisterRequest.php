<?php

namespace App\Http\Requests;

<<<<<<< HEAD
use Illuminate\Foundation\Http\FormRequest;
=======
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
>>>>>>> 96658b47bb8627f52fbbf805dfd9c6069f9312d0

class CashRegisterRequest extends FormRequest
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
=======
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
>>>>>>> 96658b47bb8627f52fbbf805dfd9c6069f9312d0
        ];
    }
}
