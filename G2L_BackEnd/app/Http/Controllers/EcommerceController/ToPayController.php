<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Services\EcommerceService\ToPayService;

//use App\Http\Requests\Request;

class ToPayController extends Controller
{
    public function __construct(
        protected ToPayService $toPayService
    ){}

    public function getAll(int $issuer_id){
        return apiSuccess('Todas as parcelas do pagar', $this->toPayService->getAll($issuer_id));
    }

    public function create(Request $request){
        $data = $request->validated();
        return $this->toPayService->create($data);
    }

    public function findByID(int $id){
        return $this->toPayService->findByID($id);
    }

    public function update(Request $request, int $id){
        $data = $request->validated();
        return $this->toPayService->update($data, $id);
    }

    public function delete(int $id){
        return $this->toPayService->delete($id);
    }
}