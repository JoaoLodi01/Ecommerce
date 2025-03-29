<?php

namespace App\Http\Controllers\EcommerceController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\EcommerceService\ProductsService;
use Illuminate\Support\Facades\Log;

class ProductsController extends Controller
{

    public function __construct(protected ProductsService $productsService){
        $this->productsService = $productsService;
    }

    public function getAll(){
        return $this->productsService->getAll();
    }

    public function search(Request $request){
        return $this->productsService->search($request->all());
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
