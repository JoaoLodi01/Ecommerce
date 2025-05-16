<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\Customer;
use App\Models\EcommerceModels\CashRegister;
use App\Models\EcommerceModels\PaymentForms;
use App\Models\Registers\User;
use Illuminate\Support\Facades\Log;
class CashRegisterRepository
{
    public function getAll(int $issuer_id)
    { 
        Log::info('Memória usada CashRegisterRepository::class, getAll: ' . memory_get_usage(true));
        return CashRegister::where('issuer_id', $issuer_id)->get();
        
    }

    public function findByID(string $params)
    {
        Log::info('Memória usada CashRegisterRepository::class, findByID: ' . memory_get_usage(true));
        return CashRegister::where('id', $params)->first();
    }

    public function create(array $cashRegisters)
    {
        Log::info('INICIOU REGISTRO NO CAIXA');
        Log::info($cashRegisters);
        Log::info('Buscando emitente: '. $cashRegisters[0]['issuer_id']);

        $user = User::where('user_cod', $cashRegisters[0]['user_id'])->first();
        Log::info('Buscando usuário: '. $user);

        $customer = Customer::where('issuer_id', $cashRegisters[0]['issuer_id'])->first();
        Log::info('Buscando cliente: '. $customer);
        
        $specie = PaymentForms::where('issuer_id', $cashRegisters[0]['issuer_id'])->where('payment_cod', $cashRegisters[0]['especie_cod'])->first();
        Log::info('Buscando espécie: '. $specie);

        $nameCustomer = $customer->company_name ? $customer->company_name : $customer->trade_name;
        $cashRegisterCod = CashRegister::where('issuer_id', $cashRegisters[0]['issuer_id'])->max('cash_register_cod');
        $document = CashRegister::where('issuer_id', $cashRegisters[0]['issuer_id'])->max('document');

        if(count($cashRegisters) >= 2)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registros: ');
            for ($i=0; $i < count($cashRegisters); $i++)
            { 
                Log::info('Memória usada CashRegisterRepository::class, create, dentro for: ' . memory_get_usage(true));
                Log::info('Vai chamar o updateCurrentCash($cashRegisters[$i]), dados x: ' . $i);
                Log::info($cashRegisters[$i]);
                CashRegister::create([
                    'cash_register_cod' => $cashRegisterCod ? $cashRegisterCod + 1 : 1,
                    'issuer_id' => $cashRegisters[$i]['issuer_id'],
                    'description'  => $cashRegisters[$i]['description'],
                    'document' => $cashRegisters[$i]['document'] ?? $document ?  $document + 1 : 1,
                    'pdv_cod' => $cashRegisters[$i]['pdv_cod'],
                    'customer_cod' => $cashRegisters[$i]['customer_cod'],
                    'name' => $cashRegisters[$i]['name'] ?? $nameCustomer,
                    'especie_cod' => $cashRegisters[$i]['especie_cod'] ?? $specie->payment_cod,
                    'especie' => $cashRegisters[$i]['especie'] ?? $specie->especie,
                    'date_register' => $cashRegisters[$i]['date_register'],
                    'input_value' => $cashRegisters[$i]['input_value'],
                    'output_value' => $cashRegisters[$i]['output_value'],
                    'origem' => $cashRegisters[$i]['origem'],
                    'user_id' => $cashRegisters[$i]['user_id'],
                    'seller' => $cashRegisters[$i]['seller'] ?? $user->name,
                    
                ]);

                $this->updateCurrentCash($cashRegisters['issuer_id']);
            }
        } 
        
        if(count($cashRegisters) <= 1)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registro: ');
            CashRegister::create([
                    'cash_register_cod' => $cashRegisterCod ? $cashRegisterCod + 1 : 1,
                    'issuer_id' => $cashRegisters[0]['issuer_id'],
                    'description'  => $cashRegisters[0]['description'],
                    'document' => $cashRegisters[0]['document'] ?? $document ?  $document + 1 : 1,
                    'pdv_cod' => $cashRegisters[0]['pdv_cod'] ?? null,
                    'customer_cod' => $cashRegisters[0]['customer_cod'],
                    'name' => $cashRegisters[0]['name'] ?? $nameCustomer,
                    'especie_cod' => $cashRegisters[0]['especie_cod'] ?? $specie->payment_cod,
                    'especie' => $cashRegisters[0]['especie'] ?? $specie->especie,
                    'date_register' => $cashRegisters[0]['date_register'],
                    'input_value' => $cashRegisters[0]['input_value'],
                    'output_value' => $cashRegisters[0]['output_value'],
                    'origem' => $cashRegisters[0]['origem'],
                    'user_id' => $cashRegisters[0]['user_id'],
                    'seller' => $cashRegisters[0]['seller'] ?? $user->name,
                ]);
                
            $this->updateCurrentCash($cashRegisters[0]['issuer_id']);

        }
        
    }

    public function updateCurrentCash(int $issuer_id)
    {   
        Log::info('$issuer_id: ' . $issuer_id);
        $lastCashBox = CashRegister::where('canceled', 0)->where('issuer_id', $issuer_id)->latest('cash_register_cod')->first();
        Log::info('$lastCashBox com issuer_id ' . $lastCashBox);

        $actualCashBox = CashRegister::where('canceled', 0)->where('issuer_id', $issuer_id)->where('cash_register_cod', $lastCashBox->cash_register_cod - 1)->first();
        Log::info('$actualCashBox com issuer_id ' . $actualCashBox);
        
        if(!$actualCashBox)
        {
            Log::info('Não foi encontrado um registro anterior do segundo registro no caixa');
            if($lastCashBox->input_value > 0)
            {
                Log::info('Foi informado um valor de entrada');
                Log::info('real_balance: R$ ' . $lastCashBox->input_value);
                $lastCashBox->update([
                    'real_balance' => $lastCashBox->input_value

                ]);
            }

            if($lastCashBox->output_value > 0)
            {
                Log::info('Foi informado um valor de saída');
                Log::info('real_balance: R$ ' . $lastCashBox->output_value - ($lastCashBox->output_value * 2));
                $lastCashBox->update([
                    'real_balance' => $lastCashBox->output_value - ($lastCashBox->output_value * 2)

                ]);

            }
            
            
            Log::info('$lastCashBoxashBox 2');
            Log::info($lastCashBox);

            Log::info('$actualCashBox 2');
            Log::info($actualCashBox);
            Log::info('Vai retornar');
            return;
            
        } else {
            Log::info('Foi encontrado mais um registro');
            Log::info('Novo valor: R$ ' . $actualCashBox->input_value . ' + '  . $lastCashBox->input_value . ' - ' . $lastCashBox->output_value . ' = ' . $actualCashBox->input_value + $lastCashBox->input_value);
            $lastCashBox->update([
                'real_balance' => $actualCashBox->real_balance + $lastCashBox->input_value - $lastCashBox->output_value
            ]);
        }
        
    }

    public function update(array $cashRegisters, int $id){
        return CashRegister::where('id', $id)->update($cashRegisters);
    }

    public function delete(int $id){
        return CashRegister::where('id', $id)->update([
            'active' => 0,
        ]);

        
    }    
}