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
        Log::info('Dados recebidos: '. $receiveRegister);

        $user = User::where('user_code', $receiveRegister['userId'])->first();
        Log::info('Buscando usuário: '. ['user' => $user]);

        $customer = Customer::where('issuer_id', $receiveRegister['issuerId'])->first();
        Log::info('Buscando cliente: '. ['cliente' => $customer]);

        $specie = PaymentForms::where('issuer_id', $receiveRegister['issuerId'])
                            ->where('payment_code', $receiveRegister['especieId'])
                            ->first();
        Log:info('Buscando espécie: '. ['especie' => $specie]);

        if (!$user || !$customer || !$specie) {
            Log::error('Dados inválidos no registro de recebimento.');
            throw new \Exception('Usuário, cliente ou espécie inválidos.');
        }

        $nameCustomer = $customer->company_name ?: $customer->trade_name;
        $receiveRegisterCod = Receive::where('issuer_id', $receiveRegister['issuerId'])->max('receive_cod');
        $document = Receive::where('issuer_id', $receiveRegister['issuerId'])->max('document');

        $nextReceiveCod = $receiveRegisterCod ? $receiveRegisterCod + 1 : 1;
        $nextDocument = isset($receiveRegister['document']) ? $receiveRegister['document'] : ($document ? $document + 1 : 1);

        foreach ($receiveRegister['installments'] as $installment) {
            try {
                Receive::create([
                    'receive_cod' => $nextReceiveCod,
                    'issuer_id' => $receiveRegister['issuerId'],
                    'document' => $nextDocument,
                    'description' => $receiveRegister['description'],
                    'customer_code' => $customer->customer_code,
                    'name' => $nameCustomer,
                    'especie_code' => $specie->payment_code,
                    'especie' =>  $specie->especie,
                    'due_date' => $installment['dueDate'],
                    'installment_amount' => $receiveRegister['installmentAmount'],
                    'installment_number' => $installment['installmentNumber'],
                    'installment_value' => $installment['installmentValue'],
                    'installment_paid' => $installment['paid'] ?? false,
                    'type_interest' => $receiveRegister['typeInterest'],
                    'interest_value' => $receiveRegister['interestValue'],
                    'origem' => $receiveRegister['origem'],
                    'user_id' => $receiveRegister['userId'],
                    'user' => $user->name,
                ]);
                
            } catch (\Exception  $e) {
                Log::error('Erro ao salvar recebimento: ' . $e->getMessage());
            }
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