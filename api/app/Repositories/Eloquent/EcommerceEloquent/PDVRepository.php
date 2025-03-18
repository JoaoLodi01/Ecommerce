<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\{
    PDV,
    ItensPDV,
    
};

use App\Repositories\Eloquent\EcommerceEloquent\CashRegisterRepository;

use App\Repositories\Eloquent\{
    CustomerRepository,
    UserRepository
};

use App\Services\PayMentMethodService;
use Illuminate\Support\Facades\Log;

class PDVRepository
{
    public function __construct(
        protected CustomerRepository $customerRepository,
        protected CashRegisterRepository $cashRegisterRepository,
        protected UserRepository $userRepository,
        protected ProductsRepository $productsRepository,
        protected PayMentMethodService $payMentMethodService,
        protected PaymentsRepository $paymentsRepository

    ){
        Log::info('Memória usada PDVRepository::class, __construct, linha 31: ' . memory_get_usage(true));
    }

    public function getAll(){
        Log::info("Vai buscar todas as NFC-e ativas da table = PDV");
        return PDV::paginate(10);
    }

    public function update(array $data, int $id){
        Log::info("Buscando registro por ID");
        $pdvID = PDV::where('id', $id)->update($data, $id);

        if ($pdvID){
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
        Log::info('Memória usada PDVRepository::class, saveProducts: ' . memory_get_usage(true));
        Log::info('User: ' . $user);

        Log::info('$productsArray 1' . count($productsArray));
        Log::info($productsArray);

        for ($i=0; $i < count($productsArray); $i++) { 
            Log::info('Memória usada PDVRepository::class, saveProducts dentro do for: ' . memory_get_usage(true));
            Log::info("i = $i");
            Log::info('$productsArray[$i]');
            Log::info($productsArray[$i]);
            $products = $productsArray[$i];

            $product = $this->productsRepository->findByID($products[$i]['id']);
            if($product)
            {
                $itensPDV = array(
                    'pdv_id' => $pdvID,
                    'product_id' => $product->id,
                    'product' => $product->produto,
                    'cfop' => $product->cfop,
                    'csosn' => $product->csosn,
                    'ncm' => $product->ncm,
                    'cest' => $product->cest,
                    'unit' => $product->unit,
                    'amount_sold' => $products[$i]['quantidade'],
                    'addition' => 0,
                    'discount' => 0,
                    'user_id' => $user->id,
                    'seller' => $user->name, 
    
                );

                Log::info('itensPDV ');
                Log::info($itensPDV);
                ItensPDV::create($itensPDV);
              
            }
        }
        return;
    }

    public function saveSale(array $details, array $productsArray)
    {
        Log::info('-- Iniciou o saveSale() line 172 -- ');
        Log::info('Memória usada PDVRepository::class, saveSale: ' . memory_get_usage(true));
        Log::info('Busca pelo customer');
        $customer = $this->customerRepository->findByID($details['customer_id']);
        Log::info('Busca pelo user');
        $user = $this->userRepository->findByID($details['user_id']); // "user"
        Log::info($user);

        $pdvData = array(
            'description' => $details['description'],
            'cliente_id' => $customer->id,
            'client' => $customer->name,
            'gross_value' => $details['sub_total'],
            'net_value' => $details['total'],
            'addition' => $details['addition'],
            'discount' => $details['discount'],
            'user_id' => $user->id,
            'user' => $user->name, 
            'is_nfce_nm' => $details['is_nfce_nm']
        );

        Log::info($pdvData);
        
        $pdv = PDV::create($pdvData);  

        if($pdv && $pdv->id)
        {            
            $this->saveProducts($productsArray, $pdv->id, $user);
            return array(
                'success' => true,
                'pdvID' => $pdv->id

            );
        }
    }

    public function findByID(int $id)
    {
        return PDV::where('id', $id)->first();
    }

    public function finalizeSale(string $type, int $id, array $paymentsValues, array $forms, float $total)
    {
        Log::info('-- Iniciou o finalizeSale() line 172 -- ');
        Log::info('Memória usada PDVRepository::class, finalizeSale: ' . memory_get_usage(true));

        $pdv = $this->findByID($id);
        
        $customer = $this->customerRepository->findByID($pdv->cliente_id);

        Log::info('Vai procurar a(s) formas de pagamento');
        $formsPayment = $this->paymentsRepository->findByID($forms); // formsPayment - apenas as espécies
        Log::info('$pdv->is_nfce_nm');
        Log::info($pdv->is_nfce_nm);
        $payMentMethodService = $this->payMentMethodService->payment($formsPayment, $paymentsValues, $customer, $pdv->is_nfce_nm === 'nfce' ? "Venda NFC-e N° $pdv->id" : "Venda Nota Manual N° $pdv->id", 'pdv', $pdv);

        if ($payMentMethodService['success'] === true) {
            Log::info('Pagamento bem sucessido, vai alterar o PDV: ' . $pdv);
            $pdv->update([
                'description' => $pdv->is_nfce_nm === 'nfce' ? "Venda NFC-e N° $pdv->id" : "Venda Nota Manual N° $pdv->id",
                'finished' => 1
    
            ]);

            Log::info('Buscar e alterar os produtos, pdv_id = ' . $pdv->id);
            $products = ItensPDV::where('pdv_id', $pdv->id)->get();
    
            for ($i=0; $i < count($products); $i++) { 
                $product = $products[$i];
                $this->productsRepository->decreaseQuantiy($product->product_id, $product->amount_sold);

            }

            //ord()
            Log::info('Memória usada PDVRepository::class, finalizeSale após update: ' . memory_get_usage(true));

            return array(
                'success' => true,
                'message' => 'O pagamento foi efetuado com sucesso!',
                'pdv' => $pdv
            
            );

        }
        return array(
            'success' => false,
            'message' => 'O pagamento falhou!',
            'pdv' => $pdv
        
        );
    }
}