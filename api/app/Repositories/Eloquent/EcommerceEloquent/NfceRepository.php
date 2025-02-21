<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Customer;
use App\Models\EcommerceModels\FormaPagamentoNfce;
use App\Models\EcommerceModels\Nfce;
use App\Models\EcommerceModels\Payment;
use App\Models\EcommerceModels\User;
use Illuminate\Support\Facades\Log;

class NfceRepository
{
    public function __construct(
        protected ConsumerRepository $consumerRepository,
        protected CashRegisterRepository $cashRegisterRepository,
    )
    {
        $this->consumerRepository = $consumerRepository;
        $this->cashRegisterRepository = $cashRegisterRepository;
    }

    public function getAll(int $active){
        Log::info("Vai buscar todas as NFC-e ativas da table = nfce");
        return Nfce::where('active', $active)->get();
    }

    public function store(array $data){
        Log::info("Buscando cliente da venda.");
        $customer = Customer::where('id', $data['id'])->first();

        Log::info("Buscando usuário logado.");
        $user = User::where('id', $data['id'])->first();

        Log::info("Buscando espécie utilizada.");
        $paymentForm = FormaPagamentoNfce::where('id', $data['id'])->first();

        if($customer && $user && $paymentForm){

            Log::info("Vai criar NFC-e.");
            $nfce = Nfce::create([
                'valor_bruto' => $paymentForm->valor_bruto,
                'valor_liquido' => $paymentForm->valor_liquido,
                'valor_desconto' => $paymentForm->valor_desconto,
                'especie' => $paymentForm->especie,
            ]);

            Log::info("Vai criar a forma de pagamento.");
            $payment = FormaPagamentoNfce::create([
                'cod_especie' => $paymentForm->id,
                'espécie' => $paymentForm->descricao,
                'valor_bruto' => $nfce->valor_bruto,
                'valor_liquido' => $nfce->valor_liquido,
                'valor_desconto' => $nfce->valor_desconto,
            ]);

            Log::info("Update do Nº documento venda.");
            $nfce->update([
                'documento' => $nfce->documento + 1,
                'descricao' => "VENDA NFC-E: $nfce->id",
            ]);

            Log::info("Update do Nº documento forma pagamento.");
            $payment->update([
                'documento' => $payment->documento + 1,
            ]);

            Log::info("Vai salvar!");
            $nfce->save();
            $payment->save();

        } else if (!$customer){
            return array('message' => 'Cliente não encontrado!');
        } else if (!$user){
            return array('message' => 'Usuário não encontrado!');
        } else if (!$paymentForm){
            return array('message' => 'Forma de pagamento não encontrada!');
        }

    }

    public function update(array $data, int $id){
        return Nfce::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Nfce::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}