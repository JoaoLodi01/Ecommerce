<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Products;
use Illuminate\Support\Facades\Log;

class ProductsRepository
{
    public function getAll(int $active){
        return Products::where('active', $active)->get();
    }

    public function search(array $data)
    {
        Log::info('Dados recebidos');
        Log::info($data);
        $products = Products::where('active', 1)
                    ->where('produto', 'like', '%' . $data['params'] . '%')
                    ->get();

        Log::info('O que achou: ');
        Log::info($products);

        return $products;
    }

    public function findByID(int $id){
        return Products::where('id', $id)->first();
    }

    public function store(array $data){
        return Products::create($data);
    }

    public function update(array $data, int $id){
        return Products::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Products::where('id', $id)->update([
            'active' => 0,
        ]);
    }
}