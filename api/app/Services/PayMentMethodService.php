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
        Log::info('Memória usada PayMentMethodService::class, __construct, linha 22: ' . memory_get_usage(true));
    }

    public function payment(array $formsPayment, array $payment, object $customer, string $description, string $origem)    
    {   // Método para ser adicioando ao caixa                
        Log::info('-- Inicio do registro no caixa, PayMentMethodService.php, linha 24 --');
        Log::info('Memória usada PayMentMethodService::class, payment: ' . memory_get_usage(true));
        Log::info('Quantia $formsPayment: ' . count($formsPayment));
        $currantDate = new Carbon();
        $cashRegisters = [];
        if(count($formsPayment) >= 2) // Como já foi feito o find das formas de pagamento, utilize o $formsPayment
        {  
            Log::info('Possui mais de uma espécie informada: ' . count($formsPayment));
            Log::info('Total de pagamentos: ' . count($payment));
            // Percore todo o array enviado de valores
            // MANTER O $i = 1, caso contrário vai dar bo se tiver mais de uma espécie informada
            for ($i=1; $i < count($payment); $i++) 
            {
                Log::info($i);
                Log::info('$payment[$i] linha - 37: i = ' . $i);            
                if($payment[$i] > 0)
                {
                    Log::info('Vai pegar as posições maiores que zero, posição: ' . $i);
                    foreach ($formsPayment as $form) 
                    {
                        Log::info('ID linha 43 - : ' . $form);
                        Log::info('Payment linha 44 - : ' . $payment[$i]);
                        Log::info('Vai conferir os tipos de lançamento');
                        if($form->tipo_lancamento === 'Caixa')
                        {
                            $bodyCash = array(
                                'description' => $description,
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
                                'input_value' => $payment[$form->id - 1],
                                'output_value' => 0,
                                'real_balance' => $payment[$form->id - 1],
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
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
                                'due_date' => $currantDate->addDays(30)->format('Y-m-d'),
                                'installment_amount' => 1,
                                'installment_number' => 1,
                                'installment_value' => $payment[$form->id - 1],
                                'output_value' => 0,
                                'real_balance' => $payment[$form->id - 1],
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
            Log::info('-- Vai chamar o reservationRepository linha 106 -- ');
            $this->reservationService->create($customer);
            Log::info('-- Terminou de chamar o cashRegisterRepository -- ');
            Log::info('-- Fim do registro no caixa, PayMentMethodService.php, linha 109 --');
            return;
        }

        if(count($formsPayment) <= 1)
        {
            Log::info('Não possui mais de uma espécie informada: ' . count($formsPayment) . ' Dados: ');
            for ($i=0; $i < count($payment); $i++)
            {
                Log::info('$payment[$i] linha - 118: i = ' . $i);            
                Log::info('Vai pegar as posições maiores que zero, vezes: ' . $i);
                if($payment[$i] > 0)
                {
                    foreach ($formsPayment as $form) {
                        Log::info('ID linha 120 - : ' . $form);
                        Log::info('Payment linha 124 - : ' . $payment[$i]);
                        Log::info('Vai conferir os tipos de lançamento');
                        if($form->tipo_lancamento === 'Caixa')
                        {
                            $bodyCash = array(
                                'description' => $description,
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
                                'input_value' => $payment[$form->id - 1],
                                'output_value' => 0,
                                'real_balance' => $payment[$form->id - 1],
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
                                'customer_id' => $customer->id,
                                'name' => $customer->name,
                                'especie_id' => $form->id,
                                'especie' => $form->especie,
                                'date_register' => $currantDate->format('Y-m-d'),
                                'due_date' => $currantDate->addDays(30)->format('Y-m-d'),
                                'installment_amount' => 1,
                                'installment_number' => 1,
                                'installment_value' => $payment[$form->id - 1],
                                'output_value' => 0,
                                'real_balance' => $payment[$form->id - 1],
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
        $this->reservationService->create($customer);
        Log::info('-- Terminou de chamar o cashRegisterRepository -- ');
        Log::info('-- Fim do registro no caixa, PayMentMethodService.php, linha 188 --');
        return;
    }    

    public function decreaseCash(object $customer, float $value, string $description, string $origem, object $room)
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