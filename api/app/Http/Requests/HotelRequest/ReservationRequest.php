<?php

namespace App\Http\Requests\HotelRequest;

use Illuminate\Foundation\Http\FormRequest;

use App\Models\Customer;
use Illuminate\Support\Facades\Log;

class ReservationRequest extends FormRequest
{
    public function __construct(
        protected Customer $customer,

    )
    {
        $this->customer = $customer;

    }

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
        Log::info("-- init ReservationRequest --");
        return [
            'customer_id' => ['required', function ($attribute, $value, $fail) {
                
                Log::info("Vai buscar o cliente de ID: $value");
                $customer = $this->customer::where('id', $value)->first();
                Log::info("Cliente: ID: $customer->id, Nome: $customer->name");

                if($customer)
                {
                    Log::info("Vai conferir a relação de reserva x customer, model: Reservation");
                    if($customer->reservation)
                    {
                        Log::info("Tem relação");
                        $fail("Você já possui uma reserva ativa");
                        Log::info("-- close ReservationRequest ( linha 48 ) --");
                        return;

                    }
                    Log::info("Não tem relação");
                    Log::info("-- close ReservationRequest ( linha 54 ) --");    

                }
        Log::info("-- close ReservationRequest ( linha 57 ) --");    

            }]  
            
        ];
    }

    public function messages(): array
    {
        return [
            'customer_id.required' => 'O identificador do usuário é necessário para a operação.'
        ];
    }
}
