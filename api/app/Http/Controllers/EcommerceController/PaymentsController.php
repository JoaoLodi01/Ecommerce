<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Services\EcommerceService\PaymentsService;
use App\Http\Controllers\Controller;

class PaymentsController extends Controller
{
    public function __construct(
        protected PaymentsService $paymentsSaleService
    ) {}

    public function getAll(int $issuer_id){
        return $this->paymentsSaleService->getAll($issuer_id);
    }

    public function store(Request $request){
        $data = $request->validated();
        return $this->paymentsSaleService->store($data);
    }

    public function update(Request $request, int $id){
        $data = $request->validated();
        return $this->paymentsSaleService->update($data, $id);
    }

    public function delete(int $id){
        return $this->paymentsSaleService->delete($id);
    }
}
