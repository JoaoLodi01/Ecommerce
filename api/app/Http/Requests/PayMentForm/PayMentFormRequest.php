<?php

namespace App\Http\Requests\PayMentForm;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class PayMentFormRequest extends FormRequest
{
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
        $required = $this->isMethod('POST') ? 'required' : 'sometimes';
        return [
            'issuer_id' => ['required'],
            'especie' => [$required, 'string'],
            'tipo_lancamento' => [$required, 'string'],
            'payments_form_type' => [$required, 'string'],
            'pix_key' => ['sometimes'],
            'bank_key' => ['sometimes'],
            'other_key' => ['sometimes'],
        
        ];
    }

}