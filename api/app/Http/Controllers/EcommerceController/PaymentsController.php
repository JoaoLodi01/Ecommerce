<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Services\PaymentsService;
use App\Http\Controllers\Controller;

class PaymentsController extends Controller
{
    protected $paymentsService;

    public function __construct(PaymentsService $paymentsService){
        $this->paymentsService = $paymentsService;
    }

    public function getAll(){
        return $this->paymentsService->getAll();
    }

    public function store(Request $request){
        $data = $request->validated();
        return $this->paymentsService->store($data);
    }

    public function findByID(int $id){
        return $this->paymentsService->findByID($id);
    }

    public function update(Request $request, int $id){
        $data = $request->validated();
        return $this->paymentsService->update($data, $id);
    }

    public function delete(int $id){
        return $this->paymentsService->delete($id);
    }
}
