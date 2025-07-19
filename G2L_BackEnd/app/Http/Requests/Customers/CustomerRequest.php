<?php

namespace App\Http\Requests\Customers;

use App\Services\Config\ConfigService;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class CustomerRequest extends FormRequest
{
    public function authorize(): bool
    {
        return Auth::check();
    }

    public function rules(): array
    {
        //'email' => ['required', 'string', 'email', Rule::unique('users')->ignore($user->id)]
        /**
         * @var ConfigService $configService
         * 
         */
        $configService = app(ConfigService::class);
        $issuerID = $this->input('issuer_id'); 
        $configs = $configService->getConfigs($issuerID)['customers'];
        
        Log::debug($configs->validate_cpf ? 'required' : 'nullable');
        Log::debug($configs->validate_cnpj ? 'required' : 'nullable');
        
        $rules = [
            'issuer_id' => ['required'],
            'company_name' => ['nullable', 'required_without:trade_name', 'string', 'max:120'],
            'trade_name' => ['nullable', 'required_without:company_name', 'string', 'max:120'],
            'customer_type' => ['required'],
            'cep' => ['required'],
            'address' => ['required'],
            'number' => ['required'],
            'phone' => ['sometimes', 'max:120'],
            'is_customer' => ['required'],
            'is_driver' => ['required'],
            'is_supplier' => ['required']

        ];

        $rules['cpf'] = $configs->validate_cpf ? 'required' : 'nullable';
        $rules['cnpj'] = $configs->validate_cnpj ? 'required' : 'nullable';

        return $rules;
    }

    public function messages(): array
    {
        return [
            'name.required' => 'O nome é obrigatório',
            'name.string' => 'O nome deve estar em um formato válido',
            'name.max' => 'O nome passou do limite do campo, :max',

            'cpf.required' => 'O CPF é obrigatório',
            
            'cnpj.required' => 'O CNPJ é obrigatório',

            'cep.required' => 'O CEP é obrigatório',
            'address.required' => 'O endereço é obrigatório',
            'number.required' => 'O número do endereço é obrigatório',

            'phone.max' => 'O telefone passou do limite do campo, :max'
        ];
    }
}
