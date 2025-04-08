<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\CustomerService;
use App\Http\Controllers\Controller;
use App\Http\Requests\Customers\{
    CostumerRequest,
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
        return $this->customerService->search($data['search']);
    }

    public function create(CostumerRequest $request){
        $data = $request->validated();
        return $this->customerService->create($data);
    }

    public function findByID(int $id){
        return $this->customerService->findByID($id);
    }

    public function update(CostumerRequest $request, int $id){
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