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
            'groupID' => ['nullable', 'integer'],
            'amount' => [$required, 'numeric', 'min:1'],
            'costPrice' => [$required, 'numeric'],
            'salePrice' => [$required, 'numeric'],
            'profitPercentage' => [$required, 'numeric'],
            'cfop' => [$required, 'numeric'],
            'csosncst' => [$required, 'numeric'],
            'ncm' => [$required, 'numeric'],
            'cest' => [$required, 'numeric'],
            'unit' => [$required, 'string'],
        ];
    }
}