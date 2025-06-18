<?php

namespace App\Services\Exceptions;

class ExceptionsService
{
    public function insufficientPayment()
    {
        throw new \App\Exceptions\InsufficientPayment("Pagamento insuficiente");

    }
}