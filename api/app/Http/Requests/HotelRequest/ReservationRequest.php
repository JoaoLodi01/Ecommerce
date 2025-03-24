<?php

namespace App\Http\Requests\HotelRequest;

use Illuminate\Foundation\Http\FormRequest;

class ReservationRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'customer_id' => ['required'],
            'room_id' => ['required'],
            'payments_values' => ['required'],
            'generate_credit' => ['sometimes'],
        ];

    }

    public function messages(): array
    {
        return [
            'customer_id.required' => 'O identificador do cliente é obrigatório',
            'room_id.required' => 'O identificador do quarto é obrigatório',
            'payments_values.required' => 'O pagamento é obrigatório',

            
        ];
        
    }
}