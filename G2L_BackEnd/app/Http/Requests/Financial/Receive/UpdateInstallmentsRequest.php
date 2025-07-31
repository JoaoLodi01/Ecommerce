<?php

namespace App\Http\Requests\Financial\Receive;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class UpdateInstallmentsRequest extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check(); // ou true se for API pública autenticada de outra forma
    }

    public function rules(): array
    {
        return [
            'status' => ['required', 'string'],
            'installmentPaid' => ['required'],
            'paid' => ['required', 'boolean'],
            'paymentDate' => ['nullable', 'date'],
        ];
    }
}