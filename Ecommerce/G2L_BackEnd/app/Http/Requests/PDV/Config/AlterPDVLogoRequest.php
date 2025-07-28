<?php

namespace App\Http\Requests\PDV\Config;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class AlterPDVLogoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check();;
    }

    public function rules(): array
    {
        return [
            'importFile' => ['required', 'file', 'max:2048']
            
        ];
    }
}