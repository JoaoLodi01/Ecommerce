<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\CostumerRequest;
use App\Services\CustomerService;

class CustomerController extends Controller
{
    public function __construct(
        protected CustomerService $custumerService
    )
    {
        $this->custumerService = $custumerService;
    }

    public function getAll(){
        return $this->custumerService->getAll();
    }

    public function selectClient(Request $request){
        return $this->custumerService->selectClient($request->all());
    }

    public function store(CostumerRequest $request){
        $data = $request->validated();
        return $this->custumerService->store($data);
    }

    public function findByID(int $id){
        return $this->custumerService->findByID($id);
    }

    public function update(CostumerRequest $request, int $id){
        $data = $request->validated();
        return $this->custumerService->update($data, $id);
    }

    public function delete(int $id){
        return $this->custumerService->delete($id);
    }
}
