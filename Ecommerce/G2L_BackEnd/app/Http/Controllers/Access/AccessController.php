<?php

namespace App\Http\Controllers\Access;

use App\Http\Controllers\Controller;
use App\Services\RegisterService\RegisterIssuerService;
use Illuminate\Support\Facades\Log;

class AccessController extends Controller
{
   public function __construct(
        protected RegisterIssuerService $registerIssuerService
    ){}


    public function countCompanies(int $id)
    {
        Log::debug($id);
        $companies = $this->registerIssuerService->getAll($id);
        return apiSuccess("Contagem de empresas", count($companies));

    }
}
