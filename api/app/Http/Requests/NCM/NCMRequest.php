<?php

namespace App\Http\Requests\NCM;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class NCMRequest extends FormRequest
{
    public function authorize(): bool
    {
        // Verifica se o usuário está autenticado
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
            'issuer_id' => ['required', 'integer'],
            'search' => ['required', 'string'],
            
        ];
    }
    
}
