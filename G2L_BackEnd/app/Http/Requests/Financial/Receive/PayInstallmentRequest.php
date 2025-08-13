<?php

namespace App\Http\Requests\Financial\Receive;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class PayInstallmentRequest extends FormRequest
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
        return [
            'document' => ['required'],
            'installmentNumber' => ['required'],
            'issuerId' => ['required'],
            'installmentPaid' => ['required'],
            'paymentDate' => ['nullable', 'date'],
            'especieId' => ['required'],
        ];
    }
}