<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProductsRequest;
use App\Services\ProductsService;
use Illuminate\Http\Request;

class ProductsController extends Controller
{
    protected $productsService;

    public function __construct(ProductsService $productsService){
        $this->productsService = $productsService;
    }

    public function getAll(){
        return $this->productsService->getAll();
    }

    public function search(ProductsRequest $request){
        return response()->json($request->all());
    }

    public function store(Request $request){
        $data = $request->validated();
        return $this->productsService->store($request->all());
    }

    public function findByID(int $id){
        return $this->productsService->findByID($id);
    }

    public function update(ProductsRequest $request, int $id){
        $data = $request->validated();
        return $this->productsService->update($data, $id);
    }

    public function delete(int $id){
        return $this->productsService->delete($id);
    }
}
