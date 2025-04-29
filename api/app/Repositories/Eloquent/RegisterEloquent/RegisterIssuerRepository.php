<?php 

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\ConfigPDV;
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