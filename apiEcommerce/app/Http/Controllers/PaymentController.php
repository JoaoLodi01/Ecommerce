<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Services\PaymentService;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    protected $paymentService;

    public function __construct(PaymentService $paymentService){
        $this->paymentService = $paymentService;
    }

    public function getAll(){
        return $this->paymentService->getAll();
    }

    public function store(PaymentRequest $request, int $id){
        $data = $request->validated();
        return $this->paymentService->store($data, $id);
    }

    public function findByID(int $id){
        return $this->paymentService->findByID($id);
    }

    public function update(PaymentRequest $request, int $id){
        $data = $request->validated();
        return $this->paymentService->update($data, $id);
    }

    public function delete(int $id){
        return $this->paymentService->delete($id);
    }

}
