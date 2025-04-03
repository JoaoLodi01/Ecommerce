<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ConfigRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
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
        return [
            'addres_by_cep' => ['required'],
            'room_service_limit' => ['required', 'number'],
            'partial_registration' => ['required'],
            
        ];

    }
    public function messages(): array
    {
        return [
            'addres_by_cep.required' => 'Por favor confirme a opção endereço por CEP.',
            'room_service_limit.required' => 'Por favor informe um limite para o serviço de quarto.',
            'room_service_limit.number' => 'Por favor informe um número de limite válido.',
            'partial_registration' => 'Por favor confirme a opção endereço cadastro parcial.',
            
        ];
    }
}
