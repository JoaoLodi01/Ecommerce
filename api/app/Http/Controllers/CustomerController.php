<?php

namespace App\Http\Controllers;

use App\Services\CustomerService;
use App\Http\Controllers\Controller;
use App\Http\Requests\Customers\{
    CustomerRequest,
    SearchCustomer
};

use Illuminate\Support\Facades\Log;

class CustomerController extends Controller
{
    public function __construct(
        protected CustomerService $customerService
    ) {}

    public function getAll(int $issuer_id){
        return apiSuccess('Todos os clientes', $this->customerService->getAll($issuer_id));
   
    }

    public function search(SearchCustomer $request){
        $customer = $this->customerService->search($request->validated());
        return apiSuccess('Cliente encontrado', $customer);

    }

    public function create(CustomerRequest $request){
        $customer = $this->customerService->create($request->validated());
        return apiSuccess('Cliente cadastrado com sucesso!', $customer);
        
    }

    public function findByID(int $id){
        return $this->customerService->findByID($id);
    }

    public function update(CustomerRequest $request, int $id){
        $data = $request->validated();
        return $this->customerService->update($data, $id);
        
    }

    public function delete(int $id){
        return $this->customerService->delete($id);
    }

    public function active(int $id)
    {
        return $this->customerService->active($id);
    }
}