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
        $customerType = $this->input('customer_type');

        $post = $this->isMethod('POST');
                
        $rules = [
            'issuer_id' => ['required'],
            'company_name' => ['nullable', 'string', 'max:120'],
            'customer_type' => ['required'],
            'cep' => ['required'],
            'uf' => ['required'],
            'ie' => ['sometimes'],
            'im' => ['sometimes'],
            'address' => ['required'],
            'number' => ['required'],
            'is_customer' => ['required'],
            'is_driver' => ['required'],
            'is_supplier' => ['required']

        ];

        $rules['cpf'] = $customerType === 'Física' ? ($configs->validate_cpf ? 'nullable' : 'required') : 'nullable';
        $rules['cnpj'] = $customerType === 'Jurídica' ? ($configs->validate_cnpj ? 'nullable' : 'required') : 'nullable';

        $rules['trade_name'] = $customerType === 'Física' ? ($configs->validate_trade_name ? 'nullable' : ['required', 'max:120', 'string']) : 'nullable';
        $rules['phone'] = $configs->validate_phone ? 'nullable' : ['required'];
        $rules['cpf'] = $customerType === 'Física' && $post ? ($configs->validate_cpf ? 'nullable' : 'required') : 'nullable';
        $rules['cnpj'] = $customerType === 'Jurídica' && $post  ? ($configs->validate_cnpj ? 'nullable' : 'required') : 'nullable';
        
        return $rules;
    }

    public function messages(): array
    {
        return [
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
