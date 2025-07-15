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
    protected function prepareForValidation(): void
    {
        $this->merge([
            'issuer_id' => $this->input('issuerID'),
            'customer_id' => $this->input('customerID'),
            'user_id' => $this->input('userID'),
            'especie_id' => $this->input('especieID'),
            'due_date' => $this->input('dueDate'),
            'installment_amount' => $this->input('installmentAmount'),
            'installment_number' => $this->input('installmentNumber'),
            'installment_value' => $this->input('installmentValue'),
            'installment_original' => $this->input('installmentOriginal'),
            'interest_value' => $this->input('interestValue'),
            'type_interest' => $this->input('typeInterest'),
            'value_entry' => $this->input('valueEntry'),
            'value_paid' => $this->input('valuePaid'),
            'discount' => $this->input('discount'),
            'addition' => $this->input('addition'),
            'origem' => $this->input('origem'),
            'description' => $this->input('description'),
            'document' => $this->input('document'),
        ]);
    }

    public function rules(): array
    {
        return [
            'issuer_id' => ['required', 'integer'],
            'customer_id' => ['required', 'integer'],
            'user_id' => ['required', 'integer'],
            'especie_id' => ['required', 'integer'],
            'due_date' => ['required', 'date'],
            'installment_amount' => ['required', 'integer'],
            'installment_number' => ['required', 'integer'],
            'installment_value' => ['required', 'numeric'],
            'installment_original' => ['required', 'numeric'],
            'interest_value' => ['required', 'numeric'],
            'type_interest' => ['required', 'string'],
            'value_entry' => ['required', 'numeric'],
            'value_paid' => ['required', 'numeric'],
            'discount' => ['required', 'numeric'],
            'addition' => ['required', 'numeric'],
            'origem' => ['nullable', 'string'],
            'description' => ['required', 'string'],
            'document' => ['required', 'string'],
        ];
    }
}