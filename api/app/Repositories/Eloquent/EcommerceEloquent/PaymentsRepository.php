<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Payment;
use Illuminate\Support\Facades\Log;

class PaymentsRepository
{
    public function getAll(int $active){
        return Payment::where('active', $active)->get();
    }

    public function findByID(array $data){
        $result = [];
        foreach ($data as $i) {
            $result[] = Payment::where('id', $i)->first();
            
        }
        return $result;
        
    }

    public function store(array $data){
        return Payment::create($data);

    }

    public function update(array $data, int $id){
        return Payment::where('id', $id)->update($data);
    }

    public function delete(int $id){
        return Payment::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}