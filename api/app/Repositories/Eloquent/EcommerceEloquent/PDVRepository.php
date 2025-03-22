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

use App\Repositories\PayMentMethod;
use Illuminate\Support\Facades\Log;

class PDVRepository
{
    public function __construct(
        protected CustomerRepository $customerRepository,
        protected CashRegisterRepository $cashRegisterRepository,
        protected UserRepository $userRepository,
        protected ProductsRepository $productsRepository,
        protected PayMentMethod $payMentMethod,

    ){
        Log::info('Memória usada PDVRepository::class, __construct: ' . memory_get_usage(true));
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
        $productsIDs = array_column($productsArray, 'id');
        Log::info($productsIDs);
        
        for ($i=0; $i < count($productsIDs); $i++) { 
            Log::info('Memória usada PDVRepository::class, saveProducts dentro do for: ' . memory_get_usage(true));
            $products = $this->productsRepository->findByID($productsIDs[$i]);
            $itensPDV = array(
                'pdv_id' => $pdvID,
                'product_id' => $products->id,
                'product' => $products->produto,
                'cfop' => $products->cfop,
                'csosn' => $products->csosn,
                'ncm' => $products->ncm,
                'cest' => $products->cest,
                'unit' => $products->unit,
                'amount_sold' => $products['quantidade'],
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

        Log::info($this->payMentMethod->test());
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
    {/*
        $pdv = $this->findByID($id);
        $customer = $this->customerRepository->findByID($pdv->customer_id);
        //$customer->joinSales();
        $this->payMentMethod->payment(
            $paymentsValues, [1], $customer, $pdv->description, $type === 'nfce' ? "Venda NFC-e N° $id" : "Venda Nota Manual N° $id"
        );

        $pdv = PDV::where('id', $id)->first()->update([
            'description' => $type === 'nfce' ? "Venda NFC-e N° $id" : "Venda Nota Manual N° $id",
            'finished' => 1
        ]);*/        
    }
}