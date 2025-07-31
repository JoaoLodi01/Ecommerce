<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use App\Http\Requests\Financial\Receive\UpdateInstallmentsRequest;
use App\Http\Requests\Financial\Receive\ReceiveRequest;
use App\Services\EcommerceService\ReceiveService;

class ReceiveController extends Controller
{
    public function __construct(
        protected ReceiveService $receiveService
    ){}

    public function getOne(int $document){
        return apiSuccess('Somente as primeiras parcelas', $this->receiveService->getOne($document));
    }

    public function getAll(int $issuer_id){
        return apiSuccess('Todas as parcelas receber', $this->receiveService->getAll($issuer_id));
    }

    public function create(ReceiveRequest $request){
        return apiSuccess('Cadastro: ', $this->receiveService->create($request->validated()));
    }

    public function findByID(int $id){
        return $this->receiveService->findByID($id);
    }

    public function update(ReceiveRequest $request, int $id){
        $data = $request->validated();
        return $this->receiveService->update($data, $id);
    }

    public function updateInstallment(UpdateInstallmentsRequest $request, int $id){
        $data = $request->validated();
        return $this->receiveService->updateInstallment($data, $id);
    }

    public function delete(int $id){
        return $this->receiveService->delete($id);
    }
}