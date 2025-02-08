<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\StorageRequest;
use App\Services\StorageService;

class Storage extends Controller
{
    protected $storageService;

    public function __construct(StorageService $storageService){
        $this->storageService = $storageService;
    }

    public function getAll(){
        return $this->storageService->getAll();
    }

    public function store(StorageRequest $request){
        $data = $request->validated();
        return $this->storageService->store($data);
    }

    public function show(int $id){
        return $this->storageService->findByID($id);
    }

    public function update(StorageRequest $request, int $id){
        $data = $request->validated();
        return $this->storageService->update($data, $id);
    }

    public function delete(int $id){
        return $this->storageService->delete($id);
    }
}
