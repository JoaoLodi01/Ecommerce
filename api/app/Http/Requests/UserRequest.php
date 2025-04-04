<?php

namespace App\Http\Requests;

use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UserRequest extends FormRequest
{

    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $required = $this->method('POST') ? 'required' : 'sometimes';
        return [
            'name' => [$required, 'string', 'max:120'],
            'email' => [$required, 'string', 'lowercase', 'email', 'max:120', 'unique:users'],
            'password' => [$required, 'string', 'max:120']
        ];
    }
    public function messages(): array
    {
        return [
            'name.required' => 'O nome é obrigatório!',
            'name.string' => 'O nome precisa ser um texto válido!',
            'name.max' => 'O nome passou do limite de caracteres :max!',

            'email.required' => 'O e-mail é obrigatório!',
            'email.string' => 'O e-mail precisa ser um texto válido!',
            'email.max' => 'O e-mail passou do limite de caracteres :max!',
            'email.lowercase' => 'O e-mail precisa ser em letras minúsculas!',
            'email.email' => 'O e-mail precisa ser válido!',
            'email.unique' => 'Esse e-mail já está sendo usado!',

            'password.required' => 'A senha é obrigatório!',
            'password.string' => 'A senha precisa ser um texto válido!',
            'password.max' => 'A senha passou do limite de caracteres :max!',

        ];
    }

}