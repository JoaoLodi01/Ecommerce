<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;
use App\Exceptions\InsufficientPayment;
use Illuminate\Support\Facades\Log;

class Handler extends ExceptionHandler
{

    public function register(): void
    {
        Log::info('Passou no register');
        $this->renderable(function (InsufficientPayment $e, $request) {
            return apiError($e->getMessage(), [], false, 400);
        });
    }

    public function render($request, Throwable $e) 
    {
        if($e instanceof InsufficientPayment)
        {
            return apiError($e->getMessage(), [], false, 400);

        }
        
        return parent::render($request, $e);
    }
}