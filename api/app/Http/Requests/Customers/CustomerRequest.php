<?php

namespace App\Http\Requests\Customers;

use App\Services\Config\ConfigService;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class CustomerRequest extends FormRequest
{
    public function __construct(
        protected ConfigService $configService
    ){ }


    protected function prepareForValidation()
    {
        $this->merge([
            'cutomer_cod' => $this->route('customer_cod')
        ]);
    }

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
        //'email' => ['required', 'string', 'email', Rule::unique('users')->ignore($user->id)]
        return [
            'issuer_id' => ['required'],
            'company_name' => ['nullable', 'required_without:trade_name', 'string', 'max:120'],
            'trade_name' => ['nullable', 'required_without:company_name', 'string', 'max:120'],
            'customer_type' => ['required'],

            'cpf' => [
                function($attribute, $value, $fail)
                {
                    $issuerID = $this->get('issuer_id');
                    if(!$issuerID) 
                    {
                        return $fail('ID do emitente ausente');
                    }

                    $config = $this->configService->getConfigs($issuerID)['customers'];
                    
                    if(!$config->validate_cpf)
                    {
                        return 'nullable';
                    } else {
                        return 'required';
                    }
                }
            ],

            'cnpj' => [
                function($attribute, $value, $fail)
                {
                    $issuerID = $this->get('issuer_id');
                    if($issuerID) 
                    {
                        return $fail('ID do emitente ausente');
                    }
                    /*
                    $issuerID = $this->get['issuer_od'];
                    $config = $this->configService->getConfigs($issuerID)['customers'];
                    
                    if(!$config->validate_cnpj)
                    {
                        return 'nullable';
                    } else {
                        return 'required';
                    }*/
                }
            ],


            'cep' => ['required'],
            'address' => ['required'],
            'number' => ['required'],
            'phone' => ['sometimes', 'max:120'],
            'is_customer' => ['required'],
            'is_driver' => ['required'],
            'is_supplier' => ['required']

        ];
    }

    public function messages(): array
    {
        return [
            'name.required' => 'O nome é obrigatório',
            'name.string' => 'O nome deve estar em um formato válido',
            'name.max' => 'O nome passou do limite do campo, :max',

            'cpf.required' => 'O CPF é obrigatório',
            'cpf.unique' => 'CPF já cadastrado',
            'cnpj.required' => 'O CNPJ é obrigatório',
            'cnpj.unique' => 'CNPJ já cadastrado',

            'cep.required' => 'O CEP é obrigatório',
            'address.required' => 'O endereço é obrigatório',
            'number.required' => 'O número do endereço é obrigatório',

            'phone.required' => 'O telefone é obrigatório',
            'phone.max' => 'O telefone passou do limite do campo, :max'
        ];
    }
}
