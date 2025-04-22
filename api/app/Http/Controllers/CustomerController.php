<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
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
    )
    {}

    public function getAll(){
        return $this->customerService->getAll();
        
    }

    public function search(SearchCustomer $request){
        $data = $request->validated();
        Log::info($data);
        return $this->customerService->search($data);
    }

    public function create(CustomerRequest $request){
        $data = $request->validated();
        Log::info('Dados recebidos: ');
        Log::info($data);
        return $this->customerService->create($data);
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