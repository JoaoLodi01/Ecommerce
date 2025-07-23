<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\DTO\CashRegister\CashRegisteDTO;
use App\Models\Customer;
use App\Models\EcommerceModels\CashRegister;
use App\Models\EcommerceModels\PaymentForms;
use App\Models\Registers\User;
use Illuminate\Support\Facades\Log;
class CashRegisterRepository
{
    public function getAll(int $issuer_id)
    { 
        Log::info('Memória usada CashRegisterRepository::class, getAll: ' . memory_get_usage(true));
        $cashRegister =  CashRegister::where('issuer_id', $issuer_id)->get();

        return $cashRegister;
    }

    public function findByPDVCode(int $issuerID, int $pdvCode)
    {
        Log::info('Memória usada CashRegisterRepository::class, findByID: ' . memory_get_usage(true));
        return CashRegister::where('issuer_id', $issuerID)->where('pdv_code', $pdvCode)->get();
    }

    public function create(CashRegisteDTO $dto)
    {
        Log::info('INICIOU REGISTRO NO CAIXA');

        Log::info($dto->especie);
    
        $document = CashRegister::where('issuer_id', $dto->issuer_id)->max('document');
        $maxCashRegisterCode = CashRegister::where('issuer_id', $dto->issuer_id)->max('cash_register_code');
        
        CashRegister::create([
            'cash_register_code' => $maxCashRegisterCode ? $maxCashRegisterCode + 1 : 1,
            'issuer_id' => $dto->issuer_id,
            'description' => $dto->description,
            'document' => $document ? $document + 1 : 1,
            'pdv_code' => $dto->pdv_code,
            'receive_code' => $dto->receive_code,
            'receive_document' => $dto->receive_document,
            'customer_code' => $dto->customer_code,
            'name' => $dto->name,
            'especie_code' => $dto->especie_code,
            'especie' => $dto->especie,
            'date_register' => $dto->date_register,
            'input_value' => $dto->input_value,
            'output_value' => $dto->output_value,
            'origem' => $dto->origem,
            'user_id' => $dto->user_id,
            'seller' => $dto->seller,
        ]);
    
        $this->updateCurrentCash($dto->issuer_id);
    }

    public function updateCurrentCash(int $issuer_id)
    {   
        Log::channel('payment')->info("Chamou o updateCurrentCash \n");
        $lastCashBox = CashRegister::where('canceled', 0)->where('issuer_id', $issuer_id)->latest('cash_register_code')->first();
        Log::channel('payment')->info("Last Cash box: {$lastCashBox}");
    
        $actualCashBox = CashRegister::where('canceled', 0)->where('issuer_id', $issuer_id)->where('cash_register_code', $lastCashBox->cash_register_code - 1)->first();
        Log::channel('payment')->info("actual Cash Box: {$actualCashBox}");
        
        if(!$actualCashBox)
        {
            Log::info('Não foi encontrado um registro anterior do segundo registro no caixa');
            if($lastCashBox->input_value > 0)
            {
                Log::info('Foi informado um valor de entrada');
                Log::info('real_balance: R$ ' . $lastCashBox->input_value);

                $lastCashBox->update([
                    'real_balance' => $lastCashBox->input_value

                ]);
            }

            if($lastCashBox->output_value > 0)
            {
                Log::info('Foi informado um valor de saída');
                Log::info('real_balance: R$ ' . $lastCashBox->output_value - ($lastCashBox->output_value * 2));
                $lastCashBox->update([
                    'real_balance' => $lastCashBox->output_value - ($lastCashBox->output_value * 2)

                ]);
            }
            
            return;
            
        } else {
            Log::info('Foi encontrado mais um registro');
            Log::info('Novo valor: R$ ' . $actualCashBox->input_value . ' + '  . $lastCashBox->input_value . ' - ' . $lastCashBox->output_value . ' = ' . $actualCashBox->input_value + $lastCashBox->input_value);
            $lastCashBox->update([
                'real_balance' => $actualCashBox->real_balance + $lastCashBox->input_value - $lastCashBox->output_value
            ]);
        }
        
    }

    public function update(array $cashRegisters, int $id){
        return CashRegister::where('id', $id)->update($cashRegisters);
    }

    public function delete(int $id){
        return CashRegister::where('id', $id)->update([
            'active' => 0,
        ]);

        
    }    
}