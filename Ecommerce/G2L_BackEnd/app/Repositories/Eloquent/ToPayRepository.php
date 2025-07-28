<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use App\Models\EcommerceModels\PaymentForms;
use App\Models\EcommerceModels\ToPay;
use App\Models\Registers\User;
use Illuminate\Support\Facades\Log;

class ToPayRepository
{
    public function getAll(int $issuer_id){
        return ToPay::where('issuer_id', $issuer_id)->get();
    }

    public function findByID(int $id){
        return ToPay::where('id', $id)->first();
    }

    public function create(array $toPayRegister)
    {
        Log::info('INICIOU REGISTRO NO PAGAR');

        //$document = ToPay
    }

    public function update (array $toPayRegister, int $id){
        return ToPay::where('id', $id)->update($toPayRegister);
    }

    public function delete (int $id){
        return ToPay::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}