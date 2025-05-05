<?php

namespace App\Http\Controllers\NCM;

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

}