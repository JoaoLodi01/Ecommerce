<?php

namespace App\Http\Controllers;

use App\Services\CustomerService;
use App\Http\Controllers\Controller;
use App\Http\Requests\Customers\{
    CustomerRequest,
    ImportCustomerRequest,
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
        Log::info($request->validated());
        $customer = $this->customerService->create($request->validated());
        return apiSuccess('Cliente cadastrado com sucesso!', $customer);
        
    }

    public function findByID(int $id){
        return apiSuccess('Cliente encontrado', $this->customerService->findByID($id));
    }

    public function update(CustomerRequest $request, int $id){
        $this->customerService->update($request->validated(), $id);

        return apiSuccess('Cliente alterado com sucesso!', $this->findByID($id));
        
    }

    public function delete(int $id){
        return apiSuccess('Cliente desativado com sucesso!', $this->customerService->delete($id));
    }

    public function active(int $id)
    {
        return apiSuccess('Cliente ativado com sucesso!', $this->customerService->active($id));
    }

    public function importCustomers(ImportCustomerRequest $request, int $issuerID)
    {
        return apiSuccess('Arquivo recebido com sucesso!', $this->customerService->importCustomers($request->file('importFile'), $issuerID));

    }
}