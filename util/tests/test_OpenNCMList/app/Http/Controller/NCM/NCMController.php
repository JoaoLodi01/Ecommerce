<?php

namespace App\Http\Controller\NCM;

use App\Services\NCM\NCMsServices;

class NCMController
{
    public function __construct(
        protected NCMsServices $ncmsServices
    ){}

    public function getNCMs()
    {
        return $this->ncmsServices->getNCMs();
    }

}
