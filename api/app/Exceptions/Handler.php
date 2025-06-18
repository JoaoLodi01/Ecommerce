<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;
use App\Exceptions\InsufficientPayment;

class Handler extends ExceptionHandler
{
    public function register(): void
    {
        $this->renderable(function (InsufficientPayment $e, $request) {
            dd('Entrou no renderable');
            
            return apiError($e->getMessage(), [], false, 400);
        });
    }


}