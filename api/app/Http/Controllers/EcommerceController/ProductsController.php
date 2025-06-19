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
    public function __construct(
        protected ProductsService $productsService
    ){}

    public function getAll(int $issuer_id){
        return $this->productsService->getAll($issuer_id);
    }

    public function search(SearchProducts $request)
    {        
        $product = $this->productsService->search($request->validated());
        return apiSuccess('Produto encontrado!', $product);
        
    }

    public function create(ProductsRequest $request)
    {
        $data = $request->validated();
        Log::info('Data');
        Log::info($data);
        return $this->productsService->create($data);
    }

    public function findByID(string|int $id){
        Log::info('findByID . ' . $id . ' type: ' . gettype($id));
        return $this->productsService->findByID($id);
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
