<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ReceiveRequest extends FormRequest
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
            'issuerId' => [$required],
            'description' => [$required, 'string', 'max:255'],
            'document' => ['sometimes'],
            'customerId' => [$required],
            'especieId' => [$required],
            'dueDate' => [$required],
            'installmentNumber' => [$required, 'integer'],
            'installmentValue' => [$required, 'numeric'],
            'typeInterest' => [$required],
            'interestValue' => [$required, 'numeric'],
            'totalAmount' => [$required, 'numeric'],
            'origem' => ['nullable'],
            'userId' => [$required],
        ];
    }
}