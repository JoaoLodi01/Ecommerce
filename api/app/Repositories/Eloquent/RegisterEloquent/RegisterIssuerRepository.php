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
        return Issuer::create([
            'name' => $data['name'],
            'cnpj' => $data['cnpj'],
            'cpf' => $data['cpf'],
            'address' => $data['address'],
            'number' => $data['number'],
            'cep' => $data['cep'],
            'owner_id' => $owner->id,
        ]);
        
    }

    public function find(int $id)
    {
        return Issuer::find('id', $id)->first();
    }

}