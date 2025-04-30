<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\{
    CashRegister,
    Receive
};

use Illuminate\Support\Facades\Log;

class CashRegisterRepository
{
    public function getAll(){ 
        Log::info('Memória usada CashRegisterRepository::class, getAll: ' . memory_get_usage(true));
        return CashRegister::paginate(20);
        
    }

    public function findByID(string $params){
        Log::info('Memória usada CashRegisterRepository::class, findByID: ' . memory_get_usage(true));
        return CashRegister::where('id', $params)->first();
    }

    public function create(array $cashRegisters){
        Log::info('-- Vai iniciar criação no CAIXA, dados: --');
        Log::info('Memória usada CashRegisterRepository::class, create: ' . memory_get_usage(true));

        if(count($cashRegisters) >= 2)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registros: ');
            for ($i=0; $i < count($cashRegisters); $i++)
            { 
                Log::info('Memória usada CashRegisterRepository::class, create, dentro for: ' . memory_get_usage(true));
                Log::info('Vai chamar o updateCurrentCash($cashRegisters[$i]), dados x: ' . $i);
                Log::info($cashRegisters[$i]);
                CashRegister::create($cashRegisters[$i]);
                $this->updateCurrentCash($cashRegisters['issuer_id']);
            }
        } 
        
        if(count($cashRegisters) <= 1)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registro: ');
            CashRegister::create($cashRegisters[0]);
            $this->updateCurrentCash($cashRegisters['issuer_id']);

        }
        
    }

    public function updateCurrentCash(int $issuer_id)
    {   
    Log::info('Memória usada CashRegisterRepository::class, updateCurrentCash: ' . memory_get_usage(true));
        $lastCashBox = CashRegister::where('canceled', 0)->where('issuer_id', $issuer_id)->latest('id')->first();
        $actualCashBox = CashRegister::where('id', $lastCashBox->id - 1)->where('issuer_id', $issuer_id)->first();
        
        if(!$actualCashBox)
        {
            Log::info('Não foi encontrado um registro anterior do segundo registro no caixa');
            $lastCashBox->update([
                'real_balance' => $lastCashBox->input_value

            ]);
            
            Log::info('$lastCashBoxashBox 2');
            Log::info($lastCashBox);

            Log::info('$actualCashBox 2');
            Log::info($actualCashBox);
            Log::info('Vai retornar');
            return;
        }

        Log::info('Novo valor: R$ ' . $actualCashBox->input_value . ' + '  . $lastCashBox->input_value . ' = ' . $actualCashBox->input_value + $lastCashBox->input_value);
        $lastCashBox->update([
            'real_balance' => $actualCashBox->real_balance + $lastCashBox->input_value - $lastCashBox->outputvalue
        ]);
        
    }

    public function update(array $cashRegisters, int $id){
        Log::info('Memória usada CashRegisterRepository::class, update: ' . memory_get_usage(true));
        return CashRegister::where('id', $id)->update($cashRegisters);
    }

    public function delete(int $id){
        Log::info('Memória usada CashRegisterRepository::class, delete: ' . memory_get_usage(true));
        return CashRegister::where('id', $id)->update([
            'active' => 0,
        ]);
    }    
}