<?php 

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\EcommerceModels\{
    PaymentForms,
    ConfigPDV
};

use App\Models\Registers\{
    Issuer,
    FirstSteps
};

use App\Models\Customer;
use App\Models\ConfigCustomers;
use App\Models\ConfigProducts;
use App\Models\SiteColors;
use App\Repositories\Contracts\RegisterContract\RegisterIssuerContract;
use App\Services\GetIBGECod\GetIBGECodService;
use App\Services\NFCeValidation\FindTributs;
use Illuminate\Support\Facades\Log;
use App\Services\TributsService\TributsServices;
use App\Models\Registers\User;

class RegisterIssuerRepository implements RegisterIssuerContract
{
    public function __construct(
        protected TributsServices $tributsServices,
        protected FindTributs $findTributs,
        protected GetIBGECodService $getIBGECodService
    ) {
        Log::info('Memória usada no RegisterIssuerRepository ' . memory_get_usage(true));
    }

    public function getAll(string $ownerID)
    {
        Log::info("$ownerID");
        $owner = User::where('uuse_id', $ownerID)->first();
        return Issuer::where('user_code', $owner->id)->get();
        
    }

    public function create(array $data)
    {        
        $owner = User::where('uuse_id', $data['uuse_id'])->first();
        
        if($owner)
        {
            $issuer = Issuer::create([
                'company_name' => $data['company_name'],
                'trade_name' => $data['trade_name'],
                'cnpj' => $data['cnpj'] ? preg_replace('/[^a-zA-Z0-9]/', '', $data['cnpj']) : null,
                'cpf' => $data['cpf'] ? preg_replace('/[^a-zA-Z0-9]/', '', $data['cpf']) : null,
                'date_of_foundation' => $data['date_of_foundation'],
                'cod_cnae' => $data['cod_cnae'],
                'cnae' => $data['main_activity'],
                'user_code' => $owner->id,
            ]);

            Log::info('--- Criação das espécies padrão ---');
            $this->registerPayMentsForms($issuer->id);
            Log::info('--- Fim da criação das espécies padrão ---');
            
            Log::info('--- Criação do cliente padrão ---');

            $maxCustomerCod = Customer::where('issuer_id', $issuer->id)->max('customer_cod');

            $codCustomer = $maxCustomerCod ? $maxCustomerCod + 1 : 1;
            
            $customer = Customer::create([
                'customer_cod' => $codCustomer,
                'issuer_id' => $issuer->id,
                'company_name' => 'Consumidor Padrão',
                'customer_type' => 'Física',
                'cpf' => null,
                'cnpj' => null
                
            ]);
            Log::info($customer);
            Log::info('--- Fim da criação do cliente padrão ---');

            Log::info('--- Criação das configPDV padrão ---');
            $configPDVCod = ConfigPDV::where('issuer_id', $issuer->id)->max('config_pdv_cod');
            ConfigPDV::create([
                'config_pdv_cod' => $configPDVCod ? $configPDVCod + 1 : 1,
                'issuer_id' => $issuer->id,
                'filter_search' => 'Cód barras interno',
                'filter_search_customer' => 'Padrão (cód.cliente ou nome)'
            ]);
            
            Log::info('--- Fim da criação do configPDV padrão ---');

            Log::info('--- Criação das configCustomer padrão ---');
            $maxCod = ConfigCustomers::where('issuer_id')->max('config_customer_cod');
        
            ConfigCustomers::create([
                'issuer_id' => $issuer->id,
                'config_customer_cod' => $maxCod ? $maxCod + 1 : 1,
                'validate_cnpj' => false,
                'validate_cpf' => false,
                'validate_addres' => false,
                'last_filter' => 'all',

            ]);

            Log::info('--- Fim da criação do configCustomer padrão ---');

            Log::info('--- Criação das configProducts padrão ---');
                $maxCode = ConfigProducts::where('issuer_id')->max('config_product_code');
                ConfigProducts::create([
                    'issuer_id' => $issuer->id,
                    'config_product_code' => $maxCode ? $maxCode + 1 : 1,
                ]);

            Log::info('--- Fim da criação do configProducts padrão ---');

            Log::info('--- Criação das cores padrão ---');
            $maxCod = SiteColors::where('issuer_id')->max('color_cod');
        
            SiteColors::create([
                'issuer_id' => $issuer->id,
                'color_cod' => $maxCod ? $maxCod + 1 : 1
            ]);

            Log::info('--- Fim da criação das cores padrão ---');

            Log::info('--- Criação das primeros passos padrão ---');
            
            FirstSteps::create([
                'issuer_id' => $issuer->id  
            ]);

            Log::info('--- fim da criação dos primeros passos ---');

            return array(
                'success' => true,
                'issuer' => $issuer
            );

        } else if (empty($owner))
        {
            return array(
                'success' => false,
                'message' => 'Proprietário não cadastrado'
            );
        }   
    }

    public function find(int $id)
    {
        return Issuer::where('id', $id)->first();
    }

    public function update(array $data, int $id)
    {
        $issuer = Issuer::where('id', $id)->first();
        $firstSteps = FirstSteps::where('issuer_id', $issuer->id)->first();

        $ibge = $this->getIBGECodService->getData($data['city']);

        $issuer->update([
            'cep' => preg_replace('/[^a-zA-Z0-9]/', '', $data['cep']),
            'uf' => $data['uf'],
            'cod_ibge' => $data['cod_ibge'] ?? $ibge, 
            'city' => $data['city'],
            'address' => $data['address'],
            'number' => $data['number'],
            'cod_crt' => $data['cod_crt'],
            'crt' => $data['crt'],
            'cod_cnae' => $data['cod_cnae'],
            'cnae' => $data['cnae'],
            'main_activity' => $data['cnae'],
            'ie' => $data['ie'],
            'im' => $data['im'],            

        ]);

        $issuer->save();

        if(!$firstSteps->complete_issuer)
        {
            Log::info('- Vai criar o NCM - ');
            $this->tributsServices->createNCM($issuer->id, $issuer->uf);
        }

        $firstSteps->update([
            'complete_issuer' => 1
        ]);
        
        $firstSteps->save();

        $csosncst = '';
        Log::info('Emitente é: ' . $issuer->crt, ' CRT: ' . $issuer->cod_crt);
        if($issuer->cod_crt && $issuer->cod_crt > 0)
        {
            $crt = $issuer->cod_crt;
            if($crt == 1 || $crt >= 4)
            {
                $csosncst = '000';
            } else {
                $csosncst = '00';

            }
        }
        Log::info('csosncst é: ' . $csosncst);
        $this->registerTributs($issuer->id, $csosncst);

        return $issuer;
        
    }

    public function disableCompany(int $issuerID)
    {
        $company = Issuer::where('id', $issuerID)->first();
        if(!$company)
        {
            //throw new 

        }

        $company->update([
            'active' => 0

        ]);

        return $company;
    }
    
    public function activeCompany(int $issuerID)
    {
        $company = Issuer::where('id', $issuerID)->first();
        if(!$company)
        {
            //throw new 

        }

        $company->update([
            'active' => 1

        ]);

        return $company;
    }

    public function registerTributs(int $issuerID, string $csosncst)
    {
        Log::info('Vai criar os CFOPs');
        $cfops = $this->findTributs->getCFOPs('cfop');
        $csosncst = $this->findTributs->getCSOSNCST($csosncst);

        $this->tributsServices->registerCFOP($cfops, $issuerID);

    }

    public function registerPayMentsForms(int $issuerID)
    {
        $payments = [
            [
                'payment_cod' => 1,
                'issuer_id' => $issuerID,
                'especie' => 'Dinheiro',
                'tipo_lancamento' => 'Caixa',
                'payments_form_type' => 'DINHEIRO'
            ],
            [
                'payment_cod' => 2,
                'issuer_id' => $issuerID,
                'especie' => 'PIX',
                'tipo_lancamento' => 'Caixa',
                'payments_form_type' => 'PIX'

            ],
            [
                'payment_cod' => 3,
                'issuer_id' => $issuerID,
                'especie' => 'Boleto',
                'tipo_lancamento' => 'Receber',
                'payments_form_type' => 'BOLETO'
            ],
            [
                'payment_cod' => 4,
                'issuer_id' => $issuerID,
                'especie' => 'Cartão de Crédito',
                'tipo_lancamento' => 'Caixa',
                'payments_form_type' => 'CARTAO DE CREDITO'
            ],
            [
                'payment_cod' => 5,
                'issuer_id' => $issuerID,
                'especie' => 'Cartão de Débito',
                'tipo_lancamento' => 'Receber',
                'payments_form_type' => 'CARTAO DE DEBITO'
            ],
            
        ];
    
        foreach($payments as $payment){
            PaymentForms::create($payment);
        }
    }
}