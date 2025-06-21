<?php

namespace App\Http\Controllers\Exceptions;

class ExceptionsController
{
    public function test()
    {
        throw new \App\Exceptions\PDVExceptions\InsufficientPayment("grana curta");

    }
}