<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\ConsumerRequest;
use App\Services\ConsumerService;

class ConsumerController extends Controller
{
    protected $consumerService;

    public function __construct(ConsumerService $consumerService){
        $this->consumerService = $consumerService;
    }

    public function getAll(){
        return $this->consumerService->getAll();
    }

    public function store(ConsumerRequest $request){
        $data = $request->validated();
        return $this->consumerService->store($data);
    }

    public function findByID(int $id){
        return $this->consumerService->findByID($id);
    }

    public function update(ConsumerRequest $request, int $id){
        $data = $request->validated();
        return $this->consumerService->update($data, $id);
    }

    public function delete(int $id){
        return $this->consumerService->delete($id);
    }
}
