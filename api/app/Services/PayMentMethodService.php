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

    public function payment(array $forms, array $paymentValues, object $customer, string $description, string $origem, object $pdv)
    {   // Método para ser adicioando ao caixa                
        Log::info('-- Inicio do registro no caixa, PayMentMethodService.php, linha 26 --');
        Log::info('Memória usada PayMentMethodService::class, payment: ' . memory_get_usage(true));
        
        Log::info('$forms');
        Log::info($forms);

        Log::info('$paymentValues');
        Log::info($paymentValues);

        $currantDate = new Carbon();
        $cashRegisters = [];
        if(count($forms) >= 2) // Como já foi feito o find das formas de pagamento, utilize o $forms
        {  
            Log::info('Possui mais de uma espécie informada: ' . count($forms));
            Log::info('Total de pagamentos: ' . count($paymentValues));
            // Percore todo o array enviado de valores
            // MANTER O $i = 1, caso contrário vai dar bo se tiver mais de uma espécie informada
            for ($i=1; $i < count($paymentValues); $i++) 
            {
                Log::info($i);
                Log::info('$paymentValues[$i] linha - 37: i = ' . $i);            
                if($paymentValues[$i] > 0)
                {
                    Log::info('Vai pegar as posições maiores que zero, posição: ' . $i);
                    foreach ($forms as $form) 
                    {
                        Log::info('ID linha 43 - : ' . $form);
                        Log::info('paymentValues linha 44 - : ' . $paymentValues[$i]);
                        Log::info('Vai conferir os tipos de lançamento');
                        if($form->tipo_lancamento === 'Caixa')
                        {
                            $bodyCash = array(
                                'description' => $description,
                                'pdv_id' => $pdv->id,
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
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
                                'description' => $description,
                                'pdv_id' => $pdv->id,
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
                                'due_date' => $currantDate->addDays(30)->format('Y-m-d'),
                                'installment_amount' => 1,
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

            Log::info('Terminou de montar o corpo dos registros: ');
            Log::info('Dados de envio: ');
            Log::info($cashRegisters);
            Log::info('-- Vai chamar o cashRegisterRepository linha 104 -- ');
            $this->cashRegisterRepository->create($cashRegisters);
            if($origem == 'hotel')
            {
                Log::info('-- Vai chamar o reservationRepository linha 106 -- ');
                $this->reservationService->create($customer);

            }
            
            Log::info('-- Terminou de chamar o cashRegisterRepository -- ');
            Log::info('-- Fim do registro no caixa, PayMentMethodService.php, linha 109 --');
            return;
        }

        if(count($forms) <= 1)
        {
            Log::info('Não possui mais de uma espécie informada: ' . count($forms) . ' Dados: ');
            for ($i=0; $i < count($paymentValues); $i++)
            {
                Log::info('$paymentValues[$i] linha - 118: i = ' . $i);            
                Log::info('Vai pegar as posições maiores que zero, vezes: ' . $i);
                if($paymentValues[$i] > 0)
                {
                    Log::info('forms');
                    Log::info($forms);
                    foreach ($forms as $form) {
                        Log::info('ID linha 120 - : ' . $form);
                        Log::info('paymentValues linha 124 - : ' . $paymentValues[$i]);
                        Log::info('Vai conferir os tipos de lançamento');
                        Log::info('$form->tipo_lancamento');
                        Log::info($form);
                        
                        if($form->tipo_lancamento === 'Caixa')
                        {
                            $bodyCash = array(
                                'description' => $description,
                                'pdv_id' => $pdv->id,
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
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
                                'description' => $description,
                                'pdv_id' => $pdv->id,
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
                                'due_date' => $currantDate->addDays(30)->format('Y-m-d'),
                                'installment_amount' => 1,
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
                            
                            Log::info('-- Vai chamar o receiveRepository linha 170 -- ');
                            $this->receiveRepository->create($bodyCash);
                            Log::info('-- Terminou de chamar o receiveRepository -- ');

                        }
                    }
                }
            }
        }
    
        Log::info('Terminou de montar o corpo do caixa: ');
        Log::info('Dados: ');
        Log::info($cashRegisters);
        Log::info('-- Vai chamar o cashRegisterRepository linha 183 -- ');
        $this->cashRegisterRepository->create($cashRegisters);
        Log::info('-- Vai chamar o reservationRepository linha 185 -- ');
        if($origem == 'hotel')
            {
                Log::info('-- Vai chamar o reservationRepository linha 106 -- ');
                $this->reservationService->create($customer);

            }
        Log::info('-- Terminou de chamar o cashRegisterRepository -- ');
        Log::info('-- Fim do registro no caixa, PayMentMethodService.php, linha 188 --');
        return;
    }    

    public function decreaseCash(object $customer, float $value, string $description, string $origem)
    {
        Log::info('-- Inicio decreaseCash linha 194 --');
        Log::info('Memória usada PayMentMethodService::class, decreaseCash: ' . memory_get_usage(true));
        $currantDate = new Carbon();
        $cashRegisters = [];
        $cashRegisters[] = array(
            'description' => $description,
            'customer_id' => $customer->id,
            'name' => $customer->name,
            'especie_id' => 1,
            'especie' => 'Dinheiro',
            'date_register' => $currantDate->format('Y-m-d'),
            'input_value' => 0,
            'output_value' => $value,
            'real_balance' => $value,
            'user_id' => 1,
            'seller' => 'aa',
            'origem' => $origem
        
        );  
        Log::info('Corpo: ');
        Log::info($cashRegisters);    
        Log::info('-- Vai chamar o cashRegisterRepository linha 214 -- ');
        $this->cashRegisterRepository->create($cashRegisters);
        Log::info('-- Fim decreaseCash linha 216 --');
    }
    
}