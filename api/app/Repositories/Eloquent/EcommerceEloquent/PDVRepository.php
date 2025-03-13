<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\{
    Receive,
    Customer

};

use App\Models\EcommerceModels\{
    PDV,
    FormaPagamentoPDV,
    ItensPDV,
    Payment,
    User,
    
};

use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;

use App\Repositories\Eloquent\{
    CustomerRepository,
    UserRepository
};

use Illuminate\Support\Facades\Log;

class PDVRepository
{
    public function __construct(
        protected CustomerRepository $customerRepository,
        protected CashRegisterRepository $cashRegisterRepository,
        protected UserRepository $userRepository
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
            // Precisa ajustar e melhorar
            Log::info("Vai criar NFC-e.");
            $pdv = PDV::create([
                'customer_id' => $customer->id,
                'customer' => $customer->name,
                'gross_value' => $paymentForm->valor_bruto,
                'net_value' => $paymentForm->valor_liquido,
                'discount' => $paymentForm->valor_desconto,
                'addition' => $paymentForm->valor_desconto,
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
            $cashBoxRegister = array(
                'cliente_id' => $customer->id,
                'cliente' => $customer->name,
                'especie_id' => $paymentForm->id,
                'especie' => $paymentForm->descricao,
                'valor_entrada' => $pdv->valor_liquido,
                'valor_saída' => 0,
                'user_id' => $user->id,
                'user' => $user->name,
            );
            
            $this->cashRegisterRepository->create($cashBoxRegister);

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

    public function saveProducts(array $productsArray, int $pdvID, object $user)
    {
        Log::info('-- Iniciou o saveProducts() line 167 -- ');
        foreach ($productsArray as $products) {
            Log::info('Entrou no primeiro for: (products)');
            Log::info($products);
            foreach ($products as $product) {
                Log::info('Entrou no segundo for: (product)');
                Log::info($product);
                $itensPDV = ItensPDV::create([
                    'pdv_id' => $pdvID,
                    'product_id' => $product['id'],
                    'product' => $product['produto'],
                    'amount_sold' => $product['quantidade'],
                    'addition' => 0,
                    'discount' => 0,
                    'user_id' => $user->id,
                    'user' => $user->name, 
    
                ]);
            }
            Log::info('ItensPDV ' . $itensPDV);
        }
    }

    public function saveSale(array $details, array $productsArray)
    {
        Log::info('-- Iniciou o saveSale() line 172 -- ');
        Log::info('Busca pelo customer');
        $customer = $this->customerRepository->findByID($details['customer_id']);
        Log::info('Busca pelo user');
        $user = $this->userRepository->findByID($details['user_id']); // "user"

        $pdv = PDV::create([
            'description' => $details['description'],
            'cliente_id' => $customer->id,
            'client' => $customer->name,
            'gross_value' => $details['sub_total'],
            'net_value' => $details['total'],
            'discount' => $details['discount'],
            'addition' => $details['addition'],
            'user_id' => $user->id,
            'user' => $user->name, 
            'is_nfce_nm' => $details['is_nfce_nm']
        ]);         

        if($pdv && $pdv->id)
        {
            $this->saveProducts($productsArray, $pdv->id, $user);
            return array(
                'success' => true,
                'pdv' => $pdv       

            );
        }
    }

    public function finalizeSale(array $data)
    {
        
    }
}