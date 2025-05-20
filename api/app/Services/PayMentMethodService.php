<?php

namespace App\Services;

use App\Models\EcommerceModels\CashRegister;
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
        Log::info('Memória usada PayMentMethodService::class, __construct, linha 20: ' . memory_get_usage(true));
    }

    public function payment(
        array $forms, 
        array $paymentValues, 
        object $customer, 
        string $description, 
        string $origem, 
        object $pdv,
        int $issuerID
                
    )
    {   // Método para ser adicioando ao caixa                
        Log::info('-- Inicio do registro no caixa, PayMentMethodService.php, linha 33 --');
        Log::info("ISSUER_ID $issuerID");

        $currentDate = new Carbon();
        $cashRegisters = [];

        Log::info('-- Máximo encontrado iniciado --');
        $maxDocument = CashRegister::where('issuer_id', $issuerID)
                                        ->selectRaw('MAX(CAST(document AS UNSIGNED)) as max_doc')
                                        ->value('max_doc');

        Log::info($maxDocument);
        Log::info('-- Fim do máximo encontrado --');
        if(count($forms) >= 2) // Como já foi feito o find das formas de pagamento, utilize o $forms
        {   
            // Percore todo o array enviado de valores
            // MANTER O $i = 1, caso contrário vai dar bo se tiver mais de uma espécie informada
            for ($i=1; $i < count($paymentValues); $i++) 
            {
                if($paymentValues[$i] > 0)
                {
                    Log::info('Vai pegar as posições maiores que zero, posição: ' . $i);
                    foreach ($forms as $form) 
                    {
                        Log::info('ID linha 43 - : ' . $form);
                        Log::info('paymentValues linha 51 - : ' . $paymentValues[$i]);
                        Log::info('Vai conferir os tipos de lançamento');

                        if($form->tipo_lancamento === 'Caixa')
                        {
                            $bodyCash = array(
                                'issuer_id' => $issuerID,
                                'description' => $description ===  'nfce' ? "Venda NFC-e N° $pdv->pdv_cod" : "Venda Nota Manual N° $pdv->pdv_cod",
                                'document' => $maxDocument ? $maxDocument + 1 : 1,
                                'pdv_cod' => $pdv->pdv_cod,
                                'customer_cod' => $customer->id,
                                'name' => $customer->company_name,
                                'especie_cod' => $form->payment_cod,
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

                        Log::info('-- Iniciou registro no Receber -- ');
                        if($form->tipo_lancamento === 'Receber')
                        {
                            $bodyCash = array(
                                'issuer_id' => $issuerID,
                                'description' => $description ===  'nfce' ? "Parcelamento Venda NFC-e N° $pdv->pdv_cod" : "Parcelamento Venda Nota Manual 
                                N° $pdv->pdv_cod",
                                'document' => $maxDocument ? $maxDocument + 1 : 1,
                                'pdv_cod' => $pdv->pdv_cod,
                                'customer_cod' => $customer->customer_cod,
                                'name' => $customer->company_name,
                                'especie_cod' => $form->payment_cod,
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
                            Log::info('-- Terminou o registro -- ');
                            Log::info('-- Vai chamar o receiveRepository -- ');
                            $receive = $this->receiveRepository->create($bodyCash);
                            return array(
                                'success' => true
                            );
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
            return array(
                'line' => 124,
                'success' => true
    
            ); 
        }

        if(count($forms) <= 1)
        {
            $maxDocument = CashRegister::where('issuer_id', $issuerID)
                                        ->selectRaw('MAX(CAST(document AS UNSIGNED)) as max_doc')
                                        ->value('max_doc');

            Log::info('-- Máximo encontrado --');
            Log::info($maxDocument);
            Log::info('-- Fim do máximo encontrado --');

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

                        $maxCashRegister = CashRegister::where('issuer_id', $issuerID)->max('cash_register_cod');
                        if($form->tipo_lancamento === 'Caixa')
                        {
                            $bodyCash = array(
                                'cash_register_cod' => $maxCashRegister ? $maxCashRegister + 1 : 1,
                                'issuer_id' => $issuerID,
                                'description' => $description ===  'nfce' ? "Venda NFC-e N° $pdv->pdv_cod" : "Venda Nota Manual N° $pdv->pdv_cod",
                                'document' => $maxDocument ? $maxDocument + 1 : 1,
                                'pdv_cod' => $pdv->pdv_cod,
                                'customer_cod' => $customer->customer_cod,
                                'name' => $customer->company_name,
                                'especie_cod' => $form->payment_cod,
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
                                'cash_register_cod' => $maxCashRegister ? $maxCashRegister + 1 : 1,
                                'issuer_id' => $issuerID,
                                'description' => $description ===  'nfce' ? "Parcelamento Venda NFC-e N° $pdv->pdv_cod" : "Parcelamento Venda Nota Manual 
                                N° $pdv->pdv_cod",
                                'document' => $maxDocument ? $maxDocument + 1 : 1,
                                'pdv_cod' => $pdv->pdv_cod,
                                'customer_cod' => $customer->customer_cod,
                                'name' => $customer->company_name,
                                'especie_cod' => $form->payment_cod,
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
                            
                            Log::info('-- Vai chamar o receiveRepository linha 170 -- ');
                            $this->receiveRepository->create($bodyCash);
                            return array(
                                'success' => true
                            );
                            
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
        return array(
            'line' => 215,
            'success' => true

        );  
    }    

    public function decreaseCash(object $customer, float $value, string $description, string $origem, string|int $issuerID)
    {
        Log::info('-- Inicio decreaseCash --');
        Log::info('Memória usada PayMentMethodService::class, decreaseCash: ' . memory_get_usage(true));
        $currentDate = new Carbon();
        $cashRegisters = [];
        $maxCashRegister = CashRegister::where('issuer_id', $issuerID)->max('cash_register_cod');
        Log::info('-- Máximo encontrado iniciado --');
        $maxDocument = CashRegister::where('issuer_id', $issuerID)
                                        ->selectRaw('MAX(CAST(document AS UNSIGNED)) as max_doc')
                                        ->value('max_doc');

        Log::info($maxDocument);
        Log::info('-- Fim do máximo encontrado --');

        $cashRegisters[] = [
            'cash_register_cod' => $maxCashRegister ? $maxCashRegister + 1 : 1,
            'issuer_id' => $issuerID,
            'description' => $description,
            'document' => $maxDocument ? $maxDocument + 1 : 1,
            'customer_cod' => $customer->id,
            'name' => $customer->company_name,
            'especie_cod' => 1,
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