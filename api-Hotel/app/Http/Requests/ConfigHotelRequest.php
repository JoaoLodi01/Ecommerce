<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ConfigHotelRequest extends FormRequest
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
            'addres_by_cep' => [$required],
            'room_service_limit' => [$required],
            'partial_registration' => [$required],
            
        ];

    }
    public function messages(): array
    {
        return [
            'addres_by_cep.required' => 'Por favor confirme a opção endereço por CEP.',
            'room_service_limit.required' => 'Por favor informe um limite para o serviço de quarto.',
            'partial_registration' => 'Por favor confirme a opção endereço cadastro parcial.',
            
        ];
    }
}
