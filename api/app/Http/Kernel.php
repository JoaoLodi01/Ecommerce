<?php

namespace App\Http;

class Kernel
{
    protected $middleware = [
        \Illuminate\Http\Middleware\HandleCors::class

    ];
}