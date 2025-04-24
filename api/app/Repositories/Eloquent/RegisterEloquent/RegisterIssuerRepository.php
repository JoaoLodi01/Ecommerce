<?php 

namespace App\Repositories\Eloquent\RegisterEloquent;

use App\Models\Issuer;
use App\Repositories\Contracts\RegisterContract\RegisterIssuerContract;

class RegisterIssuerRepository implements RegisterIssuerContract
{
    public function create(array $data)
    {
        return Issuer::create($data);
        
    }

    public function find(int $id)
    {
        return Issuer::find('id', $id)->first();
    }

}