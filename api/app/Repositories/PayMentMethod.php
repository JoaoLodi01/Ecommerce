<?php

namespace App\Repositories;

use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class PayMentMethod
{
    public function __construct(
        protected CashRegisterRepository $cashRegisterRepository
    )
    {
        $this->cashRegisterRepository = $cashRegisterRepository;
    }
    public function payment(array $formsPayment, array $payment, object $customer, string $description, string $origem)
    {
        Log::info('-- Inicio do registro no caixa, PayMentMethod.php, linha 19 --');
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
                Log::info('$payment[$i] linha - 30: i = ' . $i);            
                if($payment[$i] > 0)
                {
                    Log::info('Vai pegar as posições maiores que zero, posição: ' . $i);
                    foreach ($formsPayment as $form) 
                    {
                        Log::info('ID linha 35 - : ' . $form);
                        Log::info('Payment linha 36 - : ' . $payment[$i]);
                        
                        $bodyCash = array(
                            'description' => $description,
                            'cliente_id' => $customer->id,
                            'cliente' => $customer->name,
                            'especie_id' => $form->id,
                            'especie' => $form->especie,
                            'data_hora_cadastro' => $currantDate->format('Y-m-d'),
                            'valor_entrada' => $payment[$form->id - 1],
                            'valor_saida' => 0,
                            'saldo_real' => $payment[$form->id - 1],
                            'user_id' => 1,
                            'seller' => 'aa',
                            'origem' => $origem
                        
                        );  
                        array_push($cashRegisters, $bodyCash);
                        
                    }
                    
                }                         
            }    

            Log::info('Terminou de montar o corpo do caixa: ');
            Log::info('Dados de envio: ');
            Log::info($cashRegisters);
            $this->cashRegisterRepository->create($cashRegisters);
            Log::info('-- Fim do registro no caixa, PayMentMethod.php, linha 58 --');
            return;
        }

        if(count($formsPayment) <= 1)
        {
            Log::info('Não possui mais de uma espécie informada: ' . count($formsPayment) . ' Dados: ');
            for ($i=0; $i < count($payment); $i++)
            {
                Log::info('$payment[$i] linha - 71: i = ' . $i);            
                Log::info('Vai pegar as posições maiores que zero, vezes: ' . $i);
                if($payment[$i] > 0)
                {
                    foreach ($formsPayment as $form) {
                        Log::info('ID linha 77 - : ' . $form);

                        $cashRegisters[] = array(
                            'description' => 'Reserva de Hotel',
                            'cliente_id' => $customer->id,
                            'cliente' => $customer->name,
                            'especie_id' => $form->id,
                            'especie' => $form->especie,
                            'data_hora_cadastro' => $currantDate->format('Y-m-d'),
                            'valor_entrada' => $payment[$form->id - 1],
                            'valor_saida' => 0,
                            'saldo_real' => $payment[$form->id - 1],
                            'user_id' => 1,
                            'seller' => 'aa',
                            'origem' => 'Reserva Hotel'
                        
                        );  
                    }
                }
            }
        }
        
        Log::info('Terminou de montar o corpo do caixa: ');
        Log::info('Dados: ');
        Log::info($cashRegisters);

        $this->cashRegisterRepository->create($cashRegisters);
        Log::info('-- Fim do registro no caixa, PayMentMethod.php, linha 100 --');
        return;
    }    
}