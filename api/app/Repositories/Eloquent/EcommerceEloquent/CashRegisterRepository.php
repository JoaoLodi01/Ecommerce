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
        Log::info('Vai iniciar criação no caixa conferindo se tem mais de uma espécie ou não');
        Log::info('Dados');
        Log::info($data);
        if(count($data) >= 2)
        {
            Log::info('Teve mais de uma linha 23 CashRegisterRepository');
            for ($i=0; $i < count($data); $i++) { 
                Log::info('Dados: ');
                Log::info($data[$i]);

                Log::info('contador ' . $i + 1);
                Log::info('Dados para criação', $data[$i]);

                CashRegister::create($data[$i]);

                
                Log::info('Fim linha 33 CashRegisterRepository');
                return;
            }

        }

        Log::info('Não teve mais de uma');
        Log::info($data);
        return CashRegister::create($data);
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
