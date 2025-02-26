<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\CashRegister;
use Illuminate\Support\Facades\Log;

class CashRegisterRepository
{
    public function getAll(int $active){ 
        return CashRegister::where('active', $active)->get();
    }

    public function findByID(string $params){
        return CashRegister::where('id', $params)->first();
    }

    public function create(array $cashRegisters){
        Log::info('Vai iniciar criação no caixa, dados:');
        Log::info('Quantia: '. count($cashRegisters));
        Log::info($cashRegisters);

        if(count($cashRegisters) >= 2)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registro: ');
            for ($i=0; $i < count($cashRegisters); $i++)
            { 
                Log::info('Vai chamar o updateCurrentCash($cashRegisters[$i]), dados x: ' . $i);
                Log::info($cashRegisters[$i]);
                CashRegister::create($cashRegisters[$i]);

            }
        } 
        
        if(count($cashRegisters) <= 1)
        {
            Log::info('Vai criar ' . count($cashRegisters) . ' registro: ');
            CashRegister::create($cashRegisters[0]);
        }
        
        $this->updateCurrentCash();

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
                'saldo_real' => $lastCashBox->valor_entrada

            ]);
            return;
        }

        Log::info('$lastCashBoxashBox');
        Log::info($lastCashBox);
        Log::info('$cashBox');
        Log::info($cashBox);

        $lastCashBox->update([
            'saldo_real' => $cashBox->valor_entrada + $lastCashBox->valor_entrada - $lastCashBox->valor_saida
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
