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

    public function getAll(int $issuer_id)
    {
        return apiSuccess('Todos os produtos', $this->productsService->getAll($issuer_id));
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
        Log::info('função findByID . ' . $id . ' type: ' . gettype($id));
        return $this->productsService->findByID($id);
    }

    public function update(ProductsRequest $request, int $id)
    {
        $data = $request->validated();
        Log::info('Data');
        Log::info($data);
        
        return $this->productsService->update($data, $id);
    }

    public function active(int $id)
    {
        return apiSuccess("Produto ativado com sucesso!", $this->productsService->active($id));
    }

    public function delete(int $id)
    {
        return apiSuccess("Produto ativado com sucesso!", $this->productsService->delete($id));
    }

    public function allGroup()
    {
        return $this->productsService->allGroup();
    }

    public function downloadDefaultFile()
    {
        Log::debug('Vai fazer o download ');
        $filePath = storage_path('files/default_file/Padrão_Importação.xlsx');
        $fileName = "Padrão_Importação.xlsx";
        
        return response()->download($filePath, $fileName, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',

        ]);
    }

    public function importProducts(ImportProductsRequest $request, int $issuerID)
    {        
        Log::debug('Caiu no import controller');
        return apiSuccess('Arquivo recebido com sucesso!', $this->productsService->importProducts($request->file('importFile'), $issuerID));

    }
}
