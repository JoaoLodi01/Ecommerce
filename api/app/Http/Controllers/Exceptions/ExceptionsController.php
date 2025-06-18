<?php

namespace App\Http\Controllers\Exceptions;

use App\Services\Exceptions\ExceptionsService;

class ExceptionsController
{
    public function __construct(
        private ExceptionsService $exceptionsService
    ) {}

    public function test()
    {
        //insufficientPayment
        return $this->exceptionsService->insufficientPayment();
    }

}