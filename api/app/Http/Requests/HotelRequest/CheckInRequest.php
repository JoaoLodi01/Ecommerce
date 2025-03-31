<?php

namespace App\Http\Requests\HotelRequest;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class CheckInRequest extends FormRequest
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
            'customer_id' => 'required',
            'room_id' => 'required',
            'end_period' => 'required|date',

        ];
    }

    public function messages(): array
    {
        return [
            'customer_id.required' => 'O identficador do usuário é necessário',
            'room_id.required' => 'O identficador do quarto é necessário',
            'end_period.required' => 'A data de fim da estadia é necessária',
            'end_period.date' => 'É necessário informar uma data para esse campo',

        ];
    }
}
