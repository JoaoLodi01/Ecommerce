<?php

namespace App\Http\Controllers\EcommerceController;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Services\EcommerceService\ReceiveService;
use App\Http\Requests\ReceiveRequest;
use Illuminate\Support\Facades\Log;

class ReceiveController extends Controller
{
    public function __construct(
        protected ReceiveService $receiveService
    ){}

    public function getAll(int $issuer_id){
        return apiSuccess('Todas as parcelas receber', $this->receiveService->getAll($issuer_id));
    }

    public function create(ReceiveRequest $request){
        $data = $request->validated();
        return $this->receiveService->create($data);
        Log::info('Caiu no controller');
    }

    public function findByID(int $id){
        return $this->receiveService->findByID($id);
    }

    public function update(ReceiveRequest $request, int $id){
        $data = $request->validated();
        return $this->receiveService->update($data, $id);
    }

    public function delete(int $id){
        return $this->receiveService->delete($id);
    }
}