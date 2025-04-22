<?php

namespace App\Services;

use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;
use App\Repositories\Eloquent\ReceiveRepository;
use App\Services\HotelServices\ReservationService;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class PayMentMethodService
{    
    public function __construct(
        protected CashRegisterRepository $cashRegisterRepository,
        protected ReceiveRepository $receiveRepository,
        protected ReservationService $reservationService,
  
    ){
        Log::info('Memória usada PayMentMethodService::class, __construct, linha 21: ' . memory_get_usage(true));
    }

    public function payment(array $forms, array $paymentValues, object $customer, string $description, string $origem, object $pdv, array $installments)
{
    Log::info('-- Iníciou function Payment in PayMentMethodService --');
    Log::info('Memória usada: ' . memory_get_usage(true));
    Log::info('$paymentValues: ', $paymentValues);

    $currentDate = new Carbon();
    $cashRegisters = [];
    
    Log::info('Se espécies for >= 2');
    if (count($forms) >= 2) {
        Log::info('Possui mais de uma forma de pagamento: ' . count($forms));
        Log::info('Início For | CAIXA');
        for ($i = 1; $i < count($paymentValues); $i++) {
            if ($paymentValues[$i] > 0) {
                foreach ($forms as $form) {
                    if ($form->tipo_lancamento === 'Caixa') {
                        $bodyCash = [
                            'description' => $description === 'nfce' ? "Venda NFC-e N° $pdv->id" : "Venda Nota Manual N° $pdv->id",
                            'document' => $pdv->id,
                            'pdv_id' => $pdv->id,
                            'customer_id' => $customer->id,
                            'name' => $customer->name,
                            'especie_id' => $form->id,
                            'especie' => $form->especie,
                            'date_register' => $currentDate->format('Y-m-d'),
                            'input_value' => $paymentValues[$form->id - 1],
                            'output_value' => 0,
                            'real_balance' => $paymentValues[$form->id - 1],
                            'user_id' => 1,
                            'seller' => 'aa',
                            'origem' => $origem
                        ];
                        $cashRegisters[] = $bodyCash;
                        Log::info('Terminou registro do CAIXA');
                    }

                    Log::info('Se === RECEBER, iniciando registro.');
                    if ($form->tipo_lancamento === 'Receber') {
                        Log::info('Início ForEach Parcelas | RECEBER');
                        foreach ($installments as $installment) {
                            $bodyCash = [
                                'description' => $description === 'nfce' ? "Parcelamento Venda NFC-e N° $pdv->id" : "Parcelamento Venda Nota Manual N° $pdv->id",
                                'document' => $pdv->id,
                                'pdv_id' => $pdv->id,
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currentDate->format('Y-m-d'),
                                'due_date' => $installment['due_date'],
                                'installment_number' => $installment['number'],
                                'installment_value' => $installment['value'],
                                'output_value' => 0,
                                'real_balance' => $installment['value'],
                                'type_interest' => $installment['type_interest'] ?? '%',
                                'interest_value' => $installment['interest'] ?? 0,
                                'total_amount' => $installment['total'] ?? $installment['value'],
                                'user_id' => 1,
                                'user' => 'aa',
                                'origem' => $origem
                            ];
                            $this->receiveRepository->create($bodyCash);
                            Log::info('Terminou registro do RECEBER');
                        }
                    }
                }
            }
        }

        // Se só teve registros no caixa
        if (!empty($cashRegisters)) {
            Log::info('Registros para o CAIXA: ', $cashRegisters);
            $this->cashRegisterRepository->create($cashRegisters);

            if ($origem === 'hotel') {
                $this->reservationService->create($customer);
            }

            return [
                'line' => __LINE__,
                'success' => true
            ];
        }

    } else {
        Log::info('Não possui mais de uma espécie informada: ' . count($forms) . ' Dados: ');
        for ($i=0; $i < count($paymentValues); $i++)
        {
            Log::info('$paymentValues[$i]: i = ' . $i);            
            Log::info('Vai pegar as posições maiores que zero, vezes: ' . $i);
            if($paymentValues[$i] > 0)
            {
                Log::info('forms');
                Log::info($forms);
                foreach ($forms as $form) {
                    Log::info('ID linha 118 - : ' . $form);
                    Log::info('paymentValues - : ' . $paymentValues[$i]);
                    Log::info('Vai conferir os tipos de lançamento');
                    Log::info('$form->tipo_lancamento');
                    Log::info($form);
                    
                    if($form->tipo_lancamento === 'Caixa')
                    {
                        $bodyCash = array(
                            'description' => $description ===  'nfce' ? "Venda NFC-e N° $pdv->id" : "Venda Nota Manual 
                            N° $pdv->id",
                            'document' => $pdv->id,
                            'pdv_id' => $pdv->id,
                            'customer_id' => $customer->id,
                            'name' => $customer->name,
                            'especie_id' => $form->id,
                            'especie' => $form->especie,
                            'date_register' => $currentDate->format('Y-m-d'),
                            'input_value' => $paymentValues[$form->id - 1],
                            'output_value' => 0,
                            'real_balance' => $paymentValues[$form->id - 1],
                            'user_id' => 1,
                            'seller' => 'aa',
                            'origem' => $origem
                        
                        );  
                        array_push($cashRegisters, $bodyCash);
                    }

                    if($form->tipo_lancamento === 'Receber')
                    {
                        $bodyCash = array(
                            'description' => $description ===  'nfce' ? "Parcelamento Venda NFC-e N° $pdv->id" : "Parcelamento Venda Nota Manual 
                            N° $pdv->id",
                            'document' => $pdv->id,
                            'pdv_id' => $pdv->id,
                            'customer_id' => $customer->id,
                            'name' => $customer->name,
                            'especie_id' => $form->id,
                            'especie' => $form->especie,
                            'date_register' => $currentDate->format('Y-m-d'),
                            'due_date' => $currentDate->addDays(30)->format('Y-m-d'),
                            'installment_number' => 1,
                            'installment_value' => $paymentValues[$form->id - 1],
                            'output_value' => 0,
                            'real_balance' => $paymentValues[$form->id - 1],
                            'type_interest' => '%',
                            'interest_value' => 10,
                            'total_amount' => 10,
                            'user_id' => 1,
                            'user' => 'aa',
                            'origem' => $origem
                        
                        );  
                        
                        Log::info('-- Vai chamar o receiveRepository -- ');
                        $this->receiveRepository->create($bodyCash);           
                        Log::info('-- Terminou de chamar o receiveRepository -- ');
                    }
                }
            }
        }
    }

    return [
        'line' => __LINE__,
        'success' => false,
        'message' => 'Nenhuma forma de pagamento válida processada.'
    ];
}

    public function decreaseCash(object $customer, float $value, string $description, string $origem)
    {
        Log::info('-- Inicio decreaseCash --');
        Log::info('Memória usada PayMentMethodService::class, decreaseCash: ' . memory_get_usage(true));
        $currentDate = new Carbon();
        $cashRegisters = [];
        $cashRegisters[] = [
            'description' => $description,
            'document' => 1,
            'customer_id' => $customer->id,
            'name' => $customer->name,
            'especie_id' => 1,
            'especie' => 'Dinheiro',
            'date_register' => $currentDate->format('Y-m-d'),
            'input_value' => 0,
            'output_value' => $value,
            'real_balance' => $value,
            'user_id' => 1,
            'seller' => 'aa',
            'origem' => $origem
        ];  

        Log::info('Corpo: ');
        Log::info($cashRegisters);    
        Log::info('-- Vai chamar o cashRegisterRepository -- ');
        $this->cashRegisterRepository->create($cashRegisters);
        Log::info('-- Fim decreaseCash --');
        return array(
            'line' => 266,
            'success' => true
        );  
    }
}