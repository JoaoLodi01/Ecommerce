<?php

namespace App\Http\Requests;

use App\Repositories\Eloquent\RoomRepository;
use Illuminate\Foundation\Http\FormRequest;

class RoomRequest extends FormRequest
{
    protected $roomRepository;
    public function __construct(RoomRepository $roomRepository)
    {
        $this->roomRepository = $roomRepository;

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
        $required = $this->isMethod('post') ? 'required' : 'sometimes';
        
        return [
            'start_period' => $required,
            'end_period' => $required,
            'room_id'  => [$required, function ($attribute, $value, $fail) {
                $detailRoom = $this->roomRepository->find($value);

                if(
                    $detailRoom->exists() &&
                    $detailRoom->busy == 1 &&
                    $detailRoom->capacity > 0
                    
                )
                {
                    $fail("Esse quarto já estáo ocupado");

                } elseif (
                    $detailRoom->exists() &&
                    $detailRoom->busy == 1 &&
                    $detailRoom->capacity <= 0
                ){
                    $fail("Esse quarto já estáo cheio");

                }
            }],

            'customer_id' => [$required, function ($attribute, $value, $fail) {
                $room = $this->roomRepository->findByCustomerID($value);
                if(
                    $room &&
                    $room->exists() &&
                    $room->active == 1
                    
                )
                {
                    $fail("Esse usuário já está associado ao quarto");

                }
            }],
        ];
    }

    public function messages(): array
    {
        return [
            'customer_id.required' => 'Campo identificador do usuário necessário',
            'room_id.required' => 'Campo identificador do quarto necessário',
            'start_period.required' => 'Não foi definida uma data inicial da pousada',
            'end_period.required' => 'Não foi definida uma data final da pousada',

        ];
    }
}
