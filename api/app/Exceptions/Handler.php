<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Support\Facades\Log;
use Throwable;
class Handler extends ExceptionHandler
{
    public function render($request, Throwable $e)
    {
        if ($e instanceof \App\Exceptions\PDVExceptions\InsufficientPayment) {
            return apiError($e->getMessage(), [], false, 400);

        }

        if($e instanceof \App\Exceptions\CustomersExceptions\CustomerNotFound)
        {
            return apiError($e->getMessage(), [], false, 400);
            
        }

        if($e instanceof \App\Exceptions\ProductsExceptions\ProductNotFound)
        {
            return apiError($e->getMessage(), [], false, 400);
            
        }

        return parent::render($request, $e);
    }
}