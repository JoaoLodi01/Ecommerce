<?php

namespace App\Http\Controllers\Customers;

use App\Http\Controllers\Controller;
use App\Http\Requests\Customers\CustomerRequest;
use App\Services\Customers\CustomerService;
use Illuminate\Support\Facades\Log;

class CustomerController extends Controller
{
    public function __construct(
        protected CustomerService $customerService
    )
    {}

    public function all()
    {
        return apiSuccess($this->customerService->all());
    }

    public function create(CustomerRequest $request)
    {
        Log::debug('Caiu aqi'); 
        return apiSuccess($this->customerService->create($request->validated()));

    }
}
