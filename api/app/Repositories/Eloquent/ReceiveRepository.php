<?php

namespace App\Repositories\Eloquent;

use App\Models\EcommerceModels\Receive;
use Illuminate\Support\Facades\Log;

class ReceiveRepository
{
    public function getAll(int $issuer_id){
        return Receive::where('issuer_id', $issuer_id)->get();
    }

    public function findByID(int $id){
        return Receive::where('id', $id)->first();
    }

    public function create(array $receiveRegister)
    {
     Log::info('Dados recebidos: ');
     Log::info($receiveRegister);  
    }

    public function update (array $receiveRegister, int $id){
        return Receive::where('id', $id)->update($receiveRegister);
    }

    public function delete (int $id){
        return Receive::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}