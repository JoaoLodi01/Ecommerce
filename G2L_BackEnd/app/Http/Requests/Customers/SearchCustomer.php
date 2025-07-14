<?php

namespace App\Http\Requests\Customers;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class SearchCustomer extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check();
    }

    public function rules(): array
    {
        return [
            'issuer_id' => ['required'],
            'filter' => ['required'],
            'search' => ['required']
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