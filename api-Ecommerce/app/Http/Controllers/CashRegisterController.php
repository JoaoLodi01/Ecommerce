<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\CashRegisterRequest;
use App\Services\CashRegisterService;

class CashRegisterController extends Controller
{
    protected $cashRegisterService;

    public function __construct(CashRegisterService $cashRegisterService){
        $this->cashRegisterService = $cashRegisterService;
    }

    public function getAll(){
        return $this->cashRegisterService->getAll();
    }

    public function store(CashRegisterRequest $request){
        $data = $request->validated();
        return $this->cashRegisterService->store($data);
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
