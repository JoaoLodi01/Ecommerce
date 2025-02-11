<?php

namespace App\Repositories\Eloquent;

use App\Models\Payment;

class PaymentRepository
{
    public function getAll(int $active){
        return Payment::where('active', $active)->get();
    }

    public function findByID(string $params){
        return Payment::where('id', $params)
                    ->orWhere('products', 'like', '%'. $params . '%')
                    ->get();
    }

    public function store(array $data){
        return Payment::create($data);
    }

    public function update(array $data, int $id){
        return Payment::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Payment::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}