<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class NfceRequest extends FormRequest
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
            'preco_bruto' => "$required|numeric|min:0",
            'preco_liquido' => "$required|numeric|min:0",
            'preco_desconto' => "nullable|numeric|min:0",
            'forma_pagamento' => "$required|string",
        ];
    }
}
