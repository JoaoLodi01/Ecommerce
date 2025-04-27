<?php 

namespace App\Repositories\Eloquent\RegisterEloquent;

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
                'address' => $data['address'],
                'number' => $data['number'],
                'cep' => $data['cep'],
                'owner_id' => $owner->id,
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
        return Issuer::find('id', $id)->first();
    }

    public function update(array $data, int $id)
    {
        $issuer = Issuer::where('id', $id)->first()->update($data);
        return $issuer;
        
    }
}