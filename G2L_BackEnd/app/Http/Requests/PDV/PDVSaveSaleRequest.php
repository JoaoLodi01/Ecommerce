<?php

namespace App\Http\Requests\PDV;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class PDVSaveSaleRequest extends FormRequest
{

    public function authorize(): bool
    {
        return Auth::check();
    }

    public function rules(): array
    {
        return [
            'issuer_id' => ['required'],
            'description' => ['required', 'string' , 'max:120'],
            'products' => ['required', 'array'],
            'user_id' => ['required'], // 'exists:users,id' add depois
            'customer_id' => ['required'], // , 'exists:customer,id' 
            'total' => ['required', 'numeric'],
            'sub_total' => ['required', 'numeric'],
            'addition' => ['required', 'numeric'],
            'discount' => ['required', 'numeric'],
            'is_nfce_nm' => ['sometimes'],
            
        ];
    }

    public function messages(): array
    {
        return [
            'description.required' => 'A descrição da venda é obrigatória',
            'description.string' => 'A descrição da venda deve ser um texto válido',
            'description.max' => 'A descrição da venda passou do seu limite de caracteres',

            'user_id.required' => 'O identificador do vendedor é obrigatório',
            'customer_id.required' => 'O identificador do cliente é obrigatório',

            'products.required' => 'Os produtos da venda são obrigatórios',
            'products.array' => 'Os produtos da venda estão fora do padrão esperado',

            'total.required' => 'O total da venda deve ser informado',
            'total.numeric' => 'O total da venda está fora do padrão esperado',

            'sub_total.required' => 'O subtotal da venda deve ser informado',
            'sub_total.numeric' => 'O subototal da venda está fora do padrão esperado',
            
            'addition.required' => 'O acrésimo da venda deve ser informado', 
            'addition.numeric' => 'O acrésimo da venda está fora do padrão esperado',

            'discount.required' => 'O desconto  da venda deve ser informado',
            'discount.numeric' => 'O desconto da venda está fora do padrão esperado',

        ];
        
    }
}