<?php

namespace App\Http\Requests\Financial\Receive;

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
                'userId' => [$required],
                'description' => [$required, 'string', 'max:255'],
                'document' => ['sometimes'],
                'customerId' => [$required],
                'especieId' => [$required],
                'dueDate' => [$required],
                'installmentAmount' => [$required, 'integer'],
                'installmentNumber' => [$required, 'integer'],
                'installmentValue' => [$required, 'numeric'],
                'typeInterest' => [$required],
                'interestValue' => [$required, 'numeric'],
                'addition' => ['sometimes'],
                'discount' => ['sometimes'],
                'valueEntry' => ['sometimes'],
                'valuePaid' => [$required, 'numeric'],
                'origem' => ['nullable'],
                'status' => [$required],
                'installments' => [$required, 'array'],
                'installments.*.installmentNumber' => ['required', 'integer'],
                'installments.*.installmentAmount' => ['required', 'integer'],
                'installments.*.valueOriginal' => ['required', 'numeric'],
                'installments.*.valuePaid' => ['required', 'numeric'],
                'installments.*.dueDate' => ['required', 'date'],
                        
            ];
    }
}