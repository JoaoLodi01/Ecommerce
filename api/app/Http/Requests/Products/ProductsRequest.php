<?php

namespace App\Http\Requests\Products;

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
            'issuerId' => ['required'],
            'product' => [$required, 'string', 'max:120'],
            'image' => ['nullable', 'max:512'],
            'barcode' => [$required, 'string'],
            'barcodeInternal' => ['sometimes', 'string'],
            'groupId' => ['nullable', 'integer'],
            'amount' => [$required, 'numeric', 'min:1'],
            'costPrice' => [$required, 'numeric'],
            'profitPercentage' => [$required, 'numeric'],
            'salePrice' => [$required, 'numeric'],
            'cfop' => [$required, 'numeric'],
            'csosncst' => [$required, 'numeric'],
            'ncm' => [$required, 'numeric'],
            'cest' => ['sometimes', 'numeric'],
            'unit' => [$required, 'string'],

            'codOrigemIcms' => [$required],
            'origemIcms' => [$required],
            'icmsEcf' => ['required', 'min:1'],
            'taxableAmount' => ['sometimes'],
            'taxableUnit' => [$required, 'string'],
            'taxBenefit' => ['sometimes', 'string'],
            'codIpi' => [$required, 'string'],
            'aliquotIpi' => [$required],
            'codPis' => [$required, 'string'],
            'aliquotPis' => [$required],
            'codCofins' => [$required, 'string'],
            'aliquotCofins' => [$required],

        ];
    }

    public function messages(): array
    {
        return [
            'issuerId.required' => 'O emitente é obrigatório',
            'product.required' => 'O nome do produto é obrigatório',
            'barcode.required' => 'O cód de barras é obrigatório',
        ];

    }
}