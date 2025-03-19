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
    
    public function findByID(int $id)
    {
        return PDV::where('id', $id)->first();
    }

    public function findSavePDV()
    {
        Log::info('Vai fazer a busca das vendas com campo: is_nfce_nm = null e canceled = 0');
        $pdvs = PDV::with('getItens')
                        ->where('is_nfce_nm', null)
                        ->get();

        return $pdvs;
    }

    public function findSavePDVByID(int $id)
    {
        Log::info('Vai fazer a busca das vendas com campo: is_nfce_nm = null e canceled = 0');
        $pdvs = PDV::with('getItens')
                        ->where('is_nfce_nm', null)
                        ->where('id', $id)
                        ->first();

        return $pdvs;
    }

    public function saveProducts(array $products, int $pdvID, object $user)
    {
        Log::info('-- Iniciou o saveProducts() line 167 -- ');     
        Log::info($products);
        Log::info('Memória usada PDVRepository::class, saveProducts: ' . memory_get_usage(true));
        Log::info('User: ' . $user);

        Log::info('$products 1' . count($products));
        Log::info($products);

        foreach ($products as $product) {
            Log::info('Memória usada PDVRepository::class, saveProducts dentro do foreach: ' . memory_get_usage(true));
            Log::info('$product');
            for ($i=0; $i < count($product); $i++) { 
                Log::info('Memória usada PDVRepository::class, saveProducts dentro do for: ' . memory_get_usage(true));
                Log::info('$product[$i]');
                Log::info($product[$i]);

                $itensPDV = array(
                    'pdv_id' => $pdvID,
                    'product_id' => $product[$i]['id'],
                    'product' => $product[$i]['product'],
                    'cost_price' => $product[$i]['cost_price'],
                    'sale_price' => $product[$i]['sale_price'],
                    'cfop' => $product[$i]['cfop'],
                    'csosn' => $product[$i]['csosn'],
                    'ncm' => $product[$i]['ncm'],
                    'cest' => $product[$i]['cest'],
                    'unit' => $product[$i]['unit'],
                    'amount' => $product[$i]['amount'],
                    'addition' => 0,
                    'discount' => 0,
                    'user_id' => $user->id,
                    'seller' => $user->name, 
    
                );
    
                Log::info('itensPDV ');
                Log::info($itensPDV);
                $ipdv = ItensPDV::create($itensPDV);
                Log::info('$ipdv');
                Log::info($ipdv);
            }
        }

        return;
    }

    public function saveSale(array $details, array $productsArray)
    {
        Log::info('-- Iniciou o saveSale() line 172 -- ');
        Log::info($details);
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

    public function finalizeSale(string $type, int $id, array $paymentsValues, array $forms, float $total)
    {
        Log::info('-- Iniciou o finalizeSale() line 172 -- ');
        Log::info('Memória usada PDVRepository::class, finalizeSale: ' . memory_get_usage(true));

        $pdv = $this->findByID($id);
        
        $customer = $this->customerRepository->findByID($pdv->cliente_id);

        Log::info('Vai procurar a(s) formas de pagamento');
        $formsPayment = $this->paymentsRepository->findByID($forms); // formsPayment - apenas as espécies
        Log::info('Vai conferir se o $total: R$ ' . $total . ' é maior que o $pdv->net_value, R$' . $pdv->net_value);
        if($total >= $pdv->net_value)
        {
            Log::info('Foi maior');
            
            $payMentMethodService = $this->payMentMethodService->payment($formsPayment, $paymentsValues, $customer, $pdv->is_nfce_nm === 'nfce' ? "Venda NFC-e N° $pdv->id" : "Venda Nota Manual N° $pdv->id", 'pdv', $pdv);

            if ($payMentMethodService['success'] === true) {
                Log::info('Pagamento bem sucessido, vai alterar o PDV: ' . $pdv);
                Log::info('$type ' . $type);
                $pdv->update([
                    'description' => $pdv->is_nfce_nm === 'nfce' ? "Venda NFC-e N° $pdv->id" : "Venda Nota Manual N° $pdv->id",
                    'is_nfce_nm' => $type === 'saleNM' ? 'nm' : 'nfce',
                    'finished' => 1
        
                ]);

                Log::info('Buscar e alterar os produtos, pdv_id = ' . $pdv->id);
                $products = ItensPDV::where('pdv_id', $pdv->id)->get();
        
                for ($i=0; $i < count($products); $i++) { 
                    Log::info('Alteração dentro do for = ' . $pdv->id);
                    $product = $products[$i];
                    $this->productsRepository->decreaseQuantiy($product->product_id, $product->amount);
                    $product->update([
                        'is_nfce_nm' => $pdv->is_nfce_nm,
                        'finished' => 1
                    ]);
                }

                //ord()
                return array(
                    'success' => true,
                    'message' => 'O pagamento foi efetuado com sucesso!',
                    'pdv' => $pdv
                
                );
            }
        } elseif ($total <  $pdv->net_value)
        {
            Log::info('Foi menor');
            return array(
                'success' => false,
                'errorMessage' => 'O valor pago é menor que o total líquido da compra!',
                'pdv' => $pdv
            
            );
            
        } else {
            Log::info('Falhou');
            return array(
                'success' => false,
                'message' => 'O pagamento falhou!',
                'pdv' => $pdv
            
            );

        }
    }
}