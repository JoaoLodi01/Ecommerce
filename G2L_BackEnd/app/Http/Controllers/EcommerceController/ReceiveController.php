<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use App\Http\Requests\Financial\Receive\CreateReceiveRequest;
use App\Http\Requests\Financial\Receive\PayInstallmentRequest;
use App\Http\Requests\Financial\Receive\UndoInstallmentRequest;
use App\Services\EcommerceService\ReceiveService;

class ReceiveController extends Controller
{
    public function __construct(
        protected ReceiveService $receiveService
    ){}

    public function getOne(string $document){
        return apiSuccess('Somente as primeiras parcelas', $this->receiveService->getOne($document));
        Log::info($document);
    }

    public function getAll(int $issuer_id){
        return apiSuccess('Todas as parcelas receber', $this->receiveService->getAll($issuer_id));
    }

    public function create(CreateReceiveRequest $request){
        return apiSuccess('Cadastro: ', $this->receiveService->create($request->validated()));
    }

    public function findByID(int $id){
        return $this->receiveService->findByID($id);
    }

    public function update(CreateReceiveRequest $request, int $id){
        $data = $request->validated();
        return $this->receiveService->update($data, $id);
    }

    public function payInstallment(PayInstallmentRequest $request, int $id){
        $data = $request->validated();
        return $this->receiveService->payInstallment($data, $id);
    }

    public function undoInstallment(UndoInstallmentRequest $request, int $id){
        $data = $request->validated();
        return $this->receiveService->undoInstallment($data, $id);
    }

    public function delete(int $id){
        return $this->receiveService->delete($id);
    }
}