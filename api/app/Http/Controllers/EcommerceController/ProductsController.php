<?php

namespace App\Http\Controllers\EcommerceController;

use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Services\EcommerceService\ProductsService;

class ProductsController extends Controller
{
    protected $productsService;

    public function __construct(ProductsService $productsService){
        $this->productsService = $productsService;
    }

    public function getAll(){
        return $this->productsService->getAll();
    }

    public function search(Request $request){
        return $this->productsService->findByID('a');
        
    }

    public function store(Request $request){
        return $this->productsService->store($request->all());
    }

    public function findByID(int $id){
        return $this->productsService->findByID($id);
    }

    public function update(Request $request, int $id){
        return $this->productsService->update($request->all(), $id);
    }

    public function delete(int $id){
        return $this->productsService->delete($id);
    }
}
