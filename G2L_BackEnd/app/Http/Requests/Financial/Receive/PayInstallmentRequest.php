<?php

namespace App\Http\Requests\Financial\Receive;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class PayInstallmentsRequest extends FormRequest
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
            'issuerId' => ['required'],
            'status' => ['required', 'string'],
            'installmentPaid' => ['required'],
            'paymentDate' => ['nullable', 'date'],
            'especieId' => ['required', 'number'],
            'customerID' => ['required'],
            'origem' => ['required'],
        ];
    }
}