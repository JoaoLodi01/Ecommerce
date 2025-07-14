<?php

namespace App\Services\EcommerceService;

use App\Exceptions\IssuerExceptions\IssuerNotFound;
use App\Repositories\Eloquent\EcommerceEloquent\GroupRepository;
use App\Repositories\Eloquent\EcommerceEloquent\ProductsRepository;
use App\Exceptions\ProductsExceptions\ProductNotFound;
use App\Jobs\ProductsJobs\ImportProductsJob;
use App\Repositories\Eloquent\RegisterEloquent\RegisterIssuerRepository;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Log;

class ProductsService
{
    public function __construct(
        protected ProductsRepository $productsRepository,
        protected GroupRepository $groupRepository,
        protected RegisterIssuerRepository $registerIssuerRepository
    ) {}
    
    public function getAll(int $issuer_id){
        $issuer = $this->registerIssuerRepository->find($issuer_id);

        if(!$issuer)
        {
            throw new IssuerNotFound("Emitente não encontrado faça login novamente");

        }

        return $this->productsRepository->getAll($issuer_id);;
    }

    public function search(array $data)
    {
        $product = $this->productsRepository->search($data);    

        if(!$product)
        {
            throw new ProductNotFound("Produto não encontrado");

        }
    
        return $product;
    }

    public function findByID(int $id, int $productCod){
        $product = $this->productsRepository->findByID($id, $productCod);
        return $product;

    }
    
    public function findLastCode(int $id, string|int $barCode)
    {
        $product = $this->productsRepository->findLastCode($id);
        if($product->barcode_internal === $barCode)
        {
            throw new Exception('Código interno já cadastrado');
            
        };

        return $product;

    }
    
    public function create(array $data){
        /* Log::info("Vai chamar checkGTIN");
        $this->checkGTIN($data);*/
        $product = $this->productsRepository->create($data);
        return $product;
    }

    public function update(array $data, int $id){
        $product = $this->productsRepository->update($data, $id);
        return $product;
    }

    public function active(int $id, int $productCod){
        $product = $this->productsRepository->active($id, $productCod);

        if(!$product)
        {
            throw new ProductNotFound("Produto não encontrado");
        }

        return $product;
    }

    public function delete(int $id, int $productCod){
        $product = $this->productsRepository->delete($id, $productCod);

        if(!$product)
        {
            throw new ProductNotFound("Produto não encontrado");
        }

        return $product;
    }

    public function checkGTIN(array $gtin){
        try {
            Log::info("Caiu no checkGTIN");

            $url = 'https://api.cosmos.bluesoft.com.br/gtins/' . $gtin['gtin'] . '.json';
            $agent = 'Cosmos-API-Request';
            $headers = array(
                "Content-Type: application/json",
                "X-Cosmos-Token:".env('BLUESOFT_TOKEN')
            );

            $curl = curl_init($url);
            curl_setopt($curl, CURLOPT_USERAGENT, $agent);
            curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_FAILONERROR, true);

            $data = curl_exec($curl);
            if ($data === false || $data == NULL) {
                var_dump(curl_error($curl));
            } else {
                $object = json_decode($data);

                var_dump($object);
            }

            curl_close($curl);

            $product = $this->productsRepository->create($gtin);
            return response()->json([
                'success' => true,
                'product' => $product 
            ], 201);

        } catch (\Throwable $th) {
        }
    }

    public function allGroup()
    {
        return $this->groupRepository->all();
    }

    public function importProducts(object $file, int $issuerID)
    {
        Log::debug('Caiu no import service');
        $fileName = $file->getClientOriginalName();
        $extension = $file->getClientOriginalExtension();
        
        $date = new Carbon();
        $directory = storage_path("files/{$issuerID}/products/" . $date->format('Y-m-d'));

        if(!is_dir($directory))
        {
            mkdir($directory, 0755, true);

        }

        $file->move($directory, $fileName);
        
        //$path = public_path('files/' . $file->getClientOriginalName());
        //unlink($path);
        $filePath = $directory . DIRECTORY_SEPARATOR . $fileName;
        $importJob = ImportProductsJob::dispatch($filePath, $issuerID, $extension);
        
        if(!$importJob)
        {
            Log::warning('Erro no Job');
            return;
        };
        return $directory . DIRECTORY_SEPARATOR . $fileName;
    }
}