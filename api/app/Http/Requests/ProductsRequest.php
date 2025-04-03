<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ProductsRequest extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check();
    }

    public function rules(): array 
    {
        $required = $this->isMethod('POST') ? 'required' : 'sometimes';
        return [
            'product' => [$required, 'string', 'max:120'],
            'groupID' => ['nullable', 'integer', 'exists:groups'],
            'amount' => [$required, 'numeric', 'min:1'],
            'costPrice' => [$required, 'numeric'],
            'salePrice' => [$required, 'numeric'],
            'profitPercentage' => [$required, 'numeric'],
            'cfop' => [$required, 'numeric', 'min:4', 'max:4'],
            'csosncst' => [$required, 'numeric', 'min:2', 'max:4'],
            'ncm' => [$required, 'numeric', 'min:8', 'max:8'],
            'cest' => [$required, 'numeric', 'min:7', 'max:7'],
            'unit' => [$required, 'numeric', 'max:4'],
        ];
    }
}