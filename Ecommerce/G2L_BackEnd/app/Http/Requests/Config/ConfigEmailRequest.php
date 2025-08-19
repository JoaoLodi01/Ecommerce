<?php

namespace App\Http\Requests\Config;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ConfigEmailRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return Auth::check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {   
        return [
            'host' => ['required', 'string', 'max:14'],
            'port' => ['required', 'string', 'max:5'],
            'userName' => ['required', 'string', 'max:80'],
            'password' => ['required', 'string', 'max:80'],
            'useTLS' => ['required', 'string', 'max:3'],
            'useSSL' => ['required', 'string', 'max:3']
        ];
    }
}
