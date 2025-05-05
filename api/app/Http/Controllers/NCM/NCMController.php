<?php

namespace App\Http\Controllers\NCM;

use App\Http\Requests\NCM\NCMRequest;
use App\Services\NCM\NCMsServices;

class NCMController
{
    public function __construct(
        protected NCMsServices $ncmServices
    ){}

    public function getAllNCMs(int $issuer_id)
    {
        return $this->ncmServices->getAllNCMs($issuer_id); 

    }

    public function searchNCM(NCMRequest $request)
    {
        $data = $request->validated();
        return $this->ncmServices->searchNCM($data);

    }
}