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
<<<<<<< HEAD
            'groupID' => ['nullable', 'integer', 'exists:groups'],
=======
            'groupID' => ['nullable', 'integer'],
>>>>>>> 7379b8a8295023b2ae5f593467c261a05f769442
            'amount' => [$required, 'numeric', 'min:1'],
            'costPrice' => [$required, 'numeric'],
            'salePrice' => [$required, 'numeric'],
            'profitPercentage' => [$required, 'numeric'],
<<<<<<< HEAD
            'cfop' => [$required, 'numeric', 'min:4', 'max:4'],
            'csosncst' => [$required, 'numeric', 'min:2', 'max:4'],
            'ncm' => [$required, 'numeric', 'min:8', 'max:8'],
            'cest' => [$required, 'numeric', 'min:7', 'max:7'],
            'unit' => [$required, 'numeric', 'max:4'],
=======
            'cfop' => [$required, 'numeric'],
            'csosncst' => [$required, 'numeric'],
            'ncm' => [$required, 'numeric'],
            'cest' => [$required, 'numeric'],
            'unit' => [$required, 'string'],
>>>>>>> 7379b8a8295023b2ae5f593467c261a05f769442
        ];
    }
}