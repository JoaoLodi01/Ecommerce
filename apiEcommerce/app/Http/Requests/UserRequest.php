<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UserRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
<<<<<<< HEAD
        return false;
=======
        return true;
>>>>>>> 96658b47bb8627f52fbbf805dfd9c6069f9312d0
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
<<<<<<< HEAD
        return [
            //
=======
        $required = $this->isMethod('post') ? 'required' : 'sometimes';

        return [
            'name' => "$required|string|max:255",
            'email' => "$required|email|max:255|unique:users,email",
            'password' => "$required|min:0",
>>>>>>> 96658b47bb8627f52fbbf805dfd9c6069f9312d0
        ];
    }
}
