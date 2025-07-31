<?php

namespace App\Http\Requests\Products;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class SearchProducts extends FormRequest
{   
    public function authorize(): bool
    {
        return Auth::check();
    }

    public function rules(): array
    {
        return [
            'filter' => ['required'],
            'search' => ['required'],
            'issuer_id' => ['required']
        ];
    }

    public function messages(): array
    {
        return [
            'filter.required' => 'O filtro da busca é necessário.',
            'search.required' => 'O parametro para a busca é necessário.'
        ];
    }
}