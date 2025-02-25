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
    public function payment(array $formsPayment, array $payment, object $customer)
    {
        $currantDate = new Carbon();
        Log::info('-- Inicio do registro no caixa, PayMentMethod.php, linha 15 --');
        Log::info('Possui mais de uma espécie informada: ' . count($formsPayment));
        $cashRegisters = [];
        for ($i=0; $i < count($formsPayment); $i++)
        { // Percore todo o array enviado de valores
            Log::info('$payment[$i] linha - 32: i = ' . $i);            
            if($payment[$i] > 0)
            {
                foreach ($formsPayment as $form) 
                {
                    Log::info('Vai pegar as posições maiores que zero, vezes: ' . $i);
                    Log::info('formsPayment linha 26 - : ');
                    Log::info('ID linha 27 - : ' . $form);

                    $cashRegisters[] = array(
                        'description' => 'Reserva de Hotel',
                        'cliente_id' => $customer->id,
                        'cliente' => $customer->name,
                        'especie_id' => $form->id,
                        'especie' => $form->especie,
                        'data_hora_cadastro' => $currantDate->format('Y-m-d'),
                        'valor_entrada' => $payment[$form->id - 1],
                        'valor_saida' => 0,
                        'saldo_real' => 0,
                        'user_id' => 1,
                        'seller' => 'aa',
                        'origem' => 'Reserva Hotel'
                    
                    );  
                }
            }                         
            Log::info('-- Fim do registro no caixa, PayMentMethod.php, linha 52 --');
          
        }    
        Log::info('Dados de envio: ');
        Log::info($cashRegisters);
        $this->cashRegisterRepository->create($cashRegisters);    
        Log::info('-- Fim do registro no caixa, PayMentMethod.php, linha 63 --');
    }    
}