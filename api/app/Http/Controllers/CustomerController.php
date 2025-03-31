<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\CustomerService;
use App\Http\Controllers\Controller;
use App\Http\Requests\CostumerRequest;

class CustomerController extends Controller
{
    public function __construct(
        protected CustomerService $customerService
    )
    {}

    public function getAll(){
        return $this->customerService->getAll();
    }

    public function selectClient(Request $request){
        return $this->customerService->selectClient($request->all());
    }

    public function store(CostumerRequest $request){
        $data = $request->validated();
        return $this->customerService->store($data);
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
}
