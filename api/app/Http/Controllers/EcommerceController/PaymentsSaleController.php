<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Services\EcommerceService\PaymentsService;
use App\Http\Controllers\Controller;

class PaymentsSaleController extends Controller
{
    protected $paymentsSaleService;

    public function __construct(PaymentsService $paymentsSaleService){
        $this->paymentsSaleService = $paymentsSaleService;
    }

    public function getAll(){
        return $this->paymentsSaleService->getAll();
    }

    public function store(Request $request){
        $data = $request->validated();
        return $this->paymentsSaleService->store($data);
    }

    public function findByID(int $id){
        return $this->paymentsSaleService->findByID($id);
    }

    public function update(Request $request, int $id){
        $data = $request->validated();
        return $this->paymentsSaleService->update($data, $id);
    }

    public function delete(int $id){
        return $this->paymentsSaleService->delete($id);
    }
}
