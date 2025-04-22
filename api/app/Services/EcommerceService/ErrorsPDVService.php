<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\ErrorsPDVRepository;

class ErrorsPDVService
{
    public function __construct(
        protected ErrorsPDVRepository $errorsPDVRepository
    ){}

    public function getAll()
    {
        return response()->json([
            'success' => true,
            'all' => $this->errorsPDVRepository->getAllErros()

        ], 200);
    }
}