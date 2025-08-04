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
            'issuerID' => ['required'],
            'especie' => [$required, 'string'],
            'tipoLancamento' => [$required, 'string'],
            'paymentsFormType' => [$required, 'string'],
            'pixKey' => ['sometimes'],
            'bankKey' => ['sometimes'],
            'otherKey' => ['sometimes']

        ];
    }
}