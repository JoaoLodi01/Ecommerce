<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\CostumerRequest;
use App\Services\CustomerService;

class CustomerController extends Controller
{
    public function __construct(
        protected CustomerService $costumerService
    )
    {
        $this->costumerService = $costumerService;
    }

    public function getAll(){
        return $this->costumerService->getAll();
    }

    public function store(CostumerRequest $request){
        $data = $request->validated();
        return $this->costumerService->store($data);
    }

    public function findByID(int $id){
        return $this->costumerService->findByID($id);
    }

    public function update(CostumerRequest $request, int $id){
        $data = $request->validated();
        return $this->costumerService->update($data, $id);
    }

    public function delete(int $id){
        return $this->costumerService->delete($id);
    }
}
