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
            'image' => [$required, 'max:512'],
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

            'origem_icms' => [$required, 'string'],
            'icms_ecf' => ['required'],
            'taxable_amount' => ['sometimes'],
            'taxable_unit' => [$required, 'string'],
            'tax_benefit' => ['sometimes', 'string'],
            'cod_ipi' => [$required, 'string'],
            'aliquot_ipi' => [''],
            'cod_pis' => [$required, 'string'],
            'aliquot_pis' => [],
            'cod_cofins' => [$required, 'string'],
            'aliquot_cofins' => [''],

        ];
    }
}