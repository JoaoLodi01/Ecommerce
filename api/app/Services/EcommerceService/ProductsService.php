<?php

namespace App\Services\EcommerceService;

use App\Repositories\Eloquent\EcommerceEloquent\ProductsRepository;
use Illuminate\Support\Facades\Log;

class ProductsService
{
    public function __construct(
        protected ProductsRepository $productsRepository
    )
    {}
    
    public function getAll(){
        $all = $this->productsRepository->getAll(1);
        try {
            return response()->json([
                'success' => true,
                'all' => $all
            ], 200);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function search(array $data){
        try {
            return $this->productsRepository->search($data);
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
    }

    public function findByID(int $id){
        return response()->json([
            'success' => true,
            'product' => $this->productsRepository->findByID($id)
        ]);
    }
    
    public function findImage(int $id){
        $this->productsRepository->findImage($id);
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
            return $this->returnResponse($th);
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
            return $this->returnResponse($th);
        }
    }

    public function delete(int $id){
        try {
            $this->productsRepository->delete($id);
            return response()->json(true);
            
        } catch (\Throwable $th) {
            return $this->returnResponse($th);
        }
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
            return $this->returnResponse($th);
        }
    }

    public function returnResponse($th){
        return response()->json([
            'success' => false,
            'th' => $th->getMessage(),
            'line' => $th->getLine(),
            'file' => $th->getFile(),
        ]);
    }
}