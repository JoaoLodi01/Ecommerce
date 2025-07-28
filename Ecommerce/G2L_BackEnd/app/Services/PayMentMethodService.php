<?php

namespace App\Services;

use App\DTO\CashRegister\CashRegisteDTO;
use App\Models\EcommerceModels\CashRegister;
use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;
use App\Repositories\Eloquent\ReceiveRepository;
use App\Services\Contract\PayMentMethodContract;
use App\Services\HotelServices\ReservationService;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class PayMentMethodService implements PayMentMethodContract
{    
    public function __construct(
        protected CashRegisterRepository $cashRegisterRepository,
        protected ReceiveRepository $receiveRepository,
        protected ReservationService $reservationService,
  
    ){}

    public function payment(
        array $paymentForms, // Formas de pagamento
        array $paymentValues, // Valores pagos
        object $customer, // Cliente da nota
        string $description, // Tipo de venda
        string $origem, // Origem
        object $pdv, // Corpo do PDV
        int $issuerID, // ID do emitente,
        object $user // Usuário que fez a venda
                
    )
    {   // Método para ser adicioando ao caixa                
        Log::channel('payment')->info('-- Inicio do registro no caixa, PayMentMethodService.php, linha 32 --');

        $currentDate = new Carbon();
        $cashRegisters = [];
        
        for ($i=0; $i < count($paymentForms); $i++) { 
            $maxDocument = CashRegister::where('issuer_id', $issuerID)->max('document');
            
            Log::channel('payment')->info("maxDocument: {$maxDocument}");

            $specie = $paymentForms[$i];
            
            $cashRegisters[] = [
                'cash_register_code' => 1,
                'issuer_id' => $issuerID,
                'description' => $pdv->description,
                'document' => 1,
                'pdv_code' => $pdv->pdv_code,
                'receive_code' => null,
                'receive_document' => null,
                'to_pay_code' => null,
                'to_pay_document' => null,
                'customer_code' => $customer->customer_code,
                'name' => $customer->company_name ? $customer->company_name : $customer->trade_name,
                'especie_code' => $specie->payment_code,
                'especie' => $specie->especie,
                'date_register' => $currentDate->format('Y-m-d'),
                'input_value' => $paymentValues[$specie->payment_code - 1],
                'output_value' => 0,
                'origem' => $origem,
                'user_id' => $user->user_code,
                'seller' => $user->name,   
            ];    
        }

        $cashRegisterDTOs = array_map(fn($data) => new CashRegisteDTO(
            cash_register_code: $data['cash_register_code'],
            issuer_id: $data['issuer_id'],
            description: $data['description'],
            document: $data['document'],
            pdv_code: $data['pdv_code'],
            receive_code: $data['receive_code'],
            receive_document: $data['receive_document'],
            to_pay_code: $data['to_pay_code'],
            to_pay_document: $data['to_pay_document'],
            customer_code: $data['customer_code'],
            name: $data['name'],
            especie_code: $data['especie_code'],
            especie: $data['especie'],
            date_register: $data['date_register'],
            input_value: $data['input_value'],
            output_value: $data['output_value'],
            origem: $data['origem'],
            user_id: $data['user_id'],
            seller: $data['seller'],


        ), $cashRegisters);

        foreach ($cashRegisterDTOs as $dto) {
            $this->cashRegisterRepository->create($dto);

        }
        
        return true;
    }    

    public function decreaseCash(object $customer, float $value, string $description, string $origem, string|int $issuerID)
    {
        Log::info('-- Inicio decreaseCash --');
        Log::info('Memória usada PayMentMethodService::class, decreaseCash: ' . memory_get_usage(true));
        $currentDate = new Carbon();
        $cashRegisters = [];
        $maxCashRegister = CashRegister::where('issuer_id', $issuerID)->max('cash_register_code');
        Log::info('-- Máximo encontrado iniciado --');
        $maxDocument = CashRegister::where('issuer_id', $issuerID)
                                        ->selectRaw('MAX(CAST(document AS UNSIGNED)) as max_doc')
                                        ->value('max_doc');

        Log::info($maxDocument);
        Log::info('-- Fim do máximo encontrado --');

        $cashRegisters[] = [
            'cash_register_code' => $maxCashRegister ? $maxCashRegister + 1 : 1,
            'issuer_id' => $issuerID,
            'description' => $description,
            'document' => $maxDocument ? $maxDocument + 1 : 1,
            'customer_code' => $customer->id,
            'name' => $customer->company_name,
            'especie_code' => 1,
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
        //$this->cashRegisterRepository->create($cashRegisters);
        Log::info('-- Fim decreaseCash --');
        return array(
            'line' => 266,
            'success' => true
        );  
    }
}