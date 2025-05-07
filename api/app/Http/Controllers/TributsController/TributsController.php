<?php

namespace App\Http\Controllers\TributsController;

use App\Http\Requests\NCM\NCMRequest;
use App\Services\TributsService\TributsServices;

class TributsController
{
    public function __construct(
        protected TributsServices $tributsServices
    ){}

    public function getAllNCMs(int $issuer_id)
    {
        return $this->tributsServices->getAllNCMs($issuer_id); 

    }

    public function searchNCM(NCMRequest $request)
    {
        $data = $request->validated();
        return $this->tributsServices->searchNCM($data);

    }
}