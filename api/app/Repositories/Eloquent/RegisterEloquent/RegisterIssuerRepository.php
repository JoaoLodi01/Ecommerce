<?php 

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\ConfigPDV;
use App\Models\Customer;
use App\Models\EcommerceModels\Payment;
use App\Models\FirstSteps;
use App\Models\Issuer;
use App\Models\Owner;
use App\Repositories\Contracts\RegisterContract\RegisterIssuerContract;
use Illuminate\Support\Facades\Log;

class RegisterIssuerRepository implements RegisterIssuerContract
{
    public function getAll(string $ownerID)
    {
        $owner = Owner::where('uuse_id', $ownerID)->first();
        return Issuer::where('owner_id', $owner->id)->get();
    }

    public function create(array $data)
    {
        Log::info($data);
        Log::info($data['uuse_id']);
        $owner = Owner::where('uuse_id', $data['uuse_id'])->first();
        Log::info('$owner ' . $owner);
        if($owner)
        {
            $issuer = Issuer::create([
                'company_name' => $data['company_name'],
                'trade_name' => $data['trade_name'],
                'cnpj' => $data['cnpj'],
                'cpf' => $data['cpf'],
                'date_of_foundation' => $data['date_of_foundation'],
                'main_activity' => $data['main_activity'],
                'owner_id' => $owner->id,
            ]);

            $maxCustomerCod = Customer::where('issuer_id', $issuer->id)->max('customer_cod');

            $codCustomer = $maxCustomerCod ? $maxCustomerCod + 1 : 1;

            $payments = [
                [
                    'payment_cod' => 1,
                    'issuer_id' => $issuer->id,
                    'especie' => 'Dinheiro',
                    'tipo_lancamento' => 'Caixa',
                ],
                [
                    'payment_cod' => 2,
                    'issuer_id' => $issuer->id,
                    'especie' => 'PIX',
                    'tipo_lancamento' => 'Caixa',
                ],
                [
                    'payment_cod' => 3,
                    'issuer_id' => $issuer->id,
                    'especie' => 'Boleto',
                    'tipo_lancamento' => 'Receber',
                ],
                [
                    'payment_cod' => 4,
                    'issuer_id' => $issuer->id,
                    'especie' => 'Cartão de Crédito',
                    'tipo_lancamento' => 'Caixa',
                ],
                [
                    'payment_cod' => 5,
                    'issuer_id' => $issuer->id,
                    'especie' => 'Cartão de Débito',
                    'tipo_lancamento' => 'Receber',
                ],
                
            ];
    
            foreach($payments as $payment){
                Payment::create($payment);
            }


            Customer::create([
                'customer_cod' => $codCustomer,
                'issuer_id' => $issuer->id,
                'name' => 'Consumidor Padrão'
            ]);

            ConfigPDV::create([
                'issuer_id' => $issuer->id,
                'filter_search' => 'Cód barras interno',
                'filter_search_customer' => 'Padrão (cód.cliente ou nome)'
            ]);

            FirstSteps::create([
                'issuer_id' => $issuer->id
            ]);

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
        Log::infO('$firstSteps ' . $firstSteps);
        $issuer->update([
            'cep' => $data['cep'],
            'uf' => $data['uf'],
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

        $firstSteps->update([
            'complete_issuer' => 1
        ]);

        $firstSteps->save();

        return $issuer;
        
    }
}