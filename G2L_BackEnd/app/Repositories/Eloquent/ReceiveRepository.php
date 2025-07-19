<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use App\Models\EcommerceModels\PaymentForms;
use App\Models\EcommerceModels\Receive;
use App\Models\Registers\User;
use Illuminate\Support\Facades\Log;

class ReceiveRepository
{
    public function getAll(int $issuer_id){
        return Receive::where('issuer_id', $issuer_id)->where('installment_number', 1)->get();
    }

    public function findByID(int $id){
        return Receive::where('id', $id)->first();
    }

    public function create(array $receiveRegister)
    {
        Log::info('Dados recebidos: ');
        Log::info($receiveRegister);

        $a = 0;

        $user = User::where('user_code', $receiveRegister['user_id'])->first();
        Log::info('Buscando usuário: ' . $user);

        $customer = Customer::where('issuer_id', $receiveRegister['issuerID'])->first();
        Log::info('Buscando cliente: '. $customer);

        $specie = PaymentForms::where('issuer_id', $receiveRegister['issuer_id'])->where('payment_code', $receiveRegister['especie_id'])->first();
        Log::info('Buscando espécie: '. $specie);

        $nameCustomer = $customer->company_name ? $customer->company_name : $customer->trade_name;
        $receiveRegisterCod = Receive::where('issuer_id', $receiveRegister['issuerID'])->max('receive_cod');
        $document = Receive::where('issuer_id', $receiveRegister['issuerID'])->max('document');

        while ($receiveRegister['installment_number'] > $a) {
            $receiveRegister['installment_number']--;

            Log::info('INICIOU CREATE RECEBER');
            Receive::create([
                'receive_cod' => $receiveRegisterCod ? $receiveRegisterCod + 1 : 1,
                'issuer_id' => $receiveRegister['issuerID'],
                'document' => $receiveRegister['document'] ?? $document ? $document + 1 : 1,
                'description' => $receiveRegister['description'],
                'customer_code' => $customer->customer_code,
                'name' => $nameCustomer,
                'especie_cod' => $specie->payment_code,
                'especie' =>  $specie->especie,
                'due_date' => date('Y-m-d', strtotime(str_replace('/', '-', $receiveRegister['dueDate']))),
                'installment_amount' => $receiveRegisterCod ? $receiveRegisterCod + 1 : 1,
                'installment_number' => $receiveRegister['installmentNumber'],
                'installment_value' => $receiveRegister['installmentValue'],
                'installment_paid' => $receiveRegister[''],
                'type_interest' => $receiveRegister['typeInterest'],
                'interest_value' => $receiveRegister['interestValue'],
                'origem' => $receiveRegister['origem'],
                'user_id' => $receiveRegister['userID'],
                'user' => $user->name,
            ]);
            Log::info('TERMINOU CREATE RECEBER');
        }
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