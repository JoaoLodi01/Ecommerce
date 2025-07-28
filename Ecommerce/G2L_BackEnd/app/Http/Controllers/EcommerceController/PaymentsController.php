<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Services\EcommerceService\PaymentsService;
use App\Http\Controllers\Controller;
use App\Http\Requests\PayMentForm\PayMentFormRequest;

class PaymentsController extends Controller
{
    public function __construct(
        protected PaymentsService $paymentsService
    )
    {}

    public function getAll(int $issuerID){
        return apiSuccess('Todas as espécies de pagamento!', $this->paymentsService->getAll($issuerID));
    }

    public function create(PayMentFormRequest $request){
        $data = $request->validated();
        return $this->paymentsService->create($data);
    }

    public function findOneByID(int $issuerID, int $code)
    {
        return apiSuccess('Espécie', $this->paymentsService->findOneByID($issuerID, $code));
    }

    public function findKey(int $issuer_id)
    {
        return $this->paymentsService->findKey($issuer_id);
    }

    public function update(Request $request, int $id){
        $data = $request->validated();
        return $this->paymentsService->update($data, $id);
    }

    public function delete(int $id){
        return $this->paymentsService->delete($id);
    }
}
