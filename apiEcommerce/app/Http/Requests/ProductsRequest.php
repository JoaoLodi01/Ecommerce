<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductsRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $required = $this->isMethod('post') ? 'required' : 'sometimes';

        return [
            'produto'=> "$required|string|max:255",
            'quantidade' => "$required|integer|min:0",
            'preco_custo' => "$required|numeric|min:0",
            'preco_venda' => "$required|numeric|min:0",
            'NCM' => 'nullable|string|max:20',
            'CEST' => 'nullable|string|max:20',
            'CSOSN' => 'nullable|string|max:3',
            'CFOP' => 'nullable|string|max:4',
        ];
    }

    public function messages(): array
    {
        return [
            'produto.required' => 'O campo produto é obrigatório.',
            'produto.string' => 'O campo produto deve ser um texto.',
            'quantidade.required' => 'O campo quantidade é obrigatório.',
            'quantidade.integer' => 'O campo quantidade deve ser um número inteiro.',
            'preco_custo.required' => 'O campo preço de custo é obrigatório.',
            'preco_custo.numeric' => 'O campo preço de custo deve ser um número.',
            'preco_venda.required' => 'O campo preço de venda é obrigatório.',
            'preco_venda.numeric' => 'O campo preço de venda deve ser um número.',
        ];
    }
}
