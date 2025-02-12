<?php

namespace App\Repositories\Eloquent;

use App\Models\CashRegister;
use App\Repositories\Contracts\Base;

class CashRegisterRepository extends BaseRepository implements Base
{
    public function getAll(int $active){ 
        return CashRegister::where('active', $active)->get();
    }

    public function findByID(string $params){
        return CashRegister::where('id', $params)->first();
    }

    public function store(array $data){
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