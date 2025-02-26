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

    public function create(array $data){
        Log::info('Vai iniciar criação no caixa, dados:');
        Log::info('Quantia: '. count($data));
        Log::info($data);

        if(count($data) > 2)
        {
            for ($i=0; $i < count($data); $i++) { 
                CashRegister::create($data[$i]);
                Log::info('Vai chamar o updateCurrentCash($data[$i]), dados: ');
                Log::info($data[$i]);
                
            }
        }
        CashRegister::create($data);
        $this->updateCurrentCash();
    }

    public function updateCurrentCash()
    {
        $lastCashBox = CashRegister::where('canceled', 0)->latest('id')->first();
        $cashBox = $lastCashBox->where('id', $lastCashBox->id - 1)->first();
        Log::info('$lastCashBoxashBox');
        Log::info($lastCashBox);
        Log::info('$cashBox');
        Log::info($cashBox);


        $lastCashBox->update([
            'saldo_real' => $cashBox->valor_entrada + $lastCashBox->valor_entrada - $lastCashBox->valor_saida
        ]);
    }

    public function update(array $data, int $id){
        return CashRegister::where('id', $id)->update($data);
    }

    public function delete(int $id){
        return CashRegister::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}
