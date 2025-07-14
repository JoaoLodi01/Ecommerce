<?php

namespace App\Http\Controllers\EcommerceController;

use App\Http\Controllers\Controller;
use App\Http\Requests\CashRegisterRequest;
use App\Services\EcommerceService\CashRegisterService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class CashRegisterController extends Controller
{
    public function __construct(
        protected CashRegisterService $cashRegisterService
    ) {}

    public function getAll(int $issuer_id){
        $cash = $this->cashRegisterService->getAll($issuer_id);
        return apiSuccess('Dados do caixa', $cash);
    }

    public function store(CashRegisterRequest $request){
        $data = $request->validated();
        $sla[] = $data;
        return $this->cashRegisterService->create($sla);
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
