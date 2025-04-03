<?php

namespace App\Repositories\Eloquent\EcommerceEloquent;

use App\Models\EcommerceModels\Products;

use Illuminate\Support\Facades\Log;

class ProductsRepository
{
    public function getAll(int $active){
        //return Products::where('active', $active)->get();
        return Products::paginate(10);
    }

    public function search(array $data)
    {
        Log::info('Dados recebidos');
        Log::info($data);
        $products = Products::where('active', 1)
                    ->where('product', 'like', '%' . $data['params'] . '%')
                    ->get();

        Log::info('O que achou: ');
        Log::info($products);

        return $products;
    }

    public function findByID(int $id){
        return Products::where('id', $id)->first();
    }

    public function create(array $data)
    {
        $group = $this->groupsRepository->findByID($data['groupID']);
        return Products::create([
            'product' => $data['product'],
            'amount' => $data['amount'],
            'group_id' => $group->id,
            'group' => $group->group,
             
        ]);
    }

    public function update(array $data, int $id){
        return Products::where('id', $id)->update($data, $id);
    }

    public function delete(int $id){
        return Products::where('id', $id)->update([
            'active' => 0,
        ]);
    }

    public function decreaseQuantiy(int $id, float|int $quantiy)
    {
        Log::info('-- Inicio decreaseQuantiy, linha 50 --');
        $product = $this->findByID($id);
        if($product)
        {
            Log::info('Produto encontrado ' . $product->id);
            Log::info($product);
            $product->update([
                'amount' => $product->amount - $quantiy
            ]);
            
        }

        Log::info('-- Fim decreaseQuantiy, linha 62 --');
    }

        
}