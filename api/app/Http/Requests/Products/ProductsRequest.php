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
            'issuer_id' => ['required'],
            'product' => [$required, 'string', 'max:120'],
            'image' => ['nullable', 'max:512'],
            'barcode' => [$required, 'string'],
            'barcode_internal' => ['sometimes', 'string'],
            'group_id' => ['nullable', 'integer'],
            'amount' => [$required, 'numeric', 'min:1'],
            'cost_price' => [$required, 'numeric'],
            'sale_price' => [$required, 'numeric'],
            'profit_percentage' => [$required, 'numeric'],
            'cfop' => [$required, 'numeric'],
            'csosncst' => [$required, 'numeric'],
            'ncm' => [$required, 'numeric'],
            'cest' => [$required, 'numeric'],
            'unit' => [$required, 'string'],

            'cod_origem_icms' => [$required],
            'origem_icms' => [$required],
            'icms_ecf' => ['required', 'min:1'],
            'taxable_amount' => ['sometimes'],
            'taxable_unit' => [$required, 'string'],
            'tax_benefit' => ['sometimes', 'string'],
            'cod_ipi' => [$required, 'string'],
            'aliquot_ipi' => [$required],
            'cod_pis' => [$required, 'string'],
            'aliquot_pis' => [$required],
            'cod_cofins' => [$required, 'string'],
            'aliquot_cofins' => [$required],

        ];
    }

    public function messages(): array
    {
        return [
            'issuer_id.required' => 'O emitente é obrigatório',
            'product.required' => 'O nome do produto é obrigatório',
            'barcode.required' => 'O cód de barras é obrigatório',
        ];

    }
}