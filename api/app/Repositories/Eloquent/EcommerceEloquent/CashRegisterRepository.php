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
        Log::info('Quantia de dados: ' . count($data));

        for($i=0; $i < count($data); $i++)
        {            
            Log::info('Dados linha 24');
            Log::info($data[$i]);
            $cashBox = CashRegister::create($data[$i]);
            Log::info('cashBox');
            Log::info($cashBox);
            Log::info('O valor total vai ser alterado');
            $this->updateCurrentAmount($cashBox, $cashBox->id);

        }
        
    }
    
    public function updateCurrentAmount(object $cashBox, int $id){
        Log::info('cashBox: ' . $cashBox . 'ID: ' . $id);
        return CashRegister::where('id', $id)->update([
            'saldo_real' => $cashBox->valo_entrada - $cashBox->valor_saida,

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
