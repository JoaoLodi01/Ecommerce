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
        Log::info($data);
        for ($i=0; $i < count($data); $i++) { 
            CashRegister::create($data[$i]);
            
        }
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
