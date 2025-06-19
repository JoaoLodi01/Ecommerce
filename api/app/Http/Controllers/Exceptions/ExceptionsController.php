<?php

namespace App\Http\Controllers\Exceptions;

class ExceptionsController
{
    public function test()
    {
        throw new \App\Exceptions\InsufficientPayment("grana curta");

    }
}