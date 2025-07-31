<?php

namespace App\Http\Controllers\Customers;

use App\Http\Controllers\Controller;

use App\Http\Requests\Customers\{
    CustomerMonthlyFeeRequest,
    CustomerSerialRequest,
    CustomerRequest

};

use App\Services\Customers\CustomerService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class CustomerController extends Controller
{
    public function __construct(
        protected CustomerService $customerService
    )
    {}

    public function all()
    {
        return apiSuccess('Todos os clientes', $this->customerService->all());
    }

    public function create(CustomerRequest $request)
    {
        return apiSuccess('Cliente cadastrado com sucesso!', $this->customerService->create($request->validated()));

    }
    
    public function liberations(int $id)
    {
        return apiSuccess('Liberações!', $this->customerService->liberations($id));

    }

    public function update(CustomerRequest $data, int $id)
    {
        
    }
    
    public function updateMonthlyFee(CustomerMonthlyFeeRequest $request, int $id)
    {
        $data = $request->validated();
        return apiSuccess('Preço da mensalidade alterado com sucesso!', $this->customerService->updateMonthlyFee($data['newValue'], $id));
        
    }

    public function updateSerial(CustomerSerialRequest $request, int $id)
    {
        Log::info($request->all());
        $data = $request->validated();
        return apiSuccess('Liberação alterada com sucesso!', $this->customerService->updateSerial($data, $id));
        
    }

    public function find(int $id)
    {
        return apiSuccess('Cliente encontrado!', $this->customerService->find($id));
    }
}
