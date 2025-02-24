<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\Customer;
use App\Models\EcommerceModels\{
    PDV,
    FormaPagamentoPDV,
    Payment,
    User,
    Receive
};

use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;
use App\Repositories\Eloquent\CustomerRepository;

use Illuminate\Support\Facades\Log;

class PDVRepository
{
    public function __construct(
        protected CustomerRepository $customerRepository,
        protected CashRegisterRepository $cashRegisterRepository,
    )
    {
        $this->customerRepository = $customerRepository;
        $this->cashRegisterRepository = $cashRegisterRepository;
    }

    public function getAll(int $active){
        Log::info("Vai buscar todas as NFC-e ativas da table = PDV");
        return PDV::where('active', $active)->get();
    }

    public function store(array $data){
        Log::info("Buscando cliente da venda.");
        $customer = Customer::where('id', $data['customer_id'])->first();

        Log::info("Buscando usuário logado.");
        $user = User::where('id', $data['user_id'])->first();

        Log::info("Buscando espécie utilizada.");
        $paymentForm = Payment::where('id', $data['payment_id'])->first();

        if($customer && $user && $paymentForm){

            Log::info("Vai criar NFC-e.");
            $pdv = PDV::create([
                'cliente_id' => $customer->id,
                'cliente' => $customer->name,
                'valor_bruto' => $paymentForm->valor_bruto,
                'valor_liquido' => $paymentForm->valor_liquido,
                'valor_desconto' => $paymentForm->valor_desconto,
                'user_id' => $user->id,
                'user' => $user->name,
            ]);

            Log::info("Vai criar a forma de pagamento.");
            $payment = FormaPagamentoPDV::create([
                'cod_especie' => $paymentForm->id,
                'espécie' => $paymentForm->descricao,
                'valor_bruto' => $pdv->valor_bruto,
                'valor_liquido' => $pdv->valor_liquido,
                'valor_desconto' => $pdv->valor_desconto,
            ]);

            Log::info("Update do Nº documento venda.");
            $pdv->update([
                'documento' => $pdv->documento + 1,
                'descricao' => "VENDA NFC-E: $pdv->id",
            ]);

            Log::info("Update do Nº documento forma pagamento.");
            $payment->update([
                'documento' => $payment->documento + 1,
            ]);

            Log::info("Vai salvar!");
            $pdv->save();
            $payment->save();

        } else if (!$customer){
            return array('message' => 'Cliente não encontrado!');
        } else if (!$user){
            return array('message' => 'Usuário não encontrado!');
        } else if (!$paymentForm){
            return array('message' => 'Forma de pagamento não encontrada!');
        }

        if ($paymentForm->tipolancamento === 'CAIXA'){
            Log::info("Vai criar registro no caixa");
            $cashBox = $this->cashRegisterRepository->create([
                'cliente_id' => $customer->id,
                'cliente' => $customer->name,
                'especie_id' => $paymentForm->id,
                'especie' => $paymentForm->descricao,
                'valor_entrada' => $pdv->valor_liquido,
                'valor_saída' => 0,
                'user_id' => $user->id,
                'user' => $user->name,
            ], 201);
            
        } else if ($paymentForm->tipolancamento === 'RECEBER'){

            Log::info("Vai criar registro no receber");
            $receive = Receive::create([
                'cliente_id' => $customer->id,
                'cliente' => $customer->name,
                'especie_id' => $paymentForm->id,
                'especie' => $paymentForm->descricao,
                'valor_parcela' => $pdv->valor_liquido,
                'user_id' => $user->id,
                'user' => $user->name,

            ], 201);
        }

        if(isset($cashBox))
        {
            $cashBox?->update([
                'saldo_real' => $cashBox->valor_entrda - $cashBox->valor_saida
                
            ]);

            $cashBox->save();
        }

        Log::info("Update origem NFC-e ou NOTA MANUAL");
        if ($pdv->is_nfce_nm === 1){
            $pdv->update([
                'origem' => 'NFC-e',
            ], 200);
        } else if ($pdv->is_nfce_nm === 0){
            $pdv->update([
                'origem' => 'NOTA MANUAL',
            ], 200);
        }

        Log::info("Vai salvar!");
        $pdv->save();
    }

    public function update(array $data, int $id){
        Log::info("Buscando registro por ID");
        $pdv_id = PDV::where('id', $id)->update($data, $id);

        if ($pdv_id){
            Log::info("Registro atualizado com sucesso!");
            return response()->json([
                'success' => true,
                'message' => 'Registro atualizado com sucesso!',
            ], 200);
        } else {
            Log::info("NFC-e não encontrada.");
            return response()->json([
                'success' => false,
                'error' => 'Registro não encontrado.',
            ], 404);
        }
    }

    public function delete(int $id){
        Log::info("Iniciando exclusão do registro");
        $pdv = PDV::find($id);

        if (!$pdv){
            Log::info("Registro não encontrado.");
            return response()->json([
                'success' => false,
                'error' => 'Registro não encontrado.'
            ], 404);
        }

        $pdv->update(['active' => 0]);

        Log::info("Registro desativado!");
        return response()->json([
            'success' => true,
            'message' => 'Registro deletado com sucesso!',
        ], 200);
    }
}