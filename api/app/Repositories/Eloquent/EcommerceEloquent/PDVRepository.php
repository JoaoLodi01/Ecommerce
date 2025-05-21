<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;
setlocale(LC_TIME, 'ptb');

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

use App\Services\NFCeValidation\NFCeValidation;
use Carbon\Carbon;

class PDVRepository
{
    public function __construct(
        protected CustomerRepository $customerRepository,
        protected CashRegisterRepository $cashRegisterRepository,
        protected UserRepository $userRepository,
        protected ProductsRepository $productsRepository,
        protected PayMentMethodService $payMentMethodService,
        protected PaymentsRepository $paymentsRepository,
        protected NFCeValidation $nfceValidation

    ){
        Log::info('Memória usada PDVRepository::class, __construct, linha 31: ' . memory_get_usage(true));
    }

    public function getAll(int $issuer_id){
        Log::info("Vai buscar todas as NFC-e ativas da table = PDV");
        return PDV::where('issuer_id', $issuer_id)->get();
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
    
    public function findByID(int $id, int $issuerID)
    {
        $pdv = PDV::where('pdv_cod', $id)
                    ->where(function($q) use ($issuerID){
                        $q->where('issuer_id', $issuerID);
                    })            
                    ->first();

        Log::info('PDV pelo issuer_ud', ['pdv' => $pdv]);
        return $pdv;
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
                        ->where('pdv_cod', $id)

                        ->first();

        return $pdvs;
    }

    public function saveProducts(array $products, int $pdvID, object $user, string|null $type)
    {
        Log::info('-- Iniciou o saveProducts() line 90 -- ');     
        $errors = [];
        foreach ($products as $product) {
            for ($i=0; $i < count($product); $i++) { 
                $maxItensPDV = ItensPDV::where('issuer_id', $product[$i]['issuer_id'])->max('iten_pdv_cod');
                $itensPDV = array(
                    'iten_pdv_cod' => $maxItensPDV ? $maxItensPDV + 1 : 1,
                    'issuer_id' => $product[$i]['issuer_id'],
                    'pdv_cod' => $pdvID,
                    'product_cod' => $product[$i]['product_cod'],
                    'product' => $product[$i]['product'],
                    'cost_price' => $product[$i]['cost_price'],
                    'sale_price' => $product[$i]['sale_price'],
                    'cfop' => $product[$i]['cfop'],
                    'csosncst' => $product[$i]['csosncst'],
                    'ncm' => $product[$i]['ncm'],
                    'cest' => $product[$i]['cest'],
                    'unit' => $product[$i]['unit'],
                    'amount' => $product[$i]['amount'],
                    'addition' => 0,
                    'discount' => 0,
                    'user_id' => $user->id,
                    'seller' => $user->name, 
    
                );

                if($type === 'nfce')
                {
                    $nfceValidationRes = $this->nfceValidation->validation($itensPDV);
                    Log::info('$nfceValidationRes = $this->nfceValidation->validation($itensPDV);', ['nfceValidation' => $nfceValidationRes]);

                    if($nfceValidationRes['cfopValidate'] && $nfceValidationRes['csosnValidate'])
                    {
                        Log::info('CFOP e CSOSN/CST válidos');
                        
                    } else if (!$nfceValidationRes['cfopValidate'])
                    {
                        Log::info('CFOP inválido, item: ');
                        array_push($errors, $nfceValidationRes['errors']);

                    } else if (!$nfceValidationRes['csosnValidate'])
                    {
                        Log::info('CSOSN / CST inválido');
                        array_push($errors, $nfceValidationRes['errors']);

                    } else {
                        Log::info('CFOP e CSOSN/CST inválidos');
                        array_push($errors, $nfceValidationRes['errors']);

                    }
                }
            
                ItensPDV::create($itensPDV);
                
            }
        }
        return array(
            'errors' => $errors
        );
    }

    public function saveSale(array $details, array $productsArray)
    {
        Log::info('-- Iniciou o saveSale() line 172 -- ');
        Log::info($details);

        $customer = $this->customerRepository->findByID($details['customer_id']);
        Log::info('customer => ' . $customer);
        $customerName = $customer->company_name ? $customer->company_name : $customer->trade_name;
        Log::info('customerName => ' . $customerName);

        $user = $this->userRepository->findByID($details['user_id']); // "user"

        $currentDate = new Carbon();
        $maxPDV = PDV::where('issuer_id', $details['issuer_id'])->max('pdv_cod');
        $pdvData = array(
            'pdv_cod' => $maxPDV ? $maxPDV + 1 : 1,
            'issuer_id' => $details['issuer_id'],
            'description' => $details['description'],
            'issue_date' => $currentDate->format('Y-m-d'),
            'customer_id' => $customer->customer_cod,
            'customer' => $customerName,
            'gross_value' => $details['sub_total'],
            'net_value' => $details['total'],
            'addition' => $details['addition'],
            'discount' => $details['discount'],
            'user_id' => $user->id,
            'user' => $user->name, 
            'is_nfce_nm' => $details['is_nfce_nm']
        );

        Log::info('pdvData: ');
        Log::info($pdvData);
        
        $pdv = PDV::create($pdvData);  

        if($pdv && $pdv->id && $pdv->pdv_cod)
        {            
            $iPDV = $this->saveProducts($productsArray, $pdv->pdv_cod, $user, $details['is_nfce_nm']);
            Log::info('$iPDV');
            Log::info(count($iPDV['errors']));

            if(count($iPDV['errors']) === 0)
            {
                return array(
                    'success' => true,
                    'pdvID' => $pdv->pdv_cod,

                );
            } else {
                return array(
                    'success' => false,
                    'message' => 'Erro no produto',
                    'pdvID' => $pdv->pdv_cod,
                    'errors' => $iPDV['errors']

                );
            }   
        } else {
            return array(
                'success' => false,
                'pdv' => $pdv,
                'pdv_id' => $pdv->id,
                'pdv_cod' => $pdv->pdv_cod
            );
        }
        
    }

    public function finalizeSale(string $type, int $id, array $paymentsValues, array $forms, float $total, int $issuerID)
    {
        Log::info('-- Iniciou o finalizeSale() line 172 -- ');
        Log::info('Memória usada PDVRepository::class, finalizeSale: ' . memory_get_usage(true));

        $pdv = $this->findByID($id, $issuerID);
        
        $customer = $this->customerRepository->findByID($pdv->customer_id);
        Log::info('Customer => ' . $customer);

        Log::info('Vai procurar a(s) formas de pagamento');
        $formsPayment = $this->paymentsRepository->findByID($forms); // formsPayment - apenas as espécies
        Log::info('Vai conferir se o $total: R$ ' . $total . ' é maior que o $pdv->net_value, R$' . $pdv->net_value);

        if($total >= $pdv->net_value)
        {
            Log::info('Foi maior');
            Log::info('Tipo de venda NM/NFCE: ' . $pdv->is_nfce_nm);
            Log::info('Issuer ID: ' . $issuerID);
            
            $payMentMethodService = $this->payMentMethodService->payment($formsPayment, $paymentsValues, $customer, $pdv->is_nfce_nm, 'pdv', $pdv, $issuerID);
            Log::info('payMentMethodService');
            Log::info($payMentMethodService);

            if ($payMentMethodService['success'] === true) {
                Log::info('Pagamento bem sucessido, vai alterar o PDV: ' . $pdv);
                Log::info('$type ' . $type);

                $pdv->update([
                    'description' => $pdv->is_nfce_nm === 'nfce' ? "Venda NFC-e N° $pdv->pdv_cod" : "Venda Nota Manual N° $pdv->pdv_cod",
                    'is_nfce_nm' => $type === 'saleNM' ? 'nm' : 'nfce',
                    'status' => $type === 'saleNM' ? 'Venda Finalizada' : 'Autorizado uso da NF-e',
                    'finished' => 1
        
                ]);

                Log::info('Buscar e alterar os produtos, pdv_cod = ' . $pdv->pdv_cod);
                $products = ItensPDV::where('pdv_cod', $pdv->pdv_cod)->get();
        
                for ($i=0; $i < count($products); $i++) { 
                    Log::info('Alteração dentro do for = ' . $pdv->pdv_cod);
                    $product = $products[$i];
                    $this->productsRepository->decreaseQuantiy($product->product_cod, $product->amount);
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
        } elseif ($total < $pdv->net_value)
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

    public function incrementNFCe(int $id)
    {
        $lastPDV = PDV::where('id', $id)->latest('id')->first();

    }
}