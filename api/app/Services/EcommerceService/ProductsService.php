<?php

namespace App\Services\EcommerceService;

use App\Exceptions\ProductNotFound;
use App\Repositories\Eloquent\EcommerceEloquent\GroupRepository;
use App\Repositories\Eloquent\EcommerceEloquent\ProductsRepository;
use Illuminate\Support\Facades\Log;

class ProductsService
{
    public function __construct(
        protected ProductsRepository $productsRepository,
        protected GroupRepository $groupRepository
    )
    {}
    
    public function getAll(int $issuer_id){
        $all = $this->productsRepository->getAll($issuer_id);
        try {
            return response()->json([
                'success' => true,
                'all' => $all
            ], 200);
        } catch (\Throwable $th) {
            
        }
    }

    public function search(array $data)
    {
        $product = $this->productsRepository->search($data);    

        if(!$product)
        {
            throw new \App\Exceptions\ProductNotFound("Produto não encontrado");

        }
    
        return $product;
    }

    public function findByID(int $id){
        return response()->json([
            'success' => true,
            'product' => $this->productsRepository->findByID($id)
        ]);
    }
    
    public function create(array $data){
        try {
           /* Log::info("Vai chamar checkGTIN");
            $this->checkGTIN($data);*/
            $product = $this->productsRepository->create($data);
            return response()->json([
                'success' => true,
                'product' => $product 
            ], 201);

        } catch (\Throwable $th) {
            
        }
    }

    public function update(array $data, int $id){
        try {
            $product = $this->productsRepository->update($data, $id);
            return response()->json([
                'success' => true,
                'product' => $product
            ], 200);

        } catch (\Throwable $th) {
            
        }
    }

    public function active(int $id){
        $product = $this->productsRepository->active($id);

        if(!$product)
        {
            throw new ProductNotFound("Produto não encontrado");
        }

        return $product;
    }

    public function delete(int $id){
        $product = $this->productsRepository->delete($id);

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
}