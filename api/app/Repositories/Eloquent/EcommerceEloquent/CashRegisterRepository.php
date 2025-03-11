<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\CashRegister;
use Illuminate\Support\Facades\Log;

class CashRegisterRepository
{
    public function getAll(int $active){ 
        return CashRegister::all();
        
    }

    public function findByID(string $params){
        return CashRegister::where('id', $params)->first();
    }

    public function create(array $cashRegisters){
        Log::info('Vai iniciar criação no CAIXA, dados:');
        Log::info('Quantia: '. count($cashRegisters));
        Log::info('Tipo de dado: ' . gettype($cashRegisters));
        Log::info($cashRegisters);

        if(count($cashRegisters) >= 2)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registro: ');
            for ($i=0; $i < count($cashRegisters); $i++)
            { 
                Log::info('Vai chamar o updateCurrentCash($cashRegisters[$i]), dados x: ' . $i);
                Log::info($cashRegisters[$i]);
                CashRegister::create($cashRegisters[$i]);
                $this->updateCurrentCash();
            }
        } 
        
        if(count($cashRegisters) <= 1)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registro: ');
            CashRegister::create($cashRegisters[0]);
            $this->updateCurrentCash();

        }
        return;
    }

    public function updateCurrentCash()
    {   
        $lastCashBox = CashRegister::where('canceled', 0)->latest('id')->first();
        $cashBox = CashRegister::where('id', $lastCashBox->id - 1)->first();
        
        if(!$cashBox)
        {
            Log::info('Não foi encontrado um registro anterior do segundo registro no caixa');
            $lastCashBox->update([
                'saldo_real' => $lastCashBox->input_value

            ]);
            return;
        }

        Log::info('$lastCashBoxashBox');
        Log::info($lastCashBox);

        Log::info('$cashBox');
        Log::info($cashBox);

        Log::info('Novo valor: R$ ' . $cashBox->input_value . ' + '  . $lastCashBox->input_value . ' = ' . $cashBox->input_value + $lastCashBox->input_value);
        $lastCashBox->update([
            'real_balance' => $cashBox->real_balance + $lastCashBox->input_value - $lastCashBox->outputvalue
        ]);
        
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
