<?php

namespace App\Http\Controllers\EcommerceController;

use App\Http\Controllers\Controller;
use App\Http\Requests\Products\{
    ProductsRequest,
    SearchProducts
};

use App\Services\EcommerceService\ProductsService;
use Illuminate\Support\Facades\Log;

class ProductsController extends Controller
{
    public function __construct(protected ProductsService $productsService){
        $this->productsService = $productsService;
    }

    public function getAll(int $issuer_id){
        return $this->productsService->getAll($issuer_id);
    }

    public function search(SearchProducts $request){
        $data = $request->validated();
        Log::info('Controller');
        Log::info($data);
        return $this->productsService->search($data);
    }

    public function create(ProductsRequest $request)
    {
        $data = $request->validated();
        return $this->productsService->create($data);
    }

    public function findByID(int $id){
        return $this->productsService->findByID($id);
    }

    public function findImage(int $id){
        return $this->productsService->findImage($id);
    }

    public function update(ProductsRequest $request, int $id)
    {
        $data = $request->validated();
        Log::info('Data');
        Log::info($data);
        
        return $this->productsService->update($data, $id);
    }

    public function delete(int $id){
        return $this->productsService->delete($id);
    }

    public function allGroup()
    {
        return $this->productsService->allGroup();
    }
}
