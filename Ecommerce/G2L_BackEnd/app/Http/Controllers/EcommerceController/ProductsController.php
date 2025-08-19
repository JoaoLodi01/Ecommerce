<?php

namespace App\Http\Controllers\EcommerceController;

use App\Http\Controllers\Controller;
use App\Http\Requests\Products\{
    ImportProductsRequest,
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

    public function getAll(int $issuerID)
    {
        Log::debug($issuerID);
        return apiSuccess('Todos os produtos', $this->productsService->getAll($issuerID));
    }

    public function search(SearchProducts $request)
    {        
        $product = $this->productsService->search($request->validated());
        return apiSuccess('Produto encontrado!', $product);
        
    }

    public function create(ProductsRequest $request)
    {
        return apiSuccess('Produto criado com sucesso', $this->productsService->create($request->validated()));
    }

    public function findByID(int $id, int $productCod){
        return apiSuccess('Produto encontrado', $this->productsService->findByID($id, $productCod));
    }
    
    public function findLastCode(int $id, string|int $barCode){
        return apiSuccess('Produto encontrado', $this->productsService->findLastCode($id, $barCode));
    }

    public function update(ProductsRequest $request, int $id)
    {
        Log::debug($request->validated());
        return apiSuccess('Produto alterado com sucesso!', $this->productsService->update($request->validated(), $id));
    }

    public function active(int $id, int $productCod)
    {
        return apiSuccess("Produto ativado com sucesso!", $this->productsService->active($id, $productCod));
    }

    public function delete(int $id, int $productCod)
    {
        return apiSuccess("Produto desativado com sucesso!", $this->productsService->delete($id, $productCod));
    }

    public function allGroup()
    {
        return $this->productsService->allGroup();
    }

    public function importProducts(ImportProductsRequest $request, int $issuerID)
    {        
        return apiSuccess('Arquivo recebido com sucesso!', $this->productsService->importProducts($request->file('importFile'), $issuerID));

    }

    public function downloadDefaultFile()
    {
        Log::debug('Vai fazer o download ');
        $filePath = storage_path('files/default_file/Padrão_Importação_Produtos.xlsx');
        $fileName = "Padrão_Importação_Produtos.xlsx";
        
        return response()->download($filePath, $fileName, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',

        ]);
    }
}
