<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\Customer;
use App\Models\EcommerceModels\FormaPagamentoNfce;
use App\Models\EcommerceModels\FormaPagamentoPDV;
use App\Models\EcommerceModels\Payment;
use App\Models\EcommerceModels\PDV;
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
        return PDV::where('active', $active)->get();
    }

    public function store(array $data){
        Log::info("Buscando cliente da venda.");
        $customer = Customer::where('id', $data['id'])->first();

        Log::info("Buscando usuário logado.");
        $user = User::where('id', $data['id'])->first();

        Log::info("Buscando espécie utilizada.");
        $species = FormaPagamentoPDV::where('id', $data['id'])->first();

        if($customer && $user && $species){

            Log::info("Vai criar NFC-e.");
            $nfce = PDV::create([
                'valor_bruto' => $species->valor_bruto,
                'valor_liquido' => $species->valor_liquido,
                'valor_desconto' => $species->valor_desconto,
                'especie' => $species->especie,
            ]);

            Log::info("Vai criar a forma de pagamento.");
            $payment = FormaPagamentoPDV::create([
                'cod_especie' => $species->id,
                'espécie' => $species->descricao,
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
        } else if (!$species){
            return array('message' => 'Forma de pagamento não encontrada!');
        }

    }

    public function update(array $data, int $id){
        Log::info("Caiu no update.");
        return PDV::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        Log::info("Caiu no delete");
        return PDV::where('id', $id)->update([
            'active' => 0,
        ]);
    }

}