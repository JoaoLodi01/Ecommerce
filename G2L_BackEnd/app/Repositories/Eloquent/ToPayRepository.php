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
        Log::info('Dados recebidos: ');
        Log::info($toPayRegister);

        $a = 0;

        $user = User::where('user_code', $toPayRegister['user_id'])->first();
        Log::info('Buscando usuário: ' . $user);

        $customer = Customer::where('issuer_id', $toPayRegister['issuer_id'])->first();
        Log::info('Buscando cliente: '. $customer);

        $specie = PaymentForms::where('issuer_id', $toPayRegister['issuer_id'])->where('payment_code', $toPayRegister['especie_id'])->first();
        Log::info('Buscando espécie: '. $specie);

        $nameCustomer = $customer->company_name ? $customer->company_name : $customer->trade_name;
        $toPayRegisterCod = ToPay::where('issuer_id', $toPayRegister['issuer_id'])->max('receive_cod');
        $document = ToPay::where('issuer_id', $toPayRegister['issuer_id'])->max('document');

        while ($toPayRegister['installment_number'] > $a) {
            $toPayRegister['installment_number']--;

            Log::info('INICIOU CREATE RECEBER');
            ToPay::create([
                'receive_cod' => $toPayRegisterCod ? $toPayRegisterCod + 1 : 1,
                'issuer_id' => $toPayRegister['issuer_id'],
                'document' => $toPayRegister['document'] ?? $document ? $document + 1 : 1,
                'description' => $toPayRegister['description'],
                'customer_code' => $customer->customer_code,
                'name' => $nameCustomer,
                'especie_cod' => $specie->payment_code,
                'especie' =>  $specie->especie,
                'due_date' => date('Y-m-d', strtotime(str_replace('/', '-', $toPayRegister['due_date']))),
                'installment_number' => $toPayRegister['installment_number'],
                'installment_value' => $toPayRegister['installment_value'],
                'installment_amount' => $toPayRegisterCod ? $toPayRegisterCod + 1 : 1,
                'type_interest' => $toPayRegister['type_interest'],
                'interest_value' => $toPayRegister['interest_value'],
                'total_amount' => $toPayRegister['total_amount'],
                'origem' => $toPayRegister['origem'],
                'user_id' => $toPayRegister['user_id'],
                'user' => $user->name,
            ]);
            Log::info('TERMINOU CREATE RECEBER');
        }
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