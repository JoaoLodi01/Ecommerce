<?php

namespace App\Http\Requests\PDV;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class PDVSaleRequest extends FormRequest
{

    public function authorize(): bool
    {
        return Auth::check();;
    }

    public function prepareValidation()
    {
        $this->merge([
            'change' => $this->formatValue($this->change),
            'payments_values' => $this->formatValue($this->payments_values)

        ]);
    }

    public function formatValue($value)
    {
        return (float) str_replace(',', '.', $value);
    }


    public function rules(): array
    {
        return [
            'type_operation' => ['required', 'string'],
            'change' => ['required'],
            'payments_values' => ['required'],
            'pdv_id' => ['required']

        ];
    }

    public function messages(): array
    {
        return [
            'type_operation.required' => 'O tipo da operação é obrgitário',
            'type_operation.string' => 'O tipo da operação deve ser um formato válido',

            'change.required' => 'O troco é obrigatório',

            'payments_values.required' => 'O pagamento é obrigatório',

            'pdv_id.required' => 'O identificador do PDV é obrigatório'

        ];
        
    }
}