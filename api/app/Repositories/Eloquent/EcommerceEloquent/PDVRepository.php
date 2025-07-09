<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;
setlocale(LC_TIME, 'ptb');

use App\Models\EcommerceModels\{
    PDV,
    ItensPDV,
    Products,
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

    ){}

    public function getAll(int $issuer_id){
        Log::channel('pdv')->info("Vai buscar todas as NFC-e ativas da table = PDV");
        return PDV::where('issuer_id', $issuer_id)->get();
    }

    public function update(array $data, int $id){ }
    
    public function findByID(int $id, int $issuerID)
    {
        $pdv = PDV::where('pdv_cod', $id)
                    ->where(function($q) use ($issuerID){
                        $q->where('issuer_id', $issuerID);
                    })            
                    ->first();

        Log::channel('pdv')->info('PDV pelo issuer_ud', ['pdv' => $pdv]);
        return $pdv;
    }

    public function findSavePDV()
    {
        Log::channel('pdv')->info('Vai fazer a busca das vendas com campo: is_nfce_nm = null e canceled = 0');
        $pdvs = PDV::with('getItens')
                        ->where('is_nfce_nm', null)
                        ->get();

        return $pdvs;
    }

    public function findSavePDVByID(int $id, int $issuerID)
    {
        Log::channel('pdv')->info('Vai fazer a busca das vendas com campo: is_nfce_nm = null e canceled = 0');
        $pdvs = PDV::with('getItens')
                        ->where('pdv_cod', $id)
                        ->where('issuer_id', $issuerID)
                        ->first();

        return $pdvs;
    }

    public function saveProducts(array $products, int $pdvID, object $user, string|null $type)
    {
        Log::channel('pdv')->info('-- Iniciou o saveProducts() line 90 -- ');     
        $errors = [];

        for ($i=0; $i < count($products); $i++) { 
            Log::channel('pdv')->debug($products[$i]);

            $product = Products::where('product_cod', $products[$i]['product_cod'])->first();

            $maxItensPDV = ItensPDV::where('issuer_id', $product->issuer_id)->max('iten_pdv_cod');
            $itensPDV = array(
                'iten_pdv_cod' => $maxItensPDV ? $maxItensPDV + 1 : 1,
                'issuer_id' => $product->issuer_id,
                'pdv_cod' => $pdvID,
                'product_cod' => $products[$i]['product_cod'],
                'product' => $products[$i]['product'],
                'cost_price' => $product->cost_price,
                'sale_price' => $products[$i]['sale_price'],
                'cfop' => $products[$i]['cfop'],
                'csosncst' => $products[$i]['csosncst'],
                'ncm' => $product->ncm,
                'cest' => $product->cest,
                'unit' => $product->unit,
                'amount' => $products[$i]['amount'],
                'addition' => 0,
                'discount' => 0,
                'user_id' => $user->id,
                'seller' => $user->name
                
            );

            if($type === 'nfce')
            {
                $nfceValidationRes = $this->nfceValidation->validation($itensPDV);
                Log::channel('pdv')->info('$nfceValidationRes = $this->nfceValidation->validation($itensPDV);', ['nfceValidation' => $nfceValidationRes]);

                if($nfceValidationRes['cfopValidate'] && $nfceValidationRes['csosnValidate'])
                {
                    Log::channel('pdv')->info('CFOP e CSOSN/CST válidos');
                    
                } else if (!$nfceValidationRes['cfopValidate'])
                {
                    Log::channel('pdv')->info('CFOP inválido, item: ');
                    array_push($errors, $nfceValidationRes['errors']);

                } else if (!$nfceValidationRes['csosnValidate'])
                {
                    Log::channel('pdv')->info('CSOSN / CST inválido');
                    array_push($errors, $nfceValidationRes['errors']);

                } else {
                    Log::channel('pdv')->info('CFOP e CSOSN/CST inválidos');
                    array_push($errors, $nfceValidationRes['errors']);

                }
            }

            ItensPDV::create($itensPDV);
            
        }
        return array(
            'errors' => $errors
        );
    }

    public function saveSale(
        array $details, 
        array $productsArray
        )
    {
        Log::channel('pdv')->info('-- Iniciou o saveSale() line 172 -- ');
    
        $customer = $this->customerRepository->findByID($details['customer_id']);
        
        $customerName = $customer->company_name ? $customer->company_name : $customer->trade_name;
        
        $user = $this->userRepository->findByID($details['user_id']); // "vendedor"

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

        Log::channel('pdv')->info('pdvData: ');
        Log::info($pdvData);
        
        $pdv = PDV::create($pdvData);  

        if($pdv && $pdv->id && $pdv->pdv_cod)
        {            
            $iPDV = $this->saveProducts($productsArray, $pdv->pdv_cod, $user, $details['is_nfce_nm']);
           
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

    public function finalizeSale(
            string $type, 
            int $id, 
            array $paymentsValues, 
            array $payMentsID, 
            float $total, 
            int $issuerID, 
            int $userID
        )   
    {
        Log::channel('pdv')->info('-- Iniciou o finalizeSale() line 222 -- ');
        Log::channel('pdv')->info('Memória usada PDVRepository::class, finalizeSale: ' . memory_get_usage(true));        

        $pdv = $this->findByID($id, $issuerID);
        
        $customer = $this->customerRepository->findByID($pdv->customer_id);
        
        Log::channel('pdv')->info('Vai procurar a(s) formas de pagamento');

        $payMentsForms = $this->paymentsRepository->findByID($payMentsID); // formsPayment - apenas as espécies

        Log::channel('pdv')->debug('Formas de pagamento: ', $payMentsForms);
        Log::channel('pdv')->info('Tipo de venda NM/NFCE: ' . $pdv->is_nfce_nm);
        
        $payMentMethodService = $this->payMentMethodService->payment(
            $payMentsForms, // Formas de pagamento
            $paymentsValues, // Valores pagos
            $customer, // Cliente da nota
            $pdv->is_nfce_nm, // Tipo de venda
            'pdv', // Origem
            $pdv, // Corpo do PDV
            $issuerID, // ID do emitente
            $userID // Usuário que fez a venda
            
        );
        
        return;

        if ($payMentMethodService['success'] === true) {
            Log::channel('pdv')->info('Pagamento bem sucessido, vai alterar o PDV: ' . $pdv);
            Log::channel('pdv')->info('$type ' . $type);
            Log::channel('pdv')->info('Tipo de venda: NFC-e/NM' . $pdv->is_nfce_nm);

            $pdv->update([
                'description' => $pdv->is_nfce_nm === 'nfce' ? "Venda NFC-e N° $pdv->pdv_cod" : "Venda Nota Manual N° $pdv->pdv_cod",
                'is_nfce_nm' => $pdv->is_nfce_nm,
                'status' => $pdv->is_nfce_nm === 'nfce' ? 'Autorizado uso da NF-e' : 'Venda Finalizada',
                'finished' => 1
    
            ]);

            Log::channel('pdv')->info('Buscar e alterar os produtos, pdv_cod = ' . $pdv->pdv_cod);
            $products = ItensPDV::where('pdv_cod', $pdv->pdv_cod)->get();
    
            for ($i=0; $i < count($products); $i++) { 
                Log::channel('pdv')->info('Alteração dentro do for = ' . $pdv->pdv_cod);
                $product = $products[$i];
                $this->productsRepository->decreaseQuantiy($product->product_cod, $product->amount);
                $product->update([
                    'is_nfce_nm' => $pdv->is_nfce_nm,
                    'finished' => 1
                ]);
            }
            //ord()

            return 'Pagamento bem sucedido!';
        }
    }

    public function incrementNFCe(int $id)
    {
        $lastPDV = PDV::where('id', $id)->latest('id')->first();

    }
}