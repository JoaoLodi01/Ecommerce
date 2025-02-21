<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\CashRegister;

class CashRegisterRepository
{
    public function getAll(int $active){ 
        return CashRegister::where('active', $active)->get();
    }

    public function findByID(string $params){
        return CashRegister::where('id', $params)->first();
    }

    public function store(array $data){
        $cashRegister = CashRegister::create([
            'description' => $data['description'],
            'valor_entrada' => $data['valor_entrada'] ?? null,
            'valor_saida' => $data['valor_saida'] ?? null,
            
        ]);

        $cashRegister->update([
            'saldo_real' => $cashRegister->valor_entrada - $cashRegister->valor_saida

        ]);
        
        return $cashRegister;
        
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
