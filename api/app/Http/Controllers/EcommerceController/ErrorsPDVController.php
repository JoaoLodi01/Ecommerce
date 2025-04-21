<?php

namespace App\Http\Controllers\EcommerceController;

use App\Http\Controllers\Controller;
use App\Services\EcommerceService\ErrorsPDVService;
use Illuminate\Http\Request;

class ErrorsPDVController extends Controller
{
    public function __construct(
        protected ErrorsPDVService $errorsPDVService
    ){}

    public function all()
    {
        return $this->errorsPDVService->getAll();
    }
}
