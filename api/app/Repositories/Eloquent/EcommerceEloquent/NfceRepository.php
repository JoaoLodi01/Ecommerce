<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Consumer;
use App\Models\EcommerceModels\Customer;
use App\Models\EcommerceModels\Nfce;
use Illuminate\Support\Facades\Log;

class NfceRepository
{
    public function __construct(
        protected ConsumerRepository $consumerRepository,
        protected CashRegisterRepository $cashRegisterRepository,
    )
    {
        $this->consumerRepository = $consumerRepository;
        $this->cashRegisterRepository = $cashRegisterRepository;
    }

    public function getAll(int $active){
        return Nfce::where('active', $active)->get();
    }

    public function findByID(string $params){
        return Nfce::where('id', $params)
                    ->orWhere('products', 'like', '%'. $params . '%')
                    ->get();
    }

    public function store(array $data){
        $consumer = Customer::where('id', $data['id'])-first();
        $user = User
        $payments

        return Nfce::create($data);
    }

    public function update(array $data, int $id){
        return Nfce::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Nfce::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}