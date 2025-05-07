<?php

namespace App\Http\Controllers\EcommerceController;

use App\Http\Controllers\Controller;
use App\Http\Requests\CashRegisterRequest;
use App\Services\EcommerceService\CashRegisterService;
use Illuminate\Http\Request;

class CashRegisterController extends Controller
{
    public function __construct(
        protected CashRegisterService $cashRegisterService
    ) {}

    public function getAll(){
        return $this->cashRegisterService->getAll();
    }

    public function store(CashRegisterRequest $request){
        $data = $request->validated();
        return $this->cashRegisterService->create($data);
    }

    public function findByID(int $id){
        return $this->cashRegisterService->findByID($id);
    }

    public function update(CashRegisterRequest $request, int $id){
        $data = $request->validated();
        return $this->cashRegisterService->update($data, $id);
    }

    public function delete(int $id){
        return $this->cashRegisterService->delete($id);
    }
}
