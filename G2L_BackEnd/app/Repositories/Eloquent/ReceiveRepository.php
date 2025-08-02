<?php

namespace App\Repositories\Eloquent;

use App\Models\Customer;
use App\Models\EcommerceModels\PaymentForms;
use App\Models\EcommerceModels\Receive;
use App\Models\EcommerceModels\CashRegister;
use App\Models\Registers\User;
use Illuminate\Support\Facades\Log;

class ReceiveRepository
{
    public function getOne(int $document){
        return Receive::where('document', $document)->get();
    }

    public function getAll(int $issuer_id){
        return Receive::where('issuer_id', $issuer_id)->where('installment_number', 1)->get();
    }

    public function findByID(int $id){
        return Receive::where('id', $id)->first();
    }

    public function create(array $receiveRegister)
    {
        Log::info('Dados recebidos: ', $receiveRegister);

        $user = User::where('user_code', $receiveRegister['userId'])->first();
        Log::info('Buscando usuário: ', ['user' => $user]);

        $customer = Customer::where('issuer_id', $receiveRegister['issuerId'])->first();
        Log::info('Buscando cliente: ', ['cliente' => $customer]);

        $specie = PaymentForms::where('issuer_id', $receiveRegister['issuerId'])
                            ->where('payment_code', $receiveRegister['especieId'])
                            ->first();
        Log::info('Buscando espécie: ', ['especie' => $specie]);

        if (!$user || !$customer || !$specie) {
            Log::error('Dados inválidos no registro de recebimento.');
            throw new \Exception('Usuário, cliente ou espécie inválidos.');
        }

        $nameCustomer = $customer->company_name ?: $customer->trade_name;
        $document = Receive::where('issuer_id', $receiveRegister['issuerId'])->max('document');
        $nextDocument = $document ? $document + 1 : 1;

        $lastReceiveCode = Receive::where('issuer_id', $receiveRegister['issuerId'])->max('receive_code');
        $nextReceiveCode = $lastReceiveCode ? $lastReceiveCode + 1 : 1;

        if (!isset($receiveRegister['installments']) || !is_array($receiveRegister['installments'])){
            Log::info('Instalments Debug:', [
                'isset' => isset($receiveRegister['installments']),
                'is_array' => is_array($receiveRegister['installments']),
                'count' => isset($receiveRegister['installments']) && is_array($receiveRegister['installments']) ? count($receiveRegister['installments']) : 0,
                'content' => $receiveRegister['installments'] ?? null,
            ]);
            throw new \Exception('Parcelas não enviadas corretamente.');
        }

        foreach ($receiveRegister['installments'] as $installment) {
            Receive::create([
                'receive_code' => $nextReceiveCode++,
                'issuer_id' => $receiveRegister['issuerId'],
                'document' => $nextDocument,
                'description' => $receiveRegister['description'],
                'customer_code' => $customer->customer_code,
                'especie_code' => $specie->payment_code,
                'especie' =>  $specie->especie,
                'name' => $nameCustomer,
                'status' => $receiveRegister['status'],
                'due_date' => $installment['dueDate'],
                'installment_amount' => $receiveRegister['installmentAmount'],
                'installment_number' => $installment['installmentNumber'],
                'installment_value' => $installment['valueOriginal'],
                'installment_paid' => $installment['valuePaid'],
                'type_interest' => $receiveRegister['typeInterest'],
                'interest_value' => $receiveRegister['interestValue'],
                'origem' => $receiveRegister['origem'],
                'user_id' => $receiveRegister['userId'],
                'user' => $user->name,
            ]);
        }
    }

    public function update (array $receiveRegister, int $id){
        return Receive::where('id', $id)->update($receiveRegister);
    }

    public function payInstallment (array $data, int $id){

        Log::info('Dados recebidos: ', $data);

        $installment = Receive::findOrFail($id);
        $issuer = $data['issuerID'];
        $origem = $data['origem'];
        $specie = PaymentForms::where('issuer_id', $data['issuerID'])
                            ->where('payment_code', $data['especieID'])
                            ->first();
        Log::info('Buscando espécie: ', $specie);

        if (!$specie) {
            throw new \Exception("Forma de pagamento não encontrada!");
        }

        $installment->update([
            'status' => 'quitada',
            'especieID' => $specie->id,
            'date_paid' => $data['paymentDate'],
            'installment_paid' => $data['installmentPaid'],
        ]);

        $this->registerInTheCash($installment, $specie, $origem, $issuer);

        return $installment;
    }

    public function undoInstallment (array $data, int $id){
        
    }

    public function registerInTheCash(array $installment, array $specie, string $origem, int $issuer){
        if ($origem === 'RECEBER'){
            CashRegister::create([
                'issuer_id' => $issuer,
                'description' => "Recebimento da parcela Nº {$installment->id}",
                'document' => 
            ]);
        }
    }

    public function delete (int $id){
        return Receive::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}